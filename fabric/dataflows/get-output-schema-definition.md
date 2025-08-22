
# Automated Schema Extraction Methods – Dataflows Gen2

For large tables with many columns, manual inspection of schema is inefficient. Below are automated, reproducible methods to extract column names and data types in Dataflows Gen2.

---

### 1. Use Power Query M Code to Output Schema as a Table

Add a final step in your dataflow using the following M code:

```m
let
    source = YourFinalStep,
    schema = Table.Schema(source)
in
    schema
```
This returns a table with:

Name → Column name
Kind → Primitive type (e.g., Text, Int64)
TypeName → Friendly type name
Nullable → True/False

You can preview this table in the canvas or export it to a Lakehouse for audit logging.

### 2. Export Schema to Lakehouse Table for Logging
To make schema changes auditable:

- Add a branch in your dataflow that outputs Table.Schema(...)
- Load it to a Lakehouse table (e.g., lh_schema_audit)
- Enable overwrite mode to refresh it on each run

This creates a versioned schema snapshot for onboarding and changelog tracking.


### 3. Use a Notebook for Schema Extraction
If you're staging data in a Lakehouse, use PySpark or Pandas to extract schema:

```python
df = spark.read.format("delta").load("Tables/your_table")
schema = [(field.name, field.dataType.simpleString()) for field in df.schema.fields]
schema_df = spark.createDataFrame(schema, ["Column", "Type"])
schema_df.show()
```
This method is ideal for hybrid workflows where schema validation is needed before promotion to production.

### Summary
| Method                    | Output Format        | Best For                          |
| :------------------------ | :------------------- | :-------------------------------- |
| Power Query Table.Schema  | Table in canvas      | Quick preview, inline audit       |
| Lakehouse export          | Delta table snapshot | Versioned schema tracking         |
| Notebook (PySpark/Pandas) | DataFrame            | Advanced validation, hybrid flows |


### Sample Schema Snapshot 
**Dataflow**: df-ingest-sample-file
**Extracted via**: Table.Schema(...) 
**Date**: 2025-08-22 
**Source** Step: FinalTransform

| Column Name | Data Type | Nullable |
| :---------- | :-------- | :------- |
| id          | Int64     | No       |
| created_at  | DateTime  | Yes      |
| status      | Text      | No       |