# Reporting Optimization
- Materialize Once, Query Fast
- Optimizing View Performance with Fabric
- Avoiding Redundant View Computation
- Caching Views for Scalable Reporting
- From Views to Tables: Smarter Refresh Strategies


- Reducing Query Load with Hourly Materialization
- Fabric Strategy: Persisting Views as Tables
- Improving Report Performance via View Caching
- Transforming Views into Reusable Datasets

### Goal: Avoid Recomputing Views Every Time
- Instead of recalculating a complex SQL view on every report run, you want to:
    - Precompute once per refresh
    - Store the result efficiently
    - Serve it fast to Power BI or other consumers


❓Me
> I often struggle with the issue that a sql view could be very slow to generate each time requested from the server.  And, because the data was only refreshed once per hour, it seemed wasteful to calculate a view every time a report was ran.  So, every time the data was refreshed, we would save the view as a temporary table and use that as the report dataset.  How can I do this better using fabric?

🤖 Copilot
> That’s a classic pain point — and Fabric gives you some powerful tools to solve it more elegantly and scalably.

**Strategic Comparison**
| Approach                        | Pros                | Cons                                          | Uses Fabric? |
| :------------------------------ | :------------------ | :-------------------------------------------- | ------------ |
| 1️⃣ SQL View                      | Simple, reusable    | Slow if complex joins, recalculated each time | ❌           |
| 2️⃣ Temp Table                    | Faster reads        | Manual refresh logic, storage overhead        | ❌           |
| 3️⃣ Materialized View (Warehouse) | Auto-refresh, fast  | Limited to Warehouse                          | ✅           |
| 4️⃣ Lakehouse Table via Notebook  | Flexible, scalable  | Requires Spark or pipeline setup              | ✅           |
| 5️⃣ Dataflow Gen2                | Low-code, scheduled | Less control over logic granularity           | ✅           |
| 6️⃣ Direct Lake Mode             | Instant visuals     | Requires Lakehouse-backed model               | ✅           |




---
# 3️⃣ Materialized Views (Warehouse)
Fabric Warehouses support materialized views, which:

    - Cache the result of a SQL query
    - Automatically refresh on a schedule or manually
    - Are queryable like regular tables

Example:

```sql

CREATE MATERIALIZED VIEW mv_SalesReport AS
SELECT ...
FROM FactSales
JOIN DimCustomer ...
```
✅ You can then query mv_SalesReport directly in Power BI — no recomputation needed.

---

❓Me
> Is MATERIALIZED a sql command?


🤖 Copilot
> MATERIALIZED VIEW is a SQL construct, but it’s not part of the original ANSI SQL standard. It’s supported by many modern database engines (like PostgreSQL, Oracle, and Microsoft Fabric Warehouse) as an extension to standard SQL.

### What Is MATERIALIZED VIEW?
A materialized view is like a snapshot of a query result that’s stored as a physical table. Unlike a regular view (which runs the query every time), a materialized view:

- Stores the result of the query
- Can be refreshed manually or automatically
- Is indexed and optimized for fast reads

### Syntax Example (Fabric Warehouse Style)
```sql
CREATE MATERIALIZED VIEW mv_SalesSummary AS
SELECT 
    c.CustomerName,
    SUM(s.SaleAmount) AS TotalSales,
    COUNT(*) AS Transactions
FROM FactSales s
JOIN DimCustomer c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;
```
This creates a precomputed table-like object that can be queried instantly:

```sql
SELECT * FROM mv_SalesSummary;
```

### Refreshing the View
Depending on the platform, you can:

- Schedule automatic refreshes
- Use REFRESH MATERIALIZED VIEW manually
- Trigger refreshes via pipelines or orchestration tools

In Microsoft Fabric, you’d typically refresh it using:

- Data pipelines
- Notebook jobs
- Or SQL commands if supported in the Warehouse

### When to Use It
| Use Case                        | Materialized View                             |
| :------------------------------ | :-------------------------------------------- |
| Complex joins or aggregations   | ✅ Excellent                                  |
| Frequently accessed report data | ✅ Ideal                                      |
| Real-time updates needed        | ❌ Not ideal (use regular views or streaming) |



---
# 4️⃣ Lakehouse Tables via Notebooks or Pipelines
If you’re working in the Lakehouse, you can:

- Use a Spark notebook or Dataflow Gen2 pipeline to run your SQL view logic
- Save the result as a Delta table in the Lakehouse

✅ This gives you:

- Fast reads via Direct Lake mode
- Versioning and time travel if needed
- Reuse across multiple reports

Example notebook logic:

```python

df = spark.sql("""
SELECT ...
FROM FactSales
JOIN DimCustomer ...
""")
df.write.format("delta").mode("overwrite").save("/Tables/SalesReport")
```

---
# 5️⃣ Dataflow Gen2 with Scheduled Refresh
You can recreate your view logic in a Dataflow Gen2, then:

- Output the result to a Lakehouse table
- Schedule it to refresh hourly (or faster)
- Use that table as your Power BI source

✅ This is low-code and integrates beautifully with Fabric’s refresh orchestration.


---
# 6️⃣ Direct Lake Mode in Power BI
Once your precomputed table is in the Lakehouse:

- Connect Power BI using Direct Lake
- No import, no refresh delay
- Lightning-fast performance

This eliminates the need for temporary tables or manual caching — Fabric handles it.  Direct Lake mode in Microsoft Fabric is essentially a best‑of‑both‑worlds storage mode for Power BI semantic models that live in a Fabric workspace.

### What it is
Direct Lake is a storage mode option for tables in a Power BI semantic model that reads data directly from Delta tables in OneLake — Fabric’s unified data store — and feeds it into the VertiPaq engine for blazing‑fast queries.

Think of it as:
- Import‑like performance (because VertiPaq is still doing the heavy lifting in memory)
- DirectQuery‑like freshness (because it doesn’t require full data reloads)

### How it works
- Data stays in OneLake — no full copy into the PBIX file or local machine.
- When a query runs, only the needed data pages are pulled into memory.
- Refresh is metadata‑only (“framing”), which just updates pointers to the latest Delta files — often in seconds, not minutes or hours.
- All heavy data prep (joins, transformations, aggregations) happens upstream in Fabric using Spark, T‑SQL, Dataflows, Pipelines, etc.

### Why it matters
| Feature       | Direct Lake              | Import                     | DirectQuery                   |
| :------------ | :----------------------- | :------------------------- | :---------------------------- |
| Query engine  | VertiPaq                 | VertiPaq                   | Source system                 |
| Data location | OneLake Delta tables     | In‑memory cache            | Source system                 |
| Refresh cost  | Low (metadata only)      | High (full data copy)      | None                          |
| Performance   | High                     | High                       | Variable                      |
| Data volume   | Can exceed memory limits | Limited by capacity memory | Limited by source performance |


### Power BI Desktop experience
- You live‑edit the semantic model directly in the Fabric workspace — no “Publish” step.
- Version history is automatic; Git integration is supported for pro dev workflows.
- PBIP (Power BI Project) format lets you store model/report metadata locally for source control.
- Reports connect live to the semantic model in OneLake.

### Fabric‑focused take
For your gold layer in a medallion architecture, Direct Lake is a sweet spot:
- Keeps your Lakehouse/Warehouse as the single source of truth.
- Avoids Import mode’s memory ceiling.
- Still delivers sub‑second visuals for well‑modeled datasets.
- Plays nicely with your documentation‑driven approach — you can clearly map lineage from Lakehouse Delta tables to semantic model objects.


