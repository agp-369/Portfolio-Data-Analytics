import sqlite3

conn = sqlite3.connect(":memory:")
conn.execute("CREATE TABLE t(id INTEGER, sale_date TEXT)")
conn.execute("INSERT INTO t VALUES (1, '2021-01-01')")
conn.execute("ALTER TABLE t ADD COLUMN sale_date_converted TEXT")
print("after alter, update attempt...")
try:
    conn.execute("UPDATE t SET sale_date_converted = DATE(sale_date)")
    print("update ok")
    print(conn.execute("SELECT * FROM t").fetchall())
except Exception as e:
    print("ERR:", e)

# Now reproduce run_sql splitting
conn2 = sqlite3.connect("nashville.db")
raw = open("cleaning.sql", encoding="utf-8").read()
for stmt in raw.split(";"):
    stmt = stmt.strip()
    if stmt and not stmt.upper().startswith("--"):
        try:
            conn2.execute(stmt)
            print("OK  :", stmt.splitlines()[0][:70])
        except Exception as e:
            print("FAIL:", stmt.splitlines()[0][:70].ljust(70), "->", e)
conn2.rollback()