"""
Build the COVID-19 SQLite database from the raw Excel files.
Run: python build_covid_db.py
"""
import sqlite3
import pandas as pd

SRC = "../data_raw"
DB = "covid.db"


def main():
    deaths = pd.read_excel(f"{SRC}/CovidDeaths.xlsx")
    vacc = pd.read_excel(f"{SRC}/CovidVaccinations.xlsx")

    print("Deaths data :", deaths.shape)
    print("Vaccinations:", vacc.shape)

    deaths["date"] = pd.to_datetime(deaths["date"])
    vacc["date"] = pd.to_datetime(vacc["date"])

    conn = sqlite3.connect(DB)
    deaths.to_sql("CovidDeaths", conn, if_exists="replace", index=False)
    vacc.to_sql("CovidVaccinations", conn, if_exists="replace", index=False)
    conn.close()

    print("COVID database created:", DB)


if __name__ == "__main__":
    main()