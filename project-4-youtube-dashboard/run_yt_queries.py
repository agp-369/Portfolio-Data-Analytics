"""
Execute dashboard queries and export CSVs to outputs/ for Power BI/Tableau.
Run: python run_yt_queries.py
"""
import sqlite3
import pandas as pd
from pathlib import Path

DB = "youtube.db"
SQL = "sales_dashboard_queries.sql"
OUT = Path("outputs")
OUT.mkdir(exist_ok=True)


def split(s):
    stmts = []
    buf = []
    in_comment = False
    for line in s.splitlines():
        u = line.strip().upper()
        if u.startswith("/*"):
            in_comment = True
        if in_comment:
            if u.endswith("*/"):
                in_comment = False
            continue
        if u.startswith("--"):
            continue
        buf.append(line)
        if line.rstrip().endswith(";"):
            stmts.append("\n".join(buf).rstrip(";\n"))
            buf = []
    if buf:
        stmts.append("\n".join(buf))
    return stmts


def main():
    conn = sqlite3.connect(DB)
    stmts = split(Path(SQL).read_text(encoding="utf-8"))
    for i, st in enumerate(stmts, 1):
        if not st.strip():
            continue
        try:
            df = pd.read_sql_query(st, conn)
            name = f"query_{i:02d}.csv"
            df.to_csv(OUT / name, index=False)
            print(f"{i:02d}: {name} ({len(df)} rows)")
        except Exception as e:
            print(f"ERR {i}: {e}")
    conn.close()


if __name__ == "__main__":
    main()