---
layout: default
title: "Abhishek Gupta | Data Analyst Portfolio"
---

# Abhishek Gupta – Data Analyst Portfolio

**BCA Graduate (2026) | MCA Student (IGNOU, Distance)**

I transform raw, messy datasets into clean, evidence-based insights that answer real business questions. Below are four end-to-end analytics projects with methodology, findings, and reproducible outputs.

## Featured Projects

### 1. [COVID-19 Data Exploration – SQL](./project-1-covid-sql-exploration/)
- **Goal:** Understand global infection, mortality, and vaccination trends using real Our World in Data.
- **Methodology:** SQL Joins, CTEs, Window Functions (rolling sums), aggregations, data type casting.
- **Key Findings:** Computed rolling % population vaccinated by country, infection rate vs population, continent-level death totals, and global case/death ratios.
- **Outcome:** Reproducible SQLite queries + CSV exports for Tableau/Power BI.

### 2. [Nashville Housing – Data Cleaning](./project-2-nashville-housing-cleaning/)
- **Goal:** Convert 56K+ messy real estate records into analysis-ready data.
- **Methodology:** Standardized dates, self-joins to backfill NULL addresses, parsed split columns (address/city/state), CASE normalization, ROW_NUMBER deduplication, audit trail.
- **Key Findings:** Identified/addressed 29 missing property addresses, removed 104 duplicate records, standardized `SoldAsVacant` (Y/N→Yes/No), cleaned column structure.
- **Outcome:** Traceable, reproducible cleaning pipeline with before/after audit.

### 3. [TMDB Movies – Exploratory Data Analysis](./project-3-movies-data-analysis/)
- **Goal:** Explore what drives box office performance using TMDB metadata (4.8K movies).
- **Methodology:** Data cleaning, correlation analysis, distribution analysis, genre extraction (JSON parsing).
- **Key Findings:** **Budget vs Revenue shows a strong positive correlation (r ≈ 0.73)**. Vote count correlates strongly with popularity. Drama/Comedy/Action/Thriller are most frequent. Runtime clusters around 90–120 min. Clear production growth trend over time.
- **Visuals:** [Budget–Revenue](./project-3-movies-data-analysis/outputs/budget_vs_revenue.png), [Correlation](./project-3-movies-data-analysis/outputs/correlation_heatmap.png), [Top Genres](./project-3-movies-data-analysis/outputs/top15_genres.png), [Runtime](./project-3-movies-data-analysis/outputs/runtime_distribution.png).

### 4. [Global YouTube Statistics – Dashboard Prep](./project-4-youtube-dashboard/)
- **Goal:** Derive measurable KPIs from 995 top channels for executive/dashboard use.
- **Methodology:** SQL aggregations, GROUP BY, TOP-N, CTEs, NULL-safe calculations.
- **Key Findings:** **22.9B total subscribers, 11.0T total video views, 9.14M total uploads**. Channels segmented by country, category, channel type. Identified top creators by reach and 30-day view momentum.
- **Outcome:** 10 query outputs (CSV) ready for Power BI/Tableau.

## Technical Skills
Python, SQL (Joins, CTEs, Window Functions), Pandas, NumPy, Matplotlib, Seaborn, SQLite, Linux, Docker, Git, Power BI/Tableau-ready outputs.

## Resume & Contact
- [View Resume](./RESUME.md) | [Download PDF](./assets/Abhishek_Gupta_Resume.pdf)
- [LinkedIn](https://www.linkedin.com/in/abhishekgupta-agp/) | [GitHub](https://github.com/agp-369) | [Email](mailto:abhishekagp0489@gmail.com)