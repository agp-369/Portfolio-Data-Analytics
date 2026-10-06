"""
Execute every query in queries.sql against the SQLite database and
export each result set as a CSV in results/ for review and dashboards.
Run: python run_queries.py
"""
import re
import sqlite3
from pathlib import Path

DB = "covid.db"
SQL = "queries.sql"
OUT = Path("results")
OUT.mkdir(exist_ok=True)


def split_statements(text):
    # strip comment lines and split on terminating semicolons
    text = re.sub(r"(?m)^--.*$", "", text)
    stmts = []
    for chunk in text.split(";"):
        chunk = chunk.strip()
        if chunk and not chunk.upper().startswith("CREATE VIEW"):
            if chunk and "CREATE VIEW" not in chunk.upper():
                stmts.append(chunk)
    return stmts


def main():
    conn = sqlite3.connect(DB)
    text = Path(SQL).read_text(encoding="utf-8")
    stmts = split_statements(text)

    for i, stmt in enumerate(stmts, start=1):
        head = stmt.splitlines()[0].strip()
        print(f"[{i:02d}] {head[:90]}")
        try:
            df = conn.execute(stmt).fetchdf() if hasattr(conn, "fetchdf") else pd_reader(conn, stmt)
            out = OUT / f"query_{i:02d}.csv"
            df.to_csv(out, index=False)
            print(f"      -> {out} ({len(df):,} rows)")
        except Exception as e:
            print(f"      ERROR: {e}")

    # create the view explicitly
    conn.executescript('''
    DROP VIEW IF EXISTS percent_population_vaccinated;
    CREATE VIEW percent_population_vaccinated AS
    SELECT dea.continent, dea.location, dea.date, dea.population,
           vac.new_vaccinations,
           SUM(CAST(vac.new_vaccinations AS INTEGER))
               OVER (PARTITION BY dea.location ORDER BY dea.date) AS rolling_people_vaccinated
    FROM CovidDeaths dea
    JOIN CovidVaccinations vac
      ON dea.location = vac.location
     AND dea.date     = vac.date
    WHERE dea.continent IS NOT NULL;
    ''')
    # export the view for data-viz use cases
    pd_reader(conn, "SELECT * FROM percent_population_vaccinated").to_csv(OUT / "view_population_vaccinated.csv", index=False)
    conn.close()
    print("Done.")


import pandas as pd


def pd_reader(conn, stmt):
    return pd.read_sql_query(stmt, conn)


if __name__ == "__main__":
    main()