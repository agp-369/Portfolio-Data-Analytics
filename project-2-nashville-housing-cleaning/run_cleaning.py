"""
Execute cleaning.sql step-by-step against the SQLite DB and record a
before/after audit summary so the transformation is fully transparent.
Run: python run_cleaning.py
"""
import sqlite3
import pandas as pd
from pathlib import Path

DB = "nashville.db"
SQL = "cleaning.sql"
OUT = Path("results")
OUT.mkdir(exist_ok=True)


def run_sql(conn, script: str):
    """Execute a SQL script that may contain multiple statements."""
    statements = []
    buf = []
    in_block = False
    for line in script.splitlines():
        u = line.strip().upper()
        if u.startswith("/*"):
            in_block = True
        if in_block:
            if u.endswith("*/"):
                in_block = False
            continue
        if u.startswith("--"):
            continue
        buf.append(line)
        if line.rstrip().endswith(";"):
            statements.append("\n".join(buf).rstrip(";\n"))
            buf = []
    if buf:
        statements.append("\n".join(buf))
    for stmt in statements:
        s = stmt.strip()
        if not s:
            continue
        try:
            conn.execute(s)
            print("✓", s.splitlines()[0][:90])
        except Exception as e:
            print("✗", s.splitlines()[0][:90].ljust(90), "→", e)


def main():
    conn = sqlite3.connect(DB)
    script = Path(SQL).read_text("utf-8")
    # Audit before
    n0 = pd.read_sql("SELECT COUNT(*) AS n FROM NashvilleHousing", conn).n[0]
    null_before = pd.read_sql("SELECT COUNT(*) AS n FROM NashvilleHousing WHERE property_address IS NULL", conn).n[0]
    run_sql(conn, script)
    conn.commit()
    n1 = pd.read_sql("SELECT COUNT(*) AS n FROM NashvilleHousing", conn).n[0]
    audit = pd.DataFrame([("before_address_nulls", null_before), ("rows_before", n0), ("rows_after", n1)], columns=["stage", "row_count"])
    audit.to_csv(OUT / "cleaning_audit.csv", index=False)
    pd.read_sql("SELECT * FROM NashvilleHousing", conn).to_csv(OUT / "nashville_clean.csv", index=False)
    conn.close()
    print("\nDone. Before:", n0, "After:", n1)


if __name__ == "__main__":
    main()