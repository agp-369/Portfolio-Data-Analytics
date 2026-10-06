# Project 3: Movies Data Analysis

## Overview
This project performs exploratory data analysis (EDA) on a dataset of 5,000 TMDB movies. The analysis covers data cleaning, correlation studies, budget vs revenue insights, and genre distributions. Visualizations are produced to support actionable insights.

**Skills Demonstrated:**
- Python, Pandas, NumPy
- Data Cleaning & Wrangling
- Exploratory Data Analysis (EDA)
- Data Visualization (Matplotlib, Seaborn)
- Correlation Analysis

## Dataset
The dataset is `tmdb_5000_movies.csv` from [TMDB 5000 Movie Dataset](https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata). It contains metadata including budget, revenue, genres, runtime, vote_average, vote_count, release_date, and more.

## Repository Structure
- `movies_analysis.ipynb` - Jupyter Notebook containing the full analysis
- `outputs/` - Exported visualizations and summary tables
- `README.md` - This file

## Key Insights
- Budget and revenue show a positive correlation (higher budget tends to correlate with higher revenue).
- Vote count strongly correlates with popularity metrics.
- Genre distributions reveal dominant categories in the dataset.
- Runtime distributions highlight typical movie lengths.

## How to Run
1. Clone the repository
2. Open `movies_analysis.ipynb` in Jupyter Notebook/Lab
3. Run all cells (kernel: Python 3.11+)

## Requirements
```text
pandas>=2.0
numpy>=1.24
matplotlib>=3.7
seaborn>=0.13
jupyter
```