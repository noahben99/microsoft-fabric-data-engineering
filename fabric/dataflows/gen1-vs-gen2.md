# Gen2 Dataflows vs Power Query Gen1 Dataflows

❓Me
> Tell me some differences between Gen2 dataflows and what I am used to doing in Power Query through Power BI in the past.

🤖 Copilot
> Dataflows Gen2 in Microsoft Fabric present several differences compared to the Power Query experience you are familiar with in Power BI. One of the main enhancements is the integration of Power Query Online within Dataflows Gen2, which allows for a more visual representation of transformations. Users can connect to a wide variety of data sources, including cloud and on-premises databases, Excel files, and Fabric lakehouses, facilitating seamless data ingestion.

In terms of transformations, Dataflows Gen2 supports familiar operations such as filtering, sorting, merging, and pivoting. However, the interface is designed to be more intuitive, featuring a Diagram View that visually displays how data sources are connected and transformed. This visual aid can help you better understand the flow of data and the applied transformations.

Another significant difference is how queries are managed. In Dataflows Gen2, queries are referred to as tables once loaded into the data store, and users can easily duplicate or reference these queries. This functionality streamlines data modeling processes, allowing for efficient creation of structures like star schemas without extensive manual configuration. Additionally, Dataflows Gen2 provide a low-to-no-code solution, making it more accessible for users who may not have coding expertise, while still retaining the powerful transformation capabilities you are accustomed to in Power BI.

Lastly, Dataflows Gen2 also include performance optimization features, such as enabling staging on tables which can greatly enhance performance during data transformations. This capability allows for better resource management and improved throughput, especially when working with large datasets or complex transformation logic, making your data processing workflows more efficient.
