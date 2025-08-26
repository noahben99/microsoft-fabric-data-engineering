# OneLake shortcuts

### What are shortcuts?
Shortcuts are objects in OneLake that point to other storage locations. The location can be internal or external to OneLake. The location that a shortcut points to is known as the target path of the shortcut. The location where the shortcut appears is known as the shortcut path. Shortcuts appear as folders in OneLake and any workload or service that has access to OneLake can use them. Shortcuts behave like symbolic links. They're an independent object from the target. If you delete a shortcut, the target remains unaffected. If you move, rename, or delete a target path, the shortcut can break.

<img src="https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-shortcuts/shortcut-connects-other-location.png" style ="border:solid #9c9c9c 5pt" width="1000">

### Where can I create shortcuts?
You can create shortcuts in lakehouses and Kusto Query Language (KQL) databases. Furthermore, the shortcuts you create within these items can point to other OneLake locations, Azure Data Lake Storage (ADLS) Gen2, Amazon S3 storage accounts, or Dataverse. You can even create shortcuts to on-premises or network-restricted locations with the use of the Fabric on-premises data gateway (OPDG).

You can use the Fabric UI to create shortcuts interactively, and you can use the REST API to create shortcuts programmatically.

#### Lakehouse
When creating shortcuts in a lakehouse, you must understand the folder structure of the item. Lakehouses are composed of two top-level folders: the Tables folder and the Files folder. The Tables folder represents the managed portion of the lakehouse for structured datasets. While the Files folder is the unmanaged portion of the lakehouse for unstructured or semi-structured data.

In the Tables folder, you can only create shortcuts at the top level. Shortcuts aren't supported in subdirectories of the Tables folder. Shortcuts in the tables section typically point to internal sources within OneLake or link to other data assets that conform to the Delta table format. If the target of the shortcut contains data in the Delta\Parquet format, the lakehouse automatically synchronizes the metadata and recognizes the folder as a table. Shortcuts in the tables section can link to either a single table or a schema, which is a parent folder for multiple tables.

 Note: The Delta format doesn't support tables with space characters in the name. Any shortcut containing a space in the name won't be discovered as a Delta table in the lakehouse.

In the Files folder, there are no restrictions on where you can create shortcuts. You can create them at any level of the folder hierarchy. Table discovery doesn't happen in the Files folder. Shortcuts here can point to both internal (OneLake) and external storage systems with data in any format.
<img src="https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-shortcuts/lake-view-table-view.png" style ="border:solid #9c9c9c 5pt" width="1000">

#### KQL database
When you create a shortcut in a KQL database, it appears in the Shortcuts folder of the database. The KQL database treats shortcuts like external tables. To query the shortcut, use the external_table function of the Kusto Query Language.

<img src="https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-shortcuts/shortcut-kql-database.png" style ="border:solid #9c9c9c 5pt" width="1000">

### Where can I access shortcuts?
Any Fabric or non-Fabric service that can access data in OneLake can use shortcuts. Shortcuts are transparent to any service accessing data through the OneLake API. Shortcuts just appear as another folder in the lake. Apache Spark, SQL, Real-Time Intelligence, and Analysis Services can all use shortcuts when querying data.

#### Apache Spark
Apache Spark notebooks and Apache Spark jobs can use shortcuts that you create in OneLake. Relative file paths can be used to directly read data from shortcuts. Additionally, if you create a shortcut in the Tables section of the lakehouse and it is in the Delta format, you can read it as a managed table using Apache Spark SQL syntax.
```python
df = spark.read.format("delta").load("Tables/MyShortcut")
display(df)

df = spark.sql("SELECT * FROM MyLakehouse.MyShortcut LIMIT 1000")
display(df)
```

#### SQL
You can read shortcuts in the Tables section of a lakehouse through the SQL analytics endpoint for the lakehouse. You can access the SQL analytics endpoint through the mode selector of the lakehouse or through SQL Server Management Studio (SSMS).
```sql
SELECT TOP (100) *
FROM [MyLakehouse].[dbo].[MyShortcut]
```

#### Real-Time Intelligence
Shortcuts in KQL databases are recognized as external tables. To query the shortcut, use the external_table function of the Kusto Query Language.

```kusto
external_table('MyShortcut')
| take 100
```


#### Analysis Services
You can create semantic models for lakehouses containing shortcuts in the Tables section of the lakehouse. When the semantic model runs in Direct Lake mode, Analysis Services can read data directly from the shortcut.

#### Non-Fabric
Applications and services outside of Fabric can also access shortcuts through the OneLake API. OneLake supports a subset of the ADLS Gen2 and Blob storage APIs. To learn more about the OneLake API, see OneLake access with APIs.

`https://onelake.dfs.fabric.microsoft.com/MyWorkspace/MyLakhouse/Tables/MyShortcut/MyFile.csv`

### Types of shortcuts
OneLake shortcuts support multiple filesystem data sources. These include internal OneLake locations, Azure Data Lake Storage (ADLS) Gen2, Amazon S3, S3 Compatible, Google Cloud Storage(GCS) and Dataverse.

