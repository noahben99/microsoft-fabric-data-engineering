**Query folding overview**
[query-folding-basics](https://learn.microsoft.com/en-us/power-query/query-folding-basics)
The goal of query folding is to offload or push as much of the evaluation of a query to a data source that can compute the transformations of your query.

The query folding mechanism accomplishes this goal by translating your M script to a language that your data source can interpret and execute. It then pushes the evaluation to your data source and sends the result of that evaluation to Power Query.

This operation often provides a faster query execution than extracting all the required data from your data source and running all transforms required in the Power Query engine.

When you use the get data experience, Power Query guides you through the process that ultimately lets you connect to your data source. When doing so, Power Query uses a series of functions in the M language categorized as accessing data functions. These specific functions use mechanisms and protocols to connect to your data source using a language that your data source can understand.

However, the steps that follow in your query are the steps or transforms that the query folding mechanism attempts to optimize. It then checks if they can be offloaded to your data source instead of being processed using the Power Query engine.

Depending on how the query is structured, there could be three **possible outcomes to the query folding mechanism**:
- Full query folding: When all of your query transformations get pushed back to the data source and minimal processing occurs at the Power Query engine.
- Partial query folding: When only a few transformations in your query, and not all, can be pushed back to the data source. In this case, only a subset of your transformations is done at your data source and the rest of your query transformations occur in the Power Query engine.
- No query folding: When the query contains transformations that can't be translated to the native query language of your data source, either because the transformations aren't supported or the connector doesn't support query folding. For this case, Power Query gets the raw data from your data source and uses the Power Query engine to achieve the output you want by processing the required transforms at the Power Query engine level.



## 🔄 Query Folding vs 📤 Delegation

Both **Query Folding** (Power Query) and **Delegation** (Power Apps) aim to optimize performance by pushing operations to the data source. Here's a side-by-side comparison:

| Concept            | Query Folding (Power Query)                                  | Delegation (Power Apps)                                      |
|--------------------|--------------------------------------------------------------|---------------------------------------------------------------|
| Purpose          | Push transformations to the data source                      | Push queries to the data source                               |
| Execution Time   | During data import or refresh                                | During app runtime                                            |
| Performance      | Reduces memory usage and speeds up refresh                   | Avoids pulling large datasets and hitting record limits       |
| Applies To       | Power BI, Excel, Fabric Dataflows                            | Canvas apps in Power Apps                                     |
| Diagnostics      | Folding indicators show which steps fold                     | Delegation warnings flag non-delegatable queries              |
| Limit Avoidance  | Prevents local execution of heavy transformations            | Prevents 500-record limit by executing queries remotely       |
| Transform Scope  | Filters, joins, aggregations, column transforms              | Filter, Sort, Search, Lookup functions                        |

### Best Practices

- **Power Query**: Keep folding intact by avoiding transformations that break it (e.g., `Text.Proper`, custom functions).
- **Power Apps**: Use delegatable functions and data sources (e.g., Dataverse, SQL) to maintain scalability.

### References

- [Query folding indicators in Power Query](https://learn.microsoft.com/en-us/power-query/step-folding-indicators)
- [Delegation overview in Power Apps](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/delegation-overview)


