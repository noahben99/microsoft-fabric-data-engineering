
# Fabric UI

- 🔗[OneLake catalog](#bookmark-00)
- 🔗[Navigation Tools](#bookmark-01)
- 🔗[Workspaces](#bookmark-02)
- 🔗[Workspace Settings](#bookmark-03)
- 🔗[Lake Warehouses](#bookmark-04)
- 🔗[Mirrored Lakehouses](#bookmark-05)
- 🔗[Lakehouses](#bookmark-06)
- 🔗[Data Factory](#bookmark-07)
- 🔗[Datasets](#bookmark-08)
- 🔗[User Settings](#bookmark-09)


## OneLake catalog
<a name="bookmark-00" /><a>

|<img src="..\images\one-lake-catalog-by-category.png" >

## Navigation Tools

<a name="bookmark-01" /><a>
||||
|---|---|---|
|[ Home](https://app.fabric.microsoft.com/home?experience=fabric-developer)|<ul><li>Create A New Workspace</li><li>My Learning links</li><li>Recent Workspaces</li><li>Recent Items</li><li>Favorites</li></ul>|```/home```|
[ Monitoring Hub](https://app.fabric.microsoft.com/monitoringhub?experience=fabric-developer)|View and track the status of the activities<br>across all the workspaces for which you<br>have permissions within Microsoft Fabric.|```/montitoringhub```|

<a name="bookmark-02" /><a>
## Workspaces

||||
|---|---|---|
|Manage objects in **a** workspace<br>• [(List View)](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/list)<br>• [(Diagram View)](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lineage)|View existing workspace objects<br>and create new ones|```/groups/{group_id}/list```<br>```/groups/{group_id}/lineage```|
|Manage objects in **my** workspace<br>• [(List View)](https://app.fabric.microsoft.com/groups/me/list)<br>• [(Diagram View)](https://app.fabric.microsoft.com/groups/me/lineage)|View existing workspace objects<br>and create new ones|```/groups/me/list```<br>```/groups/me/lineage```|



<a name="bookmark-03" /><a>
## Workspace Settings

||||
|---|---|---|
|[Dashboards](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/settings/dashboards)|Manage Dashboards|```/groups/{group_id}/settings/dashboards```|
|[Semantic Models](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/settings/datasets)|Manage Semantic Models|```/groups/{group_id}/settings/datasets```|
|[Workbooks](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/settings/workbooks)|Manage workbooks|```/groups/{group_id}/settings/workbooks```|
|[reports](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/settings/reports)|Manage reports|```/groups/{group_id}/settings/reports```|
|[dataflows](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/settings/dataflows)|Manage dataflows|```/groups/{group_id}/settings/dataflows```|
|[apps](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/settings/apps)|Manage apps|```/groups/{group_id}/settings/apps```|





<a name="bookmark-04" /><a>
## Lake Warehouses
||||
|---|---|---|
|[ manage a lakewarehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lakehouses/2c46dab1-6936-4961-9bbc-fecc53ac536b)| **<span style='color:#e56845;font-weight:800;text-decoration:underline'>SQL Object Explorer**|```/groups/{group_id}/lakewarehouses/{lakewarehouse_id}```|
|[ get query history in lakewarehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lakewarehouses/293100c0-8596-4028-b2b1-295f70ff37a9/warehouseMonitoring)|View Query Activity: • Query Text • Time • Status • Submitted By • Session Id • Run Source|```/groups/{group_id}/lakewarehouses/{lakewarehouse_id}/warehouseMonitoring```|
|[ get objects in a lakewarehouse](https://app.fabric.microsoft.com/datahub/artifacts/293100c0-8596-4028-b2b1-295f70ff37a9?experience=power-bi)|View includes Lakehouses, Dataflows,Semantic Models, etc.|```/datahub/artifacts/{lakewarehouse_id}```|



<a name="bookmark-05" /><a>
## Mirrored Lakehouses
||||
|---|---|---|
|[ manage a mirrored lakehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/mirroredwarehouses/293100c0-8596-4028-b2b1-295f70ff37a9)|**<span style='color:#e56845;font-weight:800;text-decoration:underline'>SQL Object Explorer**|```/groups/{group_id}/mirroredwarehouses/{lakewarehouse_id}```|



<a name="bookmark-06" /><a>
## Lakehouses

||||
|---|---|---|
|[ get objects in a lakehouse](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/lakehouses/2c46dab1-6936-4961-9bbc-fecc53ac536b)|**SQL Object Explorer**<br>*read only*|```/groups/{group_id}/lakehouses/{lakehouse_id}```|



<a name="bookmark-07" /><a>
## Data Factory

||||
|---|---|---|
|[manage a pipeline](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/pipelines/246b6946-7e47-48fe-bb9c-e6cea141581e?experience=fabric-developer)|**<span style='color:#e56845;font-weight:800;text-decoration:underline'>Data Factory**|```/groups/{group_id}/pipelines/{pipeline_id}```|
|[ manage a dataflow](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/dataflows-gen2/97fcf54b-aa42-43c3-9177-25751d117932)|**<span style='color:#e56845;font-weight:800;text-decoration:underline'>Power Query**|```/groups/{group_id}/dataflows-gen2/{dataflow_id}```|
|[ get objects in a dataflow](https://app.fabric.microsoft.com/datahub/artifacts/97fcf54b-aa42-43c3-9177-25751d117932)|View existing objects in the dataflow with links to explore each one.|```/datahub/artifacts/
{dataflow_id}```|

<a name="bookmark-08" /><a>
## Datasets
||||
|---|---|---|
|[ get details of a dataset](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/datasets/e92a9cfc-c66b-4015-81e0-1cfdd35bc1c6/details) |View objects such as dataflows,lakehouses, etc.<br>*same response as get objects in a dataset*|```/groups/{group_id}/datasets/{dataset_id}/details```|
|[ explore a dataset](https://app.fabric.microsoft.com/groups/de54c96a-73b9-4a80-b764-55b55da97475/datasets/e92a9cfc-c66b-4015-81e0-1cfdd35bc1c6/explorations) |View the semantic model for a dataset|```/groups/{group_id}/datasets/{dataset_id}/details```|
|[ get objects in a dataset](https://app.fabric.microsoft.com/datahub/datasets/e92a9cfc-c66b-4015-81e0-1cfdd35bc1c6)|View objects such as dataflows,lakehouses, etc.<br>*same response as get details of a dataset*|```datahub/datasets/{dataset_id}```|





<a name="bookmark-09" /><a>
## User Settings

||||
|---|---|---|
|[General](https://app.fabric.microsoft.com/user/user-settings/general)|Display language, privacy|```/user/user-settings/general```|
|[Power BI Subscriptions](https://app.fabric.microsoft.com/user/user-settings/notifications/subscriptions)|Manage subscriptions|```/user/user-settings/notifications/subscriptions```|
|[Power BI Alerts](https://app.fabric.microsoft.com/user/user-settings/notifications/alerts)|Manage alerts|```/user/user-settings/notifications/alerts```|
|[Power BI Settings](https://app.fabric.microsoft.com/user/user-settings/notifications/settings)|**Email**<br>• Send me an email digest of updates to my frequents and content viewed by my organization<br><br>**Teams**<br>• Send me a notification on the latest activity in Power BI<br>• Send me a reminder when someone shares an item with me<br>• Send me a reminder when someone requests access to an item I own|```/user/user-settings/notifications/settings```|
|[Item Settings](https://app.fabric.microsoft.com/user/user-settings/notifications/item-settings)|**Power BI**<br>• Use ArcGIS for Power BI|```/user/user-settings/notifications/item-settings```|
|[Developer Settings](https://app.fabric.microsoft.com/user/user-settings/notifications/developer-settings)|**Power BI Developer mode**<br>• Turn developer mode on when you want to develop a Power BI visual.|```/user/user-settings/notifications/developer-settings```|