# Project 4: Global YouTube Statistics – Dashboard-Ready Analytics

## Business Problem
Content creators, agencies, and media analysts need data-driven insight into reach, scale, and momentum across YouTube. Without proper KPIs (subscribers, views, uploads, reach by country/category), decisions about niches, markets, and partnerships remain guesswork.

## Objectives
- Build clean, measurable KPIs from top YouTube channels
- Compare performance by channel type, category, and country
- Identify scale leaders and momentum (recent 30-day views)
- Produce Power BI/Tableau-ready CSV outputs

## Data Source
Global YouTube Statistics (AlexTheAnalyst/PortfolioProjects)

## Methodology
SQL aggregations, GROUP BY, TOP-N, CTEs, NULL-safe calculations (`NULLIF`), filtering.

## Key Findings
- **995** channels analyzed
- **22.9B** total subscribers | **11.0T** total video views | **9.14M** total uploads
- Reach concentrated by top countries/categories
- Recent 30-day views highlight momentum beyond lifetime totals
- Clear segmentation by `channel_type` useful for benchmarking

## Actionable Recommendations
- **Market Entry:** Focus expansion in countries with high total reach but fewer top channels (opportunity gap) — validate via `query_04`.
- **Content Strategy:** Benchmark against top channels in same `category` + `channel_type` (use `query_05`, `query_02`) before setting subscriber targets.
- **Partnerships:** Prioritize creators with strong **recent momentum** (`video_views_for_the_last_30_days`) + solid lifetime reach for time-sensitive campaigns (see `query_07`).
- **Content Efficiency:** Use `subs_per_upload` (`query_06`) to spot high-leverage creators (reach per upload) beyond raw subscriber count.
- **Executive Dashboards:** Track KPIs (`query_10`) as core tiles (Total Channels/Subs/Views/Uploads) with country/category slicers.

## Artifacts
- `youtube.db`, `sales_dashboard_queries.sql` (10 queries), CSVs in `outputs/`

## Tools
SQL (SQLite), Python, Pandas
