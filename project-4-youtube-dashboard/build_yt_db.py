"""
Build SQLite database for Global YouTube Statistics.
Run: python build_yt_db.py
"""
import sqlite3
import pandas as pd

SRC = "../data_raw/GlobalYouTubeStatistics.csv"
DB = "youtube.db"


def main():
    df = pd.read_csv(SRC, encoding="latin-1")
    print("Shape:", df.shape)
    df.columns = [
        c.strip().replace(" ", "_").replace(".", "").replace("-", "_").replace("(", "").replace(")", "").lower()
        for c in df.columns
    ]
    print("Cols sample:", df.columns.tolist()[:8])
    for col in df.columns:
        if df[col].dtype == "object":
            df[col] = df[col].fillna("")
    df.to_sql("YoutubeStats", sqlite3.connect(DB), if_exists="replace", index=False)
    print("DB created:", DB)


if __name__ == "__main__":
    main()