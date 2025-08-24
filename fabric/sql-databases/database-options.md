# SQL analytics endpoint in a Fabric lakehouse and a traditional SQL database in Azure

❓Me
> I am looking at the items in a workspace called mslearn-labs. I see an SQL analytics endpoint within the lakehouse. But I don't see the SQL database and I don't see the warehouse in which the database exists. Where can I see those within Fabric?

🤖 Copilot
> In Microsoft Fabric, the SQL analytics endpoint you're seeing within the lakehouse is not tied to a traditional SQL database or warehouse—it's a virtualized endpoint that exposes Delta tables in the lakehouse via T-SQL for querying and BI integration. Here's how it works and where to look:

🧠 Understanding the SQL Analytics Endpoint in Lakehouse
What it is: A read-only SQL surface over your lakehouse's Delta tables.

What it’s not: It doesn’t represent a dedicated SQL database or Fabric Warehouse.

Where it lives: It’s embedded within the lakehouse item itself (e.g., lh_fab SQL analytics endpoint), not in a separate warehouse container.

🔍 Why You Don’t See a SQL Database or Warehouse
Lakehouse ≠ Warehouse: Lakehouses store data in OneLake using open formats (like Delta), while Warehouses are structured for relational workloads with dedicated compute.

No Warehouse Created: If you haven’t explicitly created a Warehouse item in the workspace, there won’t be a corresponding SQL database object.

SQL Endpoint Is Virtual: The SQL analytics endpoint doesn’t require a separate database—it simply maps to the lakehouse tables.

🗂️ Where to Find SQL Warehouses (If You Create One)
If you want a traditional SQL warehouse experience:

Go to Workspace > New Item > Warehouse.

Create a Warehouse object—this will appear as a separate item in your workspace.

That warehouse will have its own SQL endpoint and database-like structure.

❓Me
> where are the delta tables?

Location: Inside the Lakehouse item (lh_fab) in your workspace.

Storage Format: Delta tables are stored in OneLake using the open Delta Lake format.

Access Path:

Open the lh_fab lakehouse.

Navigate to the Tables section—this shows all Delta tables registered in the lakehouse.

You can also explore the Files section to see the raw .parquet or .delta files if needed.

🔍 How to Interact with Delta Tables
SQL Analytics Endpoint: Use this for read-only T-SQL queries over the Delta tables.

Apache Spark: Use notebooks or scripts to read/write Delta tables programmatically.

Dataflows Gen2: You can ingest data into Delta tables via pipelines like df-ingest-sample-file or df_01.


---
❓Me
> How is this different than an SQL database I might create in Azure Cloud?

The SQL analytics endpoint in a Fabric lakehouse and a traditional SQL database in Azure (like Azure SQL Database or Synapse SQL Pools) serve different purposes and are architecturally distinct. Here's a breakdown to clarify:

Architectural Differences
| Feature                  | Fabric Lakehouse SQL Endpoint       | Azure SQL Database / Synapse SQL Pool    |
| :----------------------- | :---------------------------------- | :--------------------------------------- |
| Storage Format           | Delta Lake (open format in OneLake) | Proprietary relational storage           |
| Compute Model            | Serverless, read-only SQL surface   | Dedicated or serverless compute options  |
| Write Capability via SQL | ❌ No (read-only via T-SQL)         | ✅ Yes (full DML/DDL support)            |
| Data Access              | Spark, Dataflows, Pipelines         | T-SQL, ADO.NET, JDBC, etc.               |
| Integration Surface      | SQL endpoint for BI tools           | Full SQL engine with stored procs, views |
| Schema Enforcement       | Optional (schema-on-read)           | Strict schema enforcement                |
| Use Case                 | Analytical lakehouse workloads      | OLTP/OLAP, transactional or analytical   |

Conceptual Differences
Fabric Lakehouse: Think of it as a data lake with structured access. You ingest data via pipelines or Spark, store it in open Delta format, and expose it via a SQL endpoint for BI tools like Power BI. It’s optimized for big data analytics, not transactional workloads.

