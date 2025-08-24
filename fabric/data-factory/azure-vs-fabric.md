## Differences between Azure Data Factory and Fabric Data Factory
❓
> I have used Azure Data Factory, both piplelines and dataflows.  What is the equivalent of these technologies in Fabric?


**🤖 Copilot’s Response**  
> In Microsoft Fabric, the equivalent of Azure Data Factory’s pipelines is referred to as data pipelines. These data pipelines in Fabric work seamlessly with Lakehouse, Data Warehouse, and other Fabric services. For data transformation, Azure Data Factory’s dataflows are equivalent to Dataflow Gen2 in Fabric, which provides a simpler experience for building transformations and offers more capabilities than the previous versions.
<br>Additionally, the concepts of linked services and datasets in Azure Data Factory have been simplified in Fabric to just connections, which are easier to set up and manage. This streamlining allows users to focus on their data integration tasks without the complexity of previous configurations.


🔗 [Differences between Azure Data Factory and Fabric Data Factory](https://learn.microsoft.com/en-us/fabric/data-factory/compare-fabric-data-factory-and-azure-data-factory)  


| Azure Data Factory                              | Data Factory in Fabric                  | What's Different |
|-------------------------------------------------|------------------------------------------|------------------|
| Pipeline                                        | Data pipeline                            | **Better integration:** Works seamlessly with Lakehouse, Data Warehouse, and other Fabric services out of the box. |
| Mapping data flow                               | Dataflow Gen2                            | **Easier to use:** Simpler experience for building transformations; more mapping dataflow features are being added over time. |
| Activities                                      | Activities                               | **More activities coming:** Includes new ones like Office 365 Outlook activity not in ADF. See Activity overview for details. |
| Dataset                                         | Connections only                         | **Simpler approach:** No complex dataset configurations; use connections to link to data sources and start working. |
| Linked Service                                  | Connections                              | **More intuitive:** Same concept as linked services but easier to set up and manage. |
| Triggers                                        | Schedule and file event triggers         | **Built-in scheduling:** Fabric’s scheduler and Reflex events run pipelines automatically; file event triggers work natively. |
| Publish                                         | Save and Run                             | **No publishing step:** Just Save to store or Run to save and execute immediately. |
| Autoresolve and Azure Integration runtime       | Not needed                               | **Simplified architecture:** No integration runtimes to manage; Fabric handles compute. |
| Self-hosted integration runtimes                | On-premises Data Gateway                 | **Same on-premises access:** Use the familiar On-premises Data Gateway. |
| Azure-SSIS integration runtimes                 | To be determined                         | **Future capability:** SSIS integration design in progress for Fabric. |
| Managed virtual networks and private endpoints  | To be determined                         | **Future capability:** Integration for managed VNETs and private endpoints in progress. |
| Expression language                             | Expression language                      | **Same expressions:** Existing syntax transfers directly. |
| Authentication types                            | Authentication kinds                     | **More options:** All ADF authentication methods work in Fabric, plus new types added. |
| CI/CD                                           | CI/CD                                    | **Coming soon:** Full CI/CD capabilities planned for Fabric Data Factory. |
| ARM export/import                               | Save as                                  | **Quick duplication:** Use "Save as" to duplicate pipelines for dev or testing. |
| Monitoring                                      | Monitoring hub + Run history             | **Advanced monitoring:** Modern hub with cross-workspace insights and better drill-down. |