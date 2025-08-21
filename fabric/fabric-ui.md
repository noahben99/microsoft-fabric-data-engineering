
# Fabric UI Structure

## Navigation Tools

||||
|---|---|---|
|[ Home](https://app.fabric.microsoft.com/home?experience=fabric-developer)|<ul><li>Create A New Workspace</li><li>My Learning links</li><li>Recent Workspaces</li><li>Recent Items</li><li>Favorites</li></ul>|```/home```|
[ OneLake catalog / explore ](https://app.fabric.microsoft.com/onelake/explore?experience=power-bi)|All Objects in All Workspaces<br>**Data**<ul><li>Semantic Models</li><li>Lakehouse</li><li>Datamarts</li><li>KQL Databases</li><li>SQL Analytics Endpoint</li><li>SQL Database</li><li>Warehouse</li><li>Warehouse Snapshot</li><li>Mirrored database</li></ul>**Insights**<ul><li>Report</li><li>Dashboard</li><li>Paginated Report</li><li>Org App</li><li>Exploration</li><li>Data Agent</li><li>Metric Set</li><li>Real-Time Dashbaord</li><li>Map</li></ul>**Processes**<ul><li>API for GraphQL</li><li>Activator</li><li>Apache Airflow Job</li><li>Azure Data Factory</li><li>Copy Job</li><li>Data Agent</li><li>Data Pipeline</li><li>Dataflow</li><li>Eventstream</li><li>KQL Queryset</li><li>ML Model</li><li>Mirrored database</li><li>Notebook</li><li>Spark Job Definition</li><li>User data</li></ul>**Solutions**<ul><li>...</li></ul>**Configurations**<ul><li>Environment</li><li>Variable Library</li></ul>|```/onelake/explore```|
[ OneLake catalog / govern ](https://app.fabric.microsoft.com/onelake/govern?experience=power-bi)|View key insights about the content you've created in Fabric.|```/onelake/govern```|
[ Monitoring Hub](https://app.fabric.microsoft.com/monitoringhub?experience=fabric-developer)|View and track the status of the activities<br>across all the workspaces for which you<br>have permissions within Microsoft Fabric.|```/montitoringhub```|
## Workspaces

||||
|---|---|---|
|Manage objects in **a** workspace<br>• [(List View)](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/list)<br>• [(Diagram View)](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lineage)|View existing workspace objects<br>and create new ones|```/groups/{group_id}/list```<br>```/groups/{group_id}/lineage```|
|Manage objects in **my** workspace<br>• [(List View)](https://app.fabric.microsoft.com/groups/me/list)<br>• [(Diagram View)](https://app.fabric.microsoft.com/groups/me/lineage)|View existing workspace objects<br>and create new ones|```/groups/me/list```<br>```/groups/me/lineage```|

## Lake Warehouses
||||
|---|---|---|
|[ manage a lakewarehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lakehouses/2c46dab1-6936-4961-9bbc-fecc53ac536b)| **<span style='color:#e56845;font-weight:800;text-decoration:underline'>SQL Object Explorer**|```/groups/{group_id}/lakewarehouses/{lakewarehouse_id}```|
|[ get query history in lakewarehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lakewarehouses/293100c0-8596-4028-b2b1-295f70ff37a9/warehouseMonitoring)|View Query Activity: • Query Text • Time • Status • Submitted By • Session Id • Run Source|```/groups/{group_id}/lakewarehouses/{lakewarehouse_id}/warehouseMonitoring```|
|[ get objects in a lakewarehouse](https://app.fabric.microsoft.com/datahub/artifacts/293100c0-8596-4028-b2b1-295f70ff37a9?experience=power-bi)|View includes Lakehouses, Dataflows,Semantic Models, etc.|```/datahub/artifacts/{lakewarehouse_id}```|

## Mirrored Lakehouses
||||
|---|---|---|
|[ manage a mirrored lakehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/mirroredwarehouses/293100c0-8596-4028-b2b1-295f70ff37a9)|**<span style='color:#e56845;font-weight:800;text-decoration:underline'>SQL Object Explorer**|```/groups/{group_id}/mirroredwarehouses/{lakewarehouse_id}```|

## Lakehouses

||||
|---|---|---|
|[ get objects in a lakehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lakehouses/2c46dab1-6936-4961-9bbc-fecc53ac536b)|**SQL Object Explorer**<br>*read only*|```/groups/{group_id}/lakehouses/{lakehouse_id}```|

## Data Factory

||||
|---|---|---|
|[manage a pipeline](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/pipelines/246b6946-7e47-48fe-bb9c-e6cea141581e?experience=fabric-developer)|**<span style='color:#e56845;font-weight:800;text-decoration:underline'>Data Factory**|```/groups/{group_id}/pipelines/{pipeline_id}```|
|[ manage a dataflow](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/dataflows-gen2/97fcf54b-aa42-43c3-9177-25751d117932)|**<span style='color:#e56845;font-weight:800;text-decoration:underline'>Power Query**|```/groups/{group_id}/dataflows-gen2/{dataflow_id}```|
|[ get objects in a dataflow](https://app.fabric.microsoft.com/datahub/artifacts/97fcf54b-aa42-43c3-9177-25751d117932)|View existing objects in the dataflow with links to explore each one.|```/datahub/artifacts/{dataflow_id}```|
## Datasets
||||
|---|---|---|
|[ get details of a dataset](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/datasets/e92a9cfc-c66b-4015-81e0-1cfdd35bc1c6/details) |View objects such as dataflows,lakehouses, etc.<br>*same response as get objects in a dataset*|```/groups/{group_id}/datasets/{dataset_id}/details```|
|[ explore a dataset](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/datasets/e92a9cfc-c66b-4015-81e0-1cfdd35bc1c6/explorations) |View the semantic model for a dataset|```/groups/{group_id}/datasets/{dataset_id}/details```|
|[ get objects in a dataset](https://app.fabric.microsoft.com/datahub/datasets/e92a9cfc-c66b-4015-81e0-1cfdd35bc1c6)|View objects such as dataflows,lakehouses, etc.<br>*same response as get details of a dataset*|```datahub/datasets/{dataset_id}```|




