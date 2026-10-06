# Project 1: COVID-19 Data Exploration – SQL

## Business Problem
Understanding infection rates, mortality trends, and vaccination rollout is critical for public health planning. Decision-makers need clean, reproducible metrics (infection % of population, rolling vaccinations, death ratios) to track progress and allocate resources effectively.

## Objectives
- Explore global COVID-19 cases, deaths, and vaccinations using SQL
- Compute infection rates relative to population
- Track rolling vaccination coverage over time
- Present continent/country-level comparisons for reporting

## Data Source
Our World in Data – COVID-19 Deaths & Vaccinations (via AlexTheAnalyst/PortfolioProjects)

## Methodology
- Joins (Deaths ⨝ Vaccinations by location/date)
- CTEs, Temp logic, Window Functions (`SUM(...) OVER PARTITION BY location ORDER BY date`) for rolling counts
- Aggregations, type casting, filtering (continent IS NOT NULL)

## Key Findings
- Infection rates vary significantly by country (top ~10–15% in early peaks)
- Rolling vaccination coverage shows phased rollout by location
- Death percentages differ by region/phase (waves)
- Global totals computed cleanly and reproducibly

## Actionable Recommendations
- **For Policy/Planning:** Track rolling % vaccinated (query_10/view) as a leading indicator to prioritize booster/outreach in low-coverage regions.
- **For Reporting:** Use continent-level aggregates (query_07) for executive summaries, country-level (query_05) for operational targeting.
- **For Analysts:** Prefer window-based rolling metrics over static snapshots to avoid misleading trend visuals in dashboards.
- **For Data Quality:** Exclude non-continent aggregates to prevent double-counting in regional rollups.

## Artifacts
- `covid.db` (SQLite), `queries.sql` (10 analysis queries + VIEW), CSV exports in `results/`

## Tools
SQL (SQLite), Python