Azure SQL Database: This is a full-fledged relational database engine. You can create tables, enforce constraints, run stored procedures, and manage transactions. It’s ideal for line-of-business apps, OLTP, or complex relational modeling



❓Me
> I have opened the Fabric database in SSMS on my desktop and it appears exactly the same as I would see if I connected to an Azure cloud database using SSMS.

it speaks to how Fabric is designed to feel familiar to SQL professionals while operating under a very different architecture.

When you connect to a Fabric lakehouse SQL analytics endpoint using SSMS, it does emulate the experience of connecting to an Azure SQL Database or Synapse SQL Pool. You’ll see:

A database-like structure with tables, views, and schemas

T-SQL support for querying

Familiar metadata and object explorer layout

But under the hood, it’s not a traditional SQL database. Here’s what’s actually happening:

Why It Looks the Same in SSMS
Fabric exposes a TDS endpoint (Tabular Data Stream protocol), which is the same protocol used by Azure SQL and SQL Server.

SSMS connects to this endpoint and renders the lakehouse tables as if they were part of a SQL database.

The illusion is intentional—it allows BI tools and SQL users to query lakehouse data without learning new interfaces.

⚙️ What’s Different Behind the Scenes
| Feature             | Fabric SQL Endpoint (Lakehouse) | Azure SQL Database / Synapse SQL Pool |
| :------------------ | :------------------------------ | :------------------------------------ |
| Underlying Storage  | Delta tables in OneLake         | Proprietary relational storage        |
| Write via T-SQL     | ❌ Not supported (read-only)    | ✅ Full DML/DDL support               |
| Stored Procedures   | ❌ Not supported                | ✅ Supported                          |
| Transaction Support | ❌ None                         | ✅ Full ACID transactions             |
| Compute Model       | Serverless, virtualized         | Dedicated or serverless SQL compute   |


❓Me
> what options exist for SQL databases in Fabric that support DML statements?

🤖 Copilot
> In Microsoft Fabric, the only SQL database option that supports full DML (Data Manipulation Language) statements—like INSERT, UPDATE, DELETE, and MERGE—is the Warehouse item. Here's a breakdown of what you can use and what to avoid if you're looking for DML support:

✅ SQL Database Options in Fabric That Support DML
1. Warehouse (Fabric-native)
- **Supports**: Full T-SQL including DML and DDL
- **Use Cases**: Relational modeling, transactional updates, BI integration
- **Access**: Via SSMS, Power BI, Notebooks, and Pipelines
- **Storage**: Structured tables stored in OneLake with dedicated compute
- **Ideal for**: Scenarios where you need to modify data directly via SQL

🚫 SQL Options That Do Not Support DML
| Option                 | DML Support    | Notes                                                    |
| :--------------------- | :------------- | :------------------------------------------------------- |
| Lakehouse SQL Endpoint | ❌ Read-only   | Exposes Delta tables via T-SQL; no INSERT, UPDATE, etc.  |
| Semantic Models        | ❌ N/A         | Used for Power BI modeling; not a SQL surface            |
| Dataflows Gen2         | ❌ N/A         | Used for ingestion/transformation, not direct SQL access |
| Notebooks (Spark)      | ✅ via PySpark | Not T-SQL; uses Spark APIs for data manipulation         |

🧠 Onboarding Tip for Your Team
You might want to include a snippet like this in your documentation:


## SQL Write Access in Microsoft Fabric

| Item Type     | SQL Access | DML Support | Notes |
|---------------|------------|-------------|-------|
| Warehouse      | ✅ Full T-SQL | ✅ Yes       | Use for relational workloads and direct data manipulation |
| Lakehouse      | ✅ Read-only | ❌ No        | SQL endpoint exposes Delta tables; use Dataflows or Spark for writes |
| Semantic Model | ❌ N/A      | ❌ No        | Used for BI modeling, not SQL access |

