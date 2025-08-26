# Materializing SQL Shortcuts for Lakehouse Queries
❓
> In Microsoft Fabric, I added a shortcut to a lakehouse in the current workspace.  
> While setting up the shortcut, I selected a SQL database and then a table called **myTable**.  
> After clicking **Save**, I see the shortcut in the Lakehouse explorer, but not in the SQL Analytics endpoint.  
> How can I join **myTable** with a native lakehouse table and make the result queryable via SQL?

🤖
> When you create a shortcut to a SQL database table in your lakehouse, you're essentially creating 
> a reference to that external data source without duplicating the data. However, shortcuts to SQL tables 
> do not automatically appear in the SQL analytics endpoint—only shortcuts to Delta-formatted tables do. 
> Since SQL tables aren't stored in Delta format, they won't be queryable via the SQL endpoint unless 
> you take an extra step to materialize them.

## Option 1: Use a Spark Notebook to Join the Shortcut

Since the shortcut appears under **Files** (not **Tables**), you can read it with Spark, join, and write back.

```python
# Load the shortcut table
df_shortcut = spark.read.format("delta").load("Files/myTable")

# Load a lakehouse table
df_lakehouse = spark.read.table("lakehouse_table_name")

# Perform the join
df_joined = df_shortcut.join(
    df_lakehouse,
    df_shortcut["id"] == df_lakehouse["id"]
)

# Write the joined data back as a Delta table
df_joined.write.mode("overwrite").saveAsTable("joined_table")
```

## Option 2: Materialize the Shortcut as a Lakehouse Table
If you want the external table to appear in SQL Analytics, load it into a new lakehouse Delta table.

```python
# Read the shortcut
df_shortcut = spark.read.format("delta").load("Files/myTable")

# Save as a new Delta table
df_shortcut.write.mode("overwrite").saveAsTable("materialized_myTable")
```

## Option 3: Create a Materialized Lake View

Leverage Fabric’s CREATE MATERIALIZED LAKE VIEW in Spark SQL to join the shortcut and expose it to the SQL endpoint.

### Prerequisites
- A schema-enabled lakehouse
- Access to the shortcut via Spark SQL (e.g., Files/myTable or dbo.myTable)
- Execution in a Spark SQL notebook or interactive endpointresolution

### Benefits of This Approach
- The result is physically stored as a Delta table and visible in SQL Analytics.
- You can schedule automatic refreshes.
- Fabric tracks lineage in OneLake, improving discoverability.


**SQL**
```sql
-- Ensure the target schema exists
CREATE SCHEMA IF NOT EXISTS bronze;

-- Define the materialized lake view
CREATE MATERIALIZED LAKE VIEW IF NOT EXISTS bronze.joined_data AS
SELECT
    s.id              AS shortcut_id,
    s.value           AS shortcut_value,
    l.id              AS lakehouse_id,
    l.description     AS lakehouse_description
FROM
    dbo.myTable AS s
JOIN
    lakehouse_table_name AS l
  ON s.id = l.id;

```

## Choosing the Right Method

### Use `CREATE MATERIALIZED LAKE VIEW` when
- You want SQL discoverability and lineage.
- The transformation is simple and declarative.
- You're working in a schema-enabled lakehouse.

### Use Spark read → write when:
- You need complex logic, UDFs, or dynamic joins.
- You’re prototyping outside schema constraints.
- You require custom partitioning, file layout, or write modes.


