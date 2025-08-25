
# Delta Lake
- 🔗 [What is Delta Lake](https://github.com/noahben99/microsoft-fabric-data-engineering/blob/main/lakehouses/delta-lake.md#delta-lake)
- 🔗 [Delta Lake checkpoint file](https://github.com/noahben99/microsoft-fabric-data-engineering/blob/main/lakehouses/delta-lake.md#delta-lake-checkpoint-file)
- 🔗 [Parquet Files](https://github.com/noahben99/microsoft-fabric-data-engineering/blob/main/lakehouses/delta-lake.md#parquet-files)
- 🔗 [Recording changes](https://github.com/noahben99/microsoft-fabric-data-engineering/blob/main/lakehouses/delta-lake.md#recording-changes)
- 🔗 [Example: Updating a Record](https://github.com/noahben99/microsoft-fabric-data-engineering/blob/main/lakehouses/delta-lake.md#example-updating-a-record)
- 🔗 [Use notebooks to managage delta lake](https://github.com/noahben99/microsoft-fabric-data-engineering/blob/main/lakehouses/delta-lake.)

---
**Delta Lake** is an open-source storage layer that sits on top of your existing data lake (like S3, ADLS, or HDFS) and transforms it into a transactional system. 
It uses Apache Parquet under the hood but adds a transaction log (_delta_log) to track changes.


### Key Features of Delta Lake Tables
| Feature               | Description                                                                 |
|:-----------------------|:-----------------------------------------------------------------------------|
| **ACID Transactions** | Guarantees data integrity during concurrent reads and writes.               |
| **Time Travel**       | Enables querying historical versions of data using timestamps or versions.  |
| **Schema Evolution**  | Allows adding or modifying columns without breaking existing pipelines.     |
| **Data Versioning**   | Each write creates a new version, supporting rollback and auditability.     |
| **Efficient Upserts** | Supports `MERGE`, `UPDATE`, and `DELETE` operations natively.               |
| **Scalable Metadata** | Handles billions of files efficiently without performance degradation.      |


### ACID transactions

| Property       | Definition                                                                                   |
|:----------------|:----------------------------------------------------------------------------------------------|
| **Atomicity**  | All operations in a transaction are treated as a single unit—either all succeed or none do. |
| **Consistency**| Ensures the database moves from one valid state to another, preserving all rules and constraints. |
| **Isolation**  | Concurrent transactions don’t interfere with each other; each behaves as if it's running alone. |
| **Durability** | Once a transaction is committed, its changes are permanent—even if the system crashes.       |


### Delta Log Directory Structure

When you inspect a Delta table, you’ll find something like this:
```
my-delta-table/
├── part-00000.parquet
├── part-00001.parquet
├── _delta_log/
│   ├── 00000000000000000000.json
│   ├── 00000000000000000001.json
│   ├── 00000000000000000002.json
│   ├── 00000000000000000002.checkpoint.parquet
│   └── _last_checkpoint
```

Each .json file represents a commit, and contains a list of actions like

```json
[
  {
    "add": {
      "path": "part-00000.parquet",
      "size": 123456,
      "modificationTime": 1620000000000,
      "dataChange": true
    }
  },
  {
    "metaData": {
      "id": "unique-table-id",
      "schemaString": "...",
      "partitionColumns": [],
      "configuration": {
        "delta.appendOnly": "true"
      }
    }
  }
]
```

These actions include:
- **add**: new data files added
- **remove**: files deleted
- **metaData**: schema and table config
- **protocol**: versioning info for readers/writers
- **txn**: application-level transaction IDs

### Delta Log key features
- It’s a semantic audit trail of every change.
- You can time travel to any version for onboarding clarity.
- It supports automated status tracking and rollback workflows.
For a deeper dive into the file-level anatomy, check out Databricks' breakdown of the Delta Lake transaction log or the Delta Transaction Log Protocol spec.
Want help building a semantic parser or onboarding dashboard that visualizes this log? I’d love to help scaffold it.

---
# Delta Lake checkpoint file
To avoid reading every JSON file on large tables, Delta creates checkpoint files every N commits (default: 10). These are Parquet files summarizing the table state, making reads faster and more scalable.

A Delta Lake checkpoint file is a compact, binary snapshot of a table’s state at a specific version—stored in Parquet format inside the _delta_log directory. It’s designed to speed up reads by summarizing metadata and file actions, so the engine doesn’t need to replay every JSON commit file from scratch
```
_delta_log/
├── 00000000000000000010.json
├── 00000000000000000010.checkpoint.parquet
├── _last_checkpoint
```
The checkpoint file contains a flattened view of:
- All active data files (add actions)
- Removed files (remove actions)
- Table metadata (metaData)
- Protocol versioning (protocol)
- Optional transaction info (txn)
Each row in the Parquet file represents one of these actions, with columns like

|actionType | path                  | size   | modificationTime | dataChange | schemaString | partitionValues |
|:-----------|:------------------------|:--------|:------------------|:------------|:--------------|:------------------|
|add        | part-00000.snappy.parquet | 123456 | 1620000000000    | true       | ...          | {"date":"2025-08-25"} |

---
# Parquet Files
Parquet is an open-source, column-oriented data storage format developed by Apache. Unlike row-based formats like CSV, Parquet stores data by column, which unlocks major performance and compression benefits

| Feature                  | Description                                                                 |
|:--------------------------|:-----------------------------------------------------------------------------|
| **Columnar Storage**     | Stores data by column, enabling faster reads and better compression.        |
| **Efficient Compression**| Uses algorithms like Snappy, GZIP, Brotli, and ZSTD for space savings.      |
| **Language Agnostic**    | Works with Python, Java, C++, R, and more—great for cross-platform use.     |
| **Supports Complex Types**| Handles nested structures, arrays, and maps natively.                      |
| **Optimized for Analytics**| Ideal for OLAP workloads—skip irrelevant columns during queries.         |
| **Schema Evolution**     | Supports adding/removing fields over time without breaking pipelines.       |

#### Features
- Compression is column-specific, so integer columns use different techniques than string columns.
- Query Performance improves because engines like Spark can skip reading entire columns that aren’t needed.
- Storage Efficiency means smaller files and lower cloud costs.
- Compatibility with Delta Lake, Hive, Presto, Trino, and pandas makes it a universal format.

---
# Recording changes
In Lakehouse tables within Microsoft Fabric, Direct DML (INSERT, UPDATE, DELETE) via SQL is not currently supported in the Lakehouse UI or SQL Analytics Endpoint.
However, DML-like changes can be made using
- Notebooks (PySpark or SparkSQL)
- Dataflows Gen2
- Pipelines
- Shortcuts to Warehouse tables (which do support full DML and publish to _delta_log)

Here are common ways Lakehouse tables are updated:

| Method                | Description                                                       |
| :-------------------- | :---------------------------------------------------------------- |
| Overwrite             | Replace entire table via Dataflow or Pipeline                     |
| Append                | Add new rows via ingestion                                        |
| Merge/Upsert          | Use Spark or Dataflow logic to update existing rows               |
| Shortcut to Warehouse | Link to a Warehouse table that supports full DML and logs changes |


- Changes are recorded as transaction logs in the _delta_log folder
- Each log is a JSON file (e.g., 00000000000000000010.json) describing the operation

Example after appending a row to a table:
```json
{
  "add": {
    "path": "part-00010.snappy.parquet",
    "size": 1234,
    "modificationTime": 1692981234567,
    "dataChange": true
  }
}
```
- This log entry:
  - Points to the new Parquet file added
  - Indicates a data change
  - Is part of the transaction history that Delta Lake uses for ACID compliance
<br>
- _delta_log makes it possible to:
  - Query historical versions of the table
  - Roll back to previous states
  - Audit changes for onboarding clarity or reproducibility
<br>
- Data Files (Parquet)
  - Contain only the committed data after a transaction.
  - Do not store historical versions or "before" values.
  - Each new commit may write new Parquet files and mark old ones as removed.
<br>
- Transaction Log (_delta_log)
  - Stores metadata about each transaction.
  - Includes:
    - Which files were added
    - Which files were removed
    - Optional operation metadata (e.g., update, merge, delete)
  - Does not store full row-level diffs or "before" values.

---
# Example: Updating a Record
Let’s say you update a row in a Delta table:
```sql
UPDATE customers SET Age = 35 WHERE Name = 'John';
```
Delta Lake will:
- Write a new Parquet file with the updated row (Age = 35)
- Mark the old Parquet file (with Age = 34) as removed in _delta_log
- Log this in a new JSON file like 00000000000000000010.json:

```json
{
  "remove": {
    "path": "part-00009.parquet",
    "deletionTimestamp": 1692981234567,
    "dataChange": true
  },
  "add": {
    "path": "part-00010.parquet",
    "size": 1234,
    "modificationTime": 1692981234567,
    "dataChange": true
  }
}
```
To reconstruct the "before" state, you'd need to:
- Traverse the _delta_log
- Identify which Parquet files were removed
- Read those files to extract the previous values

---
# Use notebooks to managage delta lake
In Microsoft Fabric Lakehouse, Delta Lake operations like:

- Viewing table history (DESCRIBE HISTORY)
- Time travel (VERSION AS OF)
- Restoring to a previous version (RESTORE TABLE)
- Performing DML operations (UPDATE, MERGE, DELETE)

...are all executed in Notebooks, because they rely on the Spark engine behind the scenes. The SQL Analytics Endpoint, while great for querying structured tables with T-SQL, doesn’t support these Delta-specific commands yet.

| Feature               | SQL Analytics Endpoint | Notebooks (SparkSQL / PySpark) |
| :-------------------- | :--------------------- | :----------------------------- |
| Basic SELECT queries  | ✅ Supported           | ✅ Supported                   |
| Delta Lake versioning | ❌ Not supported       | ✅ Fully supported             |
| DESCRIBE HISTORY      | ❌                     | ✅                             |
| RESTORE TABLE         | ❌                     | ✅                             |
| DML (UPDATE, MERGE)   | ❌                     | ✅                             |
| Time travel queries   | ❌                     | ✅                             |