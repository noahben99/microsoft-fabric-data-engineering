Grouping Table Shortcuts with Schemas and Naming Patterns
When you add a shortcut under the Tables section of a lakehouse, you can’t nest folders—but you can choose:

The schema in which the shortcut appears

The table name itself

Combining both gives you a lightweight hierarchy and rich context.


1. Source-Type Schema + Descriptive Table Name

Use a schema that flags the source type (and workspace if you like), then a compact table name:

```SQL
-- Schema: flags source + workspace
CREATE SCHEMA IF NOT EXISTS int_sql_wksp-analytics;

-- Shortcut appears as:
int_sql_wksp-analytics.myServer_dbo_myTable
```

### Lakehouse Schema Name	
`int_sql_wksp-analytics`

| Section | Description          | Example        | Valid options                                                                                                                |
| :------ | :------------------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------- |
| 1       | Internal or External | int            | &nbsp;• int=internal:the data source resides within my control, I own the data.<br>&nbsp;• ext=external: not my data         |
| 2       | Source Type          | sql            | • sql<br>&nbsp;• kql<br>&nbsp;• lakehouse<br>&nbsp;• warehouse<br>&nbsp;• dataverse<br>&nbsp;• databricks<br>&nbsp;• gateway |
| 3       | Short description    | wksp-analytics | For an internal datasource in a fabric environment, use wkps-{workspaceName}                                                 |

### Lakehouse Table Name	
`myServer_dbo_myTable`	

| Section | Description | Example  |
| :------ | :---------- | :------- |
| 1       | Server Name | myServer |
| 2       | Schema Name | dbo      |
| 3       | Table Name  | myTable  |


# Landing SQL Shortcuts in your custom schema
Because Fabric currently drops every new table-shortcut into the default dbo schema, you won’t see a "Choose schema" dropdown when you create it.  You cannot pick a non-dbo schema during SQL table shortcut creation.


| Description                        | Using Fabric Lakehouse UI                                                                                                                                                                     | Spark SQL script                                                                                                               | Result                    |
| :--------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| Create the table-shortcut          | New Shortcut                                                                                                                                                                                  | n/a                                                                                                                            | table lands in `dbo` schema |
| Create the custom schema           | (1) Enable lakehouse schemas (Preview) on your lakehouse if you haven’t already. <br> (2) Under Tables, click the … next to Tables and choose New schema. <br> (3) Create the schema and save | 1) Create your target schema <br>`CREATE SCHEMA IF NOT EXISTS ext_sql_myWorkspace;`                                            | new schema exists         |
| Move the table into the new schema | Expand the dbo schema, find your shortcut.<br>Drag it into the new schema.                                                                                                               | Rename (move) the table from dbo into your schema <br> `ALTER TABLE dbo.myTable` <br> `RENAME TO ext_sql_myWorkspace.myTable;` | table lands in dbo schema |




Expand the dbo schema, find your shortcut (e.g. myTable), then drag it into the new schema.  
Solution:
1) Create the table-shortcut > table lands in dbo schema
2) Create a schema (in the Fabric Lakehouse UI or in a Spark SQL script
3) 
- Use drag-and-drop for a point-and-click UX *or* ALTER TABLE … RENAME TO using notebooks.

To get your shortcut into your own schema, follow one of these **post-creation** moves:

### 1. Drag-and-Drop in Lakehouse Explorer
1 Enable lakehouse schemas (Preview) on your lakehouse if you haven’t already.
2 Under Tables, click the … next to Tables and choose New schema.
```sql
CREATE SCHEMA IF NOT EXISTS ext_sql_myWorkspace;
```
3 Expand the dbo schema, find your shortcut (e.g. myTable), then drag it into ext_sql_myWorkspace.
4 All downstream notebooks, views, and SQL queries must now reference `ext_sql_myWorkspace.myTable`

### 2. ALTER TABLE … RENAME TO in Spark SQL
If you’d rather script it, you can rename (and thus move) the table in a notebook:

1) Create your target schema
`CREATE SCHEMA IF NOT EXISTS ext_sql_myWorkspace;`

2) Rename (move) the table from dbo into your schema
`ALTER TABLE dbo.myTable`
`RENAME TO ext_sql_myWorkspace.myTable;`
After this runs, your shortcut appears under Tables ▸ ext_sql_myWorkspace.
