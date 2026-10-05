from pathlib import Path
import sqlite3
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
PROCESSED = ROOT / "data" / "processed"
DB = ROOT / "data" / "supply_chain.db"

tables = {
    "shipment": "shipment.csv",
    "customer": "customer.csv",
    "logistics": "logistics.csv",
}

with sqlite3.connect(DB) as conn:
    for table, file in tables.items():
        df = pd.read_csv(PROCESSED / file)
        df.to_sql(table, conn, if_exists="replace", index=False)
        print(f"{table}: {len(df)} filas, {len(df.columns)} columnas")  