#### Internal OneLake shortcuts
Internal OneLake shortcuts allow you to reference data within existing Fabric items, including:

- KQL databases
- Lakehouses
- Mirrored Azure Databricks Catalogs
- Mirrored Databases
- Semantic models
- SQL databases
- Warehouses

The shortcut can point to a folder location within the same item, across items within the same workspace, or even across items in different workspaces. When you create a shortcut across items, the item types don't need to match. For instance, you can create a shortcut in a lakehouse that points to data in a data warehouse.

When a user accesses data through a shortcut to another OneLake location, OneLake uses the identity of the calling user to authorize access to the data in the target path of the shortcut. This user must have permissions in the target location to read the data.

- 🔗[azure data lake storage shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#azure-data-lake-storage-shortcuts)
- 🔗[azure blob storage shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#azure-blob-storage-shortcuts)
- 🔗[s3 shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#s3-shortcuts)
- 🔗[google cloud storage shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#google-cloud-storage-shortcuts)
- 🔗[dataverse shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#dataverse-shortcuts)


### Caching
Shortcut caching can reduce egress costs associated with cross-cloud data access. As files are read through an external shortcut, the files are stored in a cache for the Fabric workspace. Subsequent read requests are served from cache rather than the remote storage provider. The retention period for cached files can be set from 1-28 days. Each time the file is accessed, the retention period is reset. If the file in remote storage provider is more recent than the file in the cache, the request is served from remote storage provider and the updated file will then be stored in cache. If a file hasn’t been accessed for more than the selected retention period, it's purged from the cache. Individual files greater than 1 GB in size aren't cached.

To enable caching for shortcuts, open the Workspace settings panel. Choose the OneLake tab. Toggle the cache setting to On and select the Retention Period.

The cache can also be cleared at any time. From the same settings page, select the Reset cache button. This action removes all files from the shortcut cache in this workspace.

<img src="https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-shortcuts/shortcut-cache-settings.png" style ="border:solid #9c9c9c 5pt" width="1000">

#### How shortcuts utilize cloud connections
ADLS and S3 shortcut authorization is delegated by using cloud connections. When you create a new ADLS or S3 shortcut, you either create a new connection or select an existing connection for the data source. Setting a connection for a shortcut is a bind operation. Only users with permission on the connection can perform the bind operation. If you don't have permissions on the connection, you can't create new shortcuts using that connection.

#### Shortcut security
Shortcuts require certain permissions to manage and use. OneLake shortcut security looks at the permissions required to create shortcuts and access data using them.

#### How do shortcuts handle deletions?
Shortcuts don't perform cascading deletes. When you delete a shortcut, you only delete the shortcut object. The data in the shortcut target remains unchanged. However, if you delete a file or folder within a shortcut, and you have permissions in the shortcut target to perform the delete operation, the files or folders are deleted in the target.

For example, consider a lakehouse with the following path in it: MyLakehouse\Files\MyShortcut\Foo\Bar. MyShortcut is a shortcut that points to an ADLS Gen2 account that contains the Foo\Bar directories.

You can perform a delete operation on the following path: MyLakehouse\Files\MyShortcut. In this case, the MyShortcut shortcut is deleted from the lakehouse but the files and directories in the ADLS Gen2 account Foo\Bar remain unaffected.

You can also perform a delete operation on the following path: MyLakehouse\Files\MyShortcut\Foo\Bar. In this case, if you write permissions in the ADLS Gen2 account, the Bar directory is deleted from the ADLS Gen2 account.

#### Workspace lineage view
When creating shortcuts between multiple Fabric items within a workspace, you can visualize the shortcut relationships through the workspace lineage view. Select the Lineage view button ( ) in the upper right corner of the Workspace explorer.

<img src="https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-shortcuts/lineage-view.png" style ="border:solid #9c9c9c 5pt" width="1000">

#### Limitations and considerations
- The maximum number of shortcuts per Fabric item is 100,000. In this context, the term item refers to: apps, lakehouses, warehouses, reports, and more.
- The maximum number of shortcuts in a single OneLake path is 10.
- The maximum number of direct shortcuts to shortcut links is 5.
- ADLS and S3 shortcut target paths can't contain any reserved characters from RFC 3986 section 2.2. For allowed characters, see RFC 3968 section 2.3.
- OneLake shortcut names, parent paths, and target paths can't contain "%" or "+" characters.
- Shortcuts don't support non-Latin characters.
- Copy Blob API isn't supported for ADLS or S3 shortcuts.
- Copy function doesn't work on shortcuts that directly point to ADLS containers. It's recommended to create ADLS shortcuts to a directory that is at least one level below a container.
- More shortcuts can't be created inside ADLS or S3 shortcuts.
- Lineage for shortcuts to Data Warehouses and Semantic Models isn't currently available.
- A Fabric shortcut syncs with the source almost instantly, but propagation time might vary due to data source performance, cached views, or network connectivity issues.
- It might take up to a minute for the Table API to recognize new shortcuts.
- OneLake shortcuts don't support connections to ADLS Gen2 storage accounts that use managed private endpoints. For more information, see managed private endpoints for Fabric.