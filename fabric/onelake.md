[Microsoft OneLake file explorer for Windows](https://www.microsoft.com/en-us/download/details.aspx?id=105222)

OneLake
OneLake is Fabric's centralized data storage architecture that enables collaboration by eliminating the need to move or copy data between systems. OneLake unifies your data across regions and clouds into a single logical lake without moving or duplicating data.

OneLake is built on Azure Data Lake Storage (ADLS) and supports various formats, including Delta, Parquet, CSV, and JSON. All compute engines in Fabric automatically store their data in OneLake, making it directly accessible without the need for movement or duplication. For tabular data, the analytical engines in Fabric write data in delta-parquet format and all engines interact with the format seamlessly.

Shortcuts are references to files or storage locations external to OneLake, allowing you to access existing cloud data without copying it. Shortcuts ensure data consistency and enable Fabric to stay in sync with the source.

![onelake-architecture](https://learn.microsoft.com/en-us/training/wwl/introduction-end-analytics-use-microsoft-fabric/media/onelake-architecture.png)


Discover data with OneLake catalog
The OneLake catalog in Microsoft Fabric helps users easily find and access various data sources within their organization. Users explore and connect to data sources, ensuring they have the right data for their needs. Users only see items shared with them. Here are some considerations when using OneLake catalog:

Narrow results by workspaces or domains (if implemented).
Explore default categories to quickly locate relevant data.
Filter by keyword or item type.

![onelake-catalog](https://learn.microsoft.com/en-us/training/wwl/introduction-end-analytics-use-microsoft-fabric/media/onelake-catalog.png)