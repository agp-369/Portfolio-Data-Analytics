/*
=====================================================================
 YOUTUBE GLOBAL STATS - SQL FOR DASHBOARD  |  SQL Portfolio Project #4
=====================================================================
 Skills demonstrated: Aggregations, GROUP BY, TOP-N, RANKING,
 CTEs, filtering, NULL handling, date-aware logic, readability

 Database   : SQLite (self-contained, runs anywhere)
 Data source: Global YouTube Statistics (AlexTheAnalyst/PortfolioProjects)
 Reproduce  : python build_yt_db.py then python run_yt_queries.py
=====================================================================
*/

-----------------------------------------------------------------------
-- 0. INSPECT DATA
-----------------------------------------------------------------------
SELECT * FROM YoutubeStats LIMIT 5;

-----------------------------------------------------------------------
-- 1. TOP 10 YOUTUBERS BY SUBSCRIBERS
-----------------------------------------------------------------------
SELECT rank, youtuber, country, subscribers, video_views, uploads
FROM YoutubeStats
ORDER BY subscribers DESC
LIMIT 10;

-----------------------------------------------------------------------
-- 2. TOP 10 YOUTUBERS BY TOTAL VIDEO VIEWS
-----------------------------------------------------------------------
SELECT youtuber, country, channel_type, video_views, subscribers
FROM YoutubeStats
ORDER BY video_views DESC
LIMIT 10;

-----------------------------------------------------------------------
-- 3. CHANNEL TYPE BREAKDOWN - TOTAL SUBSCRIBERS & VIEWS
-----------------------------------------------------------------------
SELECT channel_type, COUNT(*) AS channel_count,
       SUM(subscribers) AS total_subscribers,
       SUM(video_views) AS total_views
FROM YoutubeStats
WHERE channel_type IS NOT NULL
GROUP BY channel_type
ORDER BY total_subscribers DESC;

-----------------------------------------------------------------------
-- 4. TOP COUNTRIES BY TOTAL YOUTUBE REACH (SUBSCRIBERS)
-----------------------------------------------------------------------
SELECT country, COUNT(*) AS channels,
       SUM(subscribers) AS total_subs,
       ROUND(AVG(subscribers)) AS avg_subs_per_channel
FROM YoutubeStats
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_subs DESC
LIMIT 15;

-----------------------------------------------------------------------
-- 5. CATEGORY PERFORMANCE
-----------------------------------------------------------------------
SELECT category, COUNT(*) AS channels,
       SUM(subscribers) AS total_subs,
       SUM(video_views) AS total_views
FROM YoutubeStats
WHERE category IS NOT NULL
GROUP BY category
ORDER BY total_subs DESC
LIMIT 15;

-----------------------------------------------------------------------
-- 6. CONTENT VOLUME - UPLOADS ANALYSIS
-----------------------------------------------------------------------
SELECT youtuber, country, channel_type, uploads, subscribers,
       ROUND(CAST(subscribers AS REAL) / NULLIF(uploads, 0), 2) AS subs_per_upload
FROM YoutubeStats
WHERE uploads > 0
ORDER BY uploads DESC
LIMIT 10;

-----------------------------------------------------------------------
-- 7. RECENT 30-DAY VIEWS INSIGHT (WHERE AVAILABLE)
-----------------------------------------------------------------------
SELECT youtuber, country, channel_type,
       video_views_for_the_last_30_days,
       subscribers
FROM YoutubeStats
WHERE video_views_for_the_last_30_days IS NOT NULL
  AND video_views_for_the_last_30_days > 0
ORDER BY video_views_for_the_last_30_days DESC
LIMIT 10;

-----------------------------------------------------------------------
-- 8. REACH METRICS BY COUNTRY (CTE FOR CLARITY)
-----------------------------------------------------------------------
WITH CountryReach AS (
  SELECT country,
         COUNT(*) AS channels,
         SUM(subscribers) AS total_subs,
         SUM(video_views) AS total_views,
         AVG(subscribers) AS avg_subs
  FROM YoutubeStats
  WHERE country IS NOT NULL
  GROUP BY country
)
SELECT *
FROM CountryReach
ORDER BY total_subs DESC
LIMIT 12;

-----------------------------------------------------------------------
-- 9. DASHBOARD KPIS
-----------------------------------------------------------------------
SELECT
  COUNT(DISTINCT youtuber) AS total_channels,
  SUM(subscribers) AS global_subscribers,
  SUM(video_views) AS global_views,
  SUM(uploads) AS global_uploads,
  ROUND(AVG(subscribers)) AS avg_subscribers_per_channel,
  MAX(subscribers) AS max_subscribers,
  MAX(video_views) AS max_views
FROM YoutubeStats;
