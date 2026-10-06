"""
Build the Nashville Housing SQLite database from the raw Excel file.
Run: python build_nashville_db.py
"""
import sqlite3
import re
import pandas as pd

SRC = "../data_raw"
DB = "nashville.db"


def main():
    df = pd.read_excel(f"{SRC}/NashvilleHousing.xlsx")
    print("Raw shape:", df.shape)

    def snake(c):
        c = c.strip().replace(" ", "_").replace("[", "").replace("]", "")
        c = c[0].lower() + re.sub(r"(?<=[a-z0-9])(?=[A-Z])", "_", c[1:]).lower()
        return c

    df.columns = [snake(c) for c in df.columns]
    print("Columns:", list(df.columns))
    print("Missing values:\n", df.isnull().sum()[df.isnull().sum() > 0])

    for col in df.select_dtypes(include=["datetime", "datetimetz"]).columns:
        df[col] = df[col].dt.strftime("%Y-%m-%d")

    conn = sqlite3.connect(DB)
    df.to_sql("NashvilleHousing", conn, if_exists="replace", index=False)
    conn.close()
    print("Nashville database created:", DB)


if __name__ == "__main__":
    main()