| Feature / Concern          | CREATE MATERIALIZED VIEW (SQL)                                            | Spark read → write Workflow                                    |
| :------------------------- | :------------------------------------------------------------------------ | :------------------------------------------------------------- |
| Visibility in SQL Endpoint | ✅ Automatically visible in SQL analytics endpoint                        | ✅ Visible after write, but only once written as a Delta table |
| Lineage Tracking           | ✅ Integrated with Fabric’s lineage and OneLake catalog                   | ❌ Manual unless you document source and transformation logic  |
| Declarative vs Imperative  | ✅ Declarative SQL logic—ideal for reproducibility and onboarding clarity | ❌ Imperative Spark logic—more flexible but harder to trace    |
| Refresh Behavior           | ✅ Can be scheduled or triggered via Fabric pipelines                     | ❌ Must be manually re-executed or scripted for refresh        |
| Schema Enforcement         | ✅ Requires schema-enabled lakehouse                                      | ❌ Works in any lakehouse, schema optional                     |
| Transformation Complexity  | ⚠️ Limited to SQL-compatible logic                                      | ✅ Full Spark flexibility (UDFs, complex joins, etc.)          |
| Onboarding Friendliness    | ✅ Easier for SQL-savvy collaborators to understand and reuse             | ⚠️ Requires Spark familiarity and notebook context           |
| Performance Optimization   | ✅ Optimized by Fabric’s engine for SQL queries                           | ⚠️ Depends on Spark execution and write configuration        |
| Changelog Hygiene          | ✅ Can be versioned and documented as part of schema evolution            | ⚠️ Requires manual changelog tracking and naming conventions |



## Naming convention for a Files-section shortcut that points to a non-Delta SQL table 

### Naming Convention Guidelines
The name should immediately convey:
- It's an external (non-Delta) source
- The type of source (SQL)
- The workspace/lakehouse context (useful if you ever share shortcuts across workspaces)
- The name of the server, schema, and table

### Example
- Shortcut will be created within the 'files' section of a lakehouse
- Shortcut points to database is located in the same workspace as the lakehouse
- The SQL Database is not Delta-formatted
- **Workspace Name**: myWorkspace
- **Lakehouse Name**: myLakehouse
- **Server Name**: myServer
- **Schema Name**:dbo
- **Table Name**: myTable

#### Option 1
`ext_sql_myWorkspace_myLakehouse_myServer_dbo_myTable`
| name                      | purpose                      |
| :------------------------ | :--------------------------- |
| `ext_sql`                 | flags an external SQL source |
| `myWorkspace_myLakehouse` | local context                |
| `myServer`                | server name                  |
| `dbo`                     | schema                       |
| `myTable`                 | table name                   |

### Option 2
Create a folder heirachy in Lakehouse Files that mimics the path to the table

#### Standard Naming Convention
```
internal/
  <workspaceName>/
    <sourceType>/           ← source type
      <sourceName>/
        <schemaOrCategory>/
          <objectName>
```
#### How to Choose sourceType
-   **kql**: Kusto (KQL) databases
-   **lakehouse**: managed Delta lakehouses
-   **warehouse**: Synapse or Fabric SQL Warehouses
-   **dataverse**: Dynamics 365 / Dataverse environments
-   **databricks**: mirrored Databricks catalogs
-   **gateway**: on-prem or network-restricted via OPDG

## Examples by source type

#### SQL Server
```
internal/
  wksp_Analytics/         ← workspace clearly flagged
    sql/                  ← source type
      myServer/           ← server
        dbo/              ← schema
          myTable         ← table
```

#### Kusto (KQL) Database Table

```
internal/
  wksp_Analytics/
    kql/
      telemetryDB/
        dbo/
          eventLog
```          

#### Another Lakehouse Table
```
internal/
  wksp_Analytics/
    lakehouse/
      metaLakehouse/
        dbo/
          auditEvents          
```
#### SQL Warehouse (Synapse Warehouse)
```
internal/
  wksp_Analytics/
    warehouse/
      financeWH/
        dbo/
          transactions
```

#### Dataverse Table
```
internal/
  wksp_Analytics/
    dataverse/
      prodEnvironment/
        contact
```

#### Databricks Catalog/Table

```
internal/
  wksp_Analytics/
    databricks/
      catalogDefault/
        salesSchema/
            orders
``` 

#### On-Premises SQL via Gateway
```
internal/
  wksp_Analytics/
    gateway/
      onPremSQL/
        hrSchema/
            employees
```                      

