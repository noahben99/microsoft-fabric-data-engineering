## Shortcuts
Shortcuts are useful when you need to source data that's in a different storage account or even a different cloud provider. Within your lakehouse you can create shortcuts that point to different storage accounts and other Fabric items like data warehouses, KQL databases, and other lakehouses.

Source data permissions and credentials are all managed by OneLake. When accessing data through a shortcut to another OneLake location, the identity of the calling user will be utilized to authorize access to the data in the target path of the shortcut. The user must have permissions in the target location to read the data.

Shortcuts can be created in both lakehouses and KQL databases, and appear as a folder in the lake. This allows Spark, SQL, Real-Time intelligence and Analysis Services to all utilize shortcuts when querying data

[OneLake shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts)
- [what-are-shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#what-are-shortcuts)
- [where-can-i-create-shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#where-can-i-create-shortcuts)
- [where-can-i-access-shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#where-can-i-access-shortcuts)
- [types-of-shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#types-of-shortcuts)
- [caching](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#caching)
- [limitations-and-considerations](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts#limitations-and-considerations)