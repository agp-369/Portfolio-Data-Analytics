# Project 2: Nashville Housing – Data Cleaning for Analytics

## Business Problem
Real estate transaction datasets often contain inconsistencies (missing addresses, duplicate records, inconsistent categorical values, poor date formatting). Without proper cleaning, location-based and valuation analyses lead to incorrect business insights. The goal is to transform raw Nashville housing data into a reliable, analysis-ready dataset for reporting and dashboarding.

## Objectives
- Standardize dates and column structure
- Backfill missing property addresses using parcel-level logic
- Parse full addresses into Address/City/State for location analysis
- Normalize categorical fields (`SoldAsVacant`: Y/N → Yes/No)
- Remove duplicate records with a traceable rule
- Drop unused columns and produce audit evidence

## Data Source
Nashville Housing Data (AlexTheAnalyst/PortfolioProjects) – real property transactions.

## Methodology
1. **Inspection** – Profile nulls, types, cardinality
2. **Date Standardization** – Convert sale dates to clean `YYYY-MM-DD`
3. **Address Backfill** – Self-join on `ParcelID` to fill missing `PropertyAddress`
4. **Parsing** – Split property/owner addresses using `SUBSTR`/`INSTR`
5. **Normalization** – CASE to standardize binary labels
6. **Deduplication** – `ROW_NUMBER()` partitioned by (ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference), keep first
7. **Cleanup** – Drop redundant columns, export audit

## Key Findings
- **29** property addresses were missing; successfully backfilled via parcel linkage
- **104** duplicate rows removed with transparent logic
- `SoldAsVacant` standardized from mixed (Y/N/Yes/No) to consistent Yes/No
- Addresses split into granular fields enabling city/state-level aggregation

## Actionable Recommendations
- **For Analysts:** Use `sale_date_converted`, `property_split_city`, `owner_split_state` for time/location filters in Power BI/Tableau to avoid aggregation errors.
- **For Data Governance:** Enforce NOT NULL on critical keys (ParcelID/LegalReference) and prevent free-text duplicates at ingestion.
- **For Business:** Focus dashboard filters on city-level cohorts (most variance lies by location) rather than raw full addresses.

## Reproducibility
- `build_nashville_db.py` – Build SQLite DB from Excel
- `cleaning.sql` – Step-by-step cleaning (matches industry SQL style)
- `run_cleaning.py` – Executes + generates `cleaning_audit.csv`, `nashville_clean.csv`

## Tools
SQL (SQLite), Python, Pandas
