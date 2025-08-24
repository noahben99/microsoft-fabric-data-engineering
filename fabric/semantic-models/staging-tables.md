
# Staging on tables to improve performance during data transformations  
❓Me
> I have a dataflow gen2 with several data sources.  One of those data sources only needs to be loaded once.  It's a reference table that is used to map values, for lookup purposes only.  The other data sources are dynamic, and should be refreshed whenever the whole dataflow is refreshed.  How can I do that? 


🤖 Copilot
> In Dataflows Gen2, you can manage the loading behavior of your data sources by utilizing the query settings. For your reference table, which only needs to be loaded once, you can disable the load of that specific query. To do this, navigate to the Queries pane, select the reference table query, and find the option to disable the load. This means that when you refresh the dataflow, the reference table will not be reloaded, and it will only be loaded once. This approach allows the other dynamic data sources to refresh as needed without affecting the reference table, optimizing performance by preventing unnecessary loads of static data.

In Microsoft Fabric, enabling staging on tables can significantly enhance performance during data transformations. Staging allows intermediate data to be stored temporarily, which can reduce the load on the primary data store and optimize the transformation processes. By using staging, you can perform complex transformations more efficiently, as it minimizes the need for repeated reads and writes to the main data storage, thus speeding up the overall data processing workflow. This approach is particularly beneficial when dealing with large datasets or complex transformation logic, as it allows for better resource management and improved throughput during data operations.


🔗 [Offload data staging and ETL processing to Data Lake Storage and Data Factory](https://learn.microsoft.com/en-us/azure/synapse-analytics/migration-guides/teradata/7-beyond-data-warehouse-migration#offload-data-staging-and-etl-processing-to-data-lake-storage-and-data-factory)

Digital transformation has created a key challenge for enterprises by generating a torrent of new data for capture and analysis. A good example is transaction data created by opening online transactional processing (OLTP) systems to service access from mobile devices. Much of this data finds its way into data warehouses, and OLTP systems are the main source. With customers now driving the transaction rate rather than employees, the volume of data in data warehouse staging tables has been growing rapidly.

With the rapid influx of data into the enterprise, along with new sources of data like Internet of Things (IoT), companies must find ways to scale up data integration ETL processing. One method is to offload ingestion, data cleansing, transformation, and integration to a data lake and process data at scale there, as part of a data warehouse modernization program.

Once you've migrated your data warehouse to Azure Synapse, Microsoft can modernize your ETL processing by ingesting and staging data in Data Lake Storage. You can then clean, transform, and integrate your data at scale using Data Factory before loading it into Azure Synapse in parallel using PolyBase.

For ELT strategies, consider offloading ELT processing to Data Lake Storage to easily scale as your data volume or frequency grows.
