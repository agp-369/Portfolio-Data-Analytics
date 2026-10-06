# Portfolio - Data Analytics

A professional, recruiter-ready portfolio showcasing end-to-end data analytics projects. Built following industry best practices (Alex The Analyst style) with clean documentation, reproducible code, and exportable artifacts.

[![GitHub last commit](https://img.shields.io/github/last-commit/agp-369/Portfolio-Data-Analytics)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)]()

## About Me

I’m a BCA student with strong technical foundations in Python, SQL, Linux, Docker, and data analysis. I enjoy solving real problems with data and building reproducible, business-focused analysis. This portfolio demonstrates practical experience across the full analytics workflow: data cleaning, exploratory analysis, statistical insight, and dashboard-ready outputs.

**Core Skills:** Python (Pandas, NumPy, Matplotlib, Seaborn), SQL (Joins, CTEs, Window Functions, Aggregations), Data Visualization (Power BI/Tableau-ready exports), Git, Excel

## Projects

| # | Project | Tools | Focus | Key Artifacts |
|---|---|---|---|---|
| 1 | **[COVID-19 Data Exploration](./project-1-covid-sql-exploration/)** | SQL (SQLite), Python | Data Exploration & Aggregations | Joins, CTEs, Window Functions, rolling vaccination % |
| 2 | **[Nashville Housing Data Cleaning](./project-2-nashville-housing-cleaning/)** | SQL (SQLite), Python | Data Cleaning & Standardization | Address parsing, deduplication, NULL backfill, audit trail |
| 3 | **[TMDB Movies Data Analysis](./project-3-movies-data-analysis/)** | Python (Pandas, Seaborn, Matplotlib) | EDA & Visualization | Correlations, revenue vs budget, genre trends, exports in `outputs/` |
| 4 | **[Global YouTube Statistics Dashboard](./project-4-youtube-dashboard/)** | SQL (SQLite), Python | KPIs & Dashboard Prep | 10+ SQL aggregates, country/channel KPIs, Power BI/Tableau-ready CSVs |

## Project Highlights

**Project 1 – COVID-19 Exploration**  
Analyzed global COVID-19 trends (cases, deaths, vaccinations). Used window functions to compute rolling people vaccinated, CTEs for calculations, and exported clean CSVs for visualization.

**Project 2 – Nashville Housing Cleaning**  
Transformed 56K+ messy property records into analysis-ready data. Standardized dates, parsed addresses, backfilled NULLs via self-joins, normalized categorical values, and removed duplicates with a transparent audit trail.

**Project 3 – TMDB Movies Analysis**  
Explored 4.8K movies to uncover patterns between budget, revenue, popularity, and genres. Found a strong positive correlation between budget and revenue (r≈0.73), identified top genres, and produced publication-quality charts.

**Project 4 – YouTube Global Stats**  
Aggregated 995 top YouTube channels to build dashboard-ready KPIs (global subscribers, views, uploads, AOV-like reach metrics). Segmented by country, category, and channel type for executive-level insights.

## Data Sources

- [Our World in Data – COVID-19](https://ourworldindata.org/coronavirus) (via [AlexTheAnalyst/PortfolioProjects](https://github.com/AlexTheAnalyst/PortfolioProjects))
- [Nashville Housing Data](https://github.com/AlexTheAnalyst/PortfolioProjects) (real estate transactions)
- [TMDB 5000 Movie Dataset](https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata)
- [Global YouTube Statistics](https://www.kaggle.com/datasets/advaypatil/youtube-statistics) (via AlexTheAnalyst)

## Getting Started

1. Clone this repo: `git clone https://github.com/agp-369/Portfolio-Data-Analytics.git`
2. Navigate to any project folder (e.g., `project-1-covid-sql-exploration/`)
3. Follow each project's README for step-by-step reproduction
4. All projects use self-contained SQLite DBs + Python scripts for full reproducibility

## Contact

- **GitHub:** [@agp-369](https://github.com/agp-369)
- **Email:** abhishekagp0489@gmail.com

*Built to showcase practical, job-ready data analytics skills.*