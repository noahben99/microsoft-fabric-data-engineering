

2) Within the new workspace, select create > Lakehouse

> **Something went wrong**
**Sorry, we are unable to start trial at this time.**
**Please try again later or contact support. If you contact support, please provide these details.**
Activity ID: a5029d7a-d51f-4c38-979b-d683a334811b
Request ID: 60b7dfb7-d4e0-c4be-5f56-c0444a9eac06
Correlation ID: a6ae9e18-4781-b656-1cdf-7098dd2bf688
Status code: 200
Time: Wed Aug 20 2025 09:32:35 GMT-0400 (Eastern Daylight Time)
Service version: 13.0.26462.33
Client version: 2508.1.25357-train
Cluster URI: https://wabi-us-east2-e-primary-redirect.analysis.windows.net/

>**Upgrade to a free Microsoft Fabric trial**
To create Lakehouse and other Fabric items, this workspace, mslearn-fabric, needs to be assigned to a Fabric capacity. To try Microsoft Fabric features, select Upgrade to assign this workspace to your free Fabric trial capacity. 
[Learn more](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial)
• Failed to prepare a free trial capacity for this workspace

>❓ In MS Fabric, I created a new workspace called 'mslearn-fabric'. I navigated to that workspace, and then attempted to create a new Lakehouse. I received this error message: "To create Lakehouse and other Fabric items, this workspace, mslearn-fabric, needs to be assigned to a Fabric capacity. To try Microsoft Fabric features, select Upgrade to assign this workspace to your free Fabric trial capacity. Failed to prepare a free trial capacity for this workspace. ". Please help troubleshoot and provide guidance how to assign this workspace to my free Fabric trial capacity.

**🤖 Copilot's Response**

✅ Step-by-Step Fix
1. Verify Trial Capacity Exists
Go to Fabric Home and check the top banner or workspace dropdown. You should see something like:

```
Trial: 59 days left
```
If you don’t see this, go to https://app.fabric.microsoft.com/trial and activate the trial manually.

2. Assign Trial Capacity to Workspace
- Navigate to Fabric Home
- Click on the workspace dropdown and select mslearn-fabric
- Click the Upgrade button (or **gear icon** > Workspace settings)
- In the Capacity assignment section:
    - Choose your trial capacity (it may be named something like Trial (YourName) or Fabric Trial)
    - Click Assign

If the Upgrade button fails again, try creating a new workspace and assigning capacity during creation — this often bypasses the issue.

3. Verify Assignment

- Once assigned, go back to **mslearn-fabric** and click **Create > Lakehouse**. You should no longer see the error.
- You can also verify capacity assignment by:
    - Going to **Admin Portal > Capacity Settings**
    - Checking which workspaces are assigned to your trial capacity


> ❓Please help troubleshoot this step, i cannot find the upgrade button. Navigate to Fabric Home Click on the workspace dropdown and select mslearn-fabric Click the Upgrade button (or gear icon > Workspace settings)

**🤖 Copilot's Response**

ou're already in the right place. The issue is that your workspace settings page doesn’t show the “Upgrade” button because the trial capacity wasn’t successfully provisioned or assigned. Let’s walk through a workaround that’s helped other users in similar situations:

🛠️ Fix: Assign Trial Capacity via Admin Portal
1. [Go to Admin Portal
](https://app.fabric.microsoft.com/admin-portal/ppuTenantSettings?experience=fabric-developer)
If you don’t have access, try switching to a different Fabric tenant or admin role (some trial tenants restrict this)

2. Check Capacity Settings
In the left pane, go to Capacity Settings

Look for a capacity named something like Trial (YourName) or Fabric Trial

If it exists, click into it and check which workspaces are assigned

3. Manually Assign Workspace
If mslearn-fabric is not listed, click Assign Workspace

Select mslearn-fabric from the dropdown

Confirm the assignment

🧪 Alternate Fix: Create a New Workspace with Capacity Assigned
Sometimes the trial capacity fails to attach to an existing workspace due to backend timing issues. Try this:

Go to Fabric Home

Click Workspaces > New Workspace

Name it something like fabric-lakehouse-lab

During creation, look for a Capacity dropdown — select your trial capacity

Once created, try creating a Lakehouse inside this new workspace