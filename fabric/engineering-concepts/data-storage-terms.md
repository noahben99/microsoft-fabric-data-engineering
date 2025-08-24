
# Fabric Data Storage Terminology
❓Me
> Please help me understand how these terms are related and how they are difference. Context will be Microsoft Fabric. "Data Store","Data Lake","Data Warehouse","One Lake"


### Data Store
- A data store is a generic term for any storage object that holds data — this could be a Data Lake, Data Warehouse, Datamart, etc.

### Data Lake
- A data lake is a type of data store designed for raw, semi‑structured, and unstructured data, optimized for big data processing. 
- It is flexible — handles any structure, great for raw ingestion and transformation.
- **Typical Data Types** Files (Parquet, CSV, JSON, images, etc.) + tabular data

### Data Warehouse
- A data warehouse contains structured, relational store optimized for analytics. 
- **Typical Data Types** Tables with defined schema (fact/dimension)


In Microsoft Fabric

Lakehouse: Data Lake


#### Fabric Data Stores
- **OneLake** is the single, logical storage layer for all Fabric data 
    - Fabric’s unified storage foundation
    - Everything else in Fabric (Lakehouse, Warehouse, etc.) exists within OneLake.
 In Fabric, the Lakehouse is the main “data lake” implementation.



- Data Lake (Lakehouse) is flexible — handles any structure, great for raw ingestion and transformation.


## How They Relate
Think of them as layers and specializations in Fabric’s unified data ecosystem:



- **Data Warehouse** is another type of data store, but optimized for structured, relational, analytics‑ready data with schema enforcement and strong SQL capabilities.


| Term           | What It Is in Fabric                                                                                           | Typical Data Types                                      | Primary Use Case                                   | Access & Processing                                                  |
| :------------- | :------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------ | :------------------------------------------------- | :------------------------------------------------------------------- |
| OneLake        | Fabric’s unified storage foundation                                                                            | All formats from all Fabric workloads                   | Centralized storage & sharing across workspaces    | Shortcuts, cross‑store queries, Spark, T‑SQL, KQL                    |
| Data Store     | Generic category for any Fabric storage object (Lakehouse, Warehouse, Eventhouse, etc.)                        | Varies by store type                                    | Broad — depends on the store                       | Depends on the store type (Spark, T‑SQL, KQL, etc.)                  |
| Data Lake      | Concept: large‑scale storage for raw/semi‑structured/unstructured data. In Fabric, implemented as a Lakehouse | Files (Parquet, CSV, JSON, images, etc.) + tabular data | Data engineering, data science, advanced analytics | Spark notebooks, pipelines, Dataflows Gen2, SQL endpoint (read‑only) |
| Data Warehouse | Structured, relational store optimized for analytics                                                          | Tables with defined schema (fact/dimension)             | BI reporting, fast SQL queries, governed analytics | T‑SQL (full DDL/DML), pipelines, Dataflows Gen2                      |


