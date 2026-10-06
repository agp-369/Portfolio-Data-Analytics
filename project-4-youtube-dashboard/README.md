# Project 4: Data Analyst Dashboard (Sales Analysis)

## Overview
This project demonstrates creating an interactive dashboard to analyze sales data. It showcases data preparation, KPI calculation, and dashboard design skills using Power BI/Tableau style storytelling. For GitHub portfolio visibility, this project includes:

- A clean dataset prepared for visualization
- SQL queries used to extract and aggregate data (reusing the proven AlexTheAnalyst style approach)
- Sample visualizations exported from analysis
- Documentation with key insights and suggested dashboard layout

**Skills Demonstrated:**
- SQL (joins, aggregations, CTEs, date functions)
- Data Modeling & Preparation
- Dashboard Design (KPIs, trends, segmentation)
- Business Insights
- Excel/Power BI/Tableau aware workflow

## Repository Structure
- `README.md` - Project documentation
- `sales_dashboard_queries.sql` - SQL queries to build the analysis
- `outputs/` - Exported charts/tables
- `data/` - Cleaned sample data (if included)

## Suggested Dashboard (Power BI/Tableau)
| Visual | Purpose |
|---|---|
| KPI Cards | Total Sales, Total Profit, Orders, Avg Order Value |
| Line Chart | Sales trend over time (Monthly/Quarterly) |
| Bar Chart | Top Products by Sales/Profit |
| Donut/Clustered | Category/Segment breakdown |
| Map (optional) | Regional performance |
| Table | Drill-down details |

## Key Metrics
- **Total Sales** = SUM(Sales)
- **Total Profit** = SUM(Profit)
- **Order Count** = COUNT(DISTINCT Order ID)
- **AOV** = Total Sales / Order Count
- **Profit Margin %** = (Total Profit / Total Sales) * 100

## How to Reproduce
1. Use `sales_dashboard_queries.sql` in your SQL environment (SQL Server/SQLite)
2. Load results into Power BI, Tableau, or Excel
3. Build visuals following the suggested layout above

## Tools
- SQL (T-SQL/SQLite compatible)
- Power BI / Tableau / Looker Studio
- Git/GitHub
- Python (for quick EDA if needed)
