# Event-Driven Pipeline Trigger in Microsoft Fabric

##  Goal
Automatically trigger a Fabric pipeline when a new file is added to a OneLake Lakehouse folder (e.g., `/Files`), enabling ETL and post-processing workflows.

---

## Prerequisites
- A Lakehouse created in Fabric
- A pipeline that includes:
  - Dataflow Gen2 for ETL
  - File movement logic (e.g., to semantic subfolders)
- Access to Data Activator in Fabric
- File drop mechanism (e.g., Power Automate, manual upload, API)

---

## Step-by-Step Setup

### Step 1: Prepare Your Lakehouse
- Upload a test file to the root folder (`/Files`) of your Lakehouse
- Confirm that Dataflow Gen2 can access the file

### Step 2: Create a Pipeline
- Go to your Fabric workspace
- Create a new **pipeline**
- Add activities:
  - **Run Dataflow Gen2** to process the file
  - **Move or copy file** to semantic subfolder (e.g., `/Files/Orders/2025-08-22/`)
  - **Optional**: Add logging or manifest update

### Step 3: Create a Reflex Trigger
- Navigate to **Real-Time Workloads** > **Data Activator**
- Create a new **Reflex**
- Choose **Lakehouse file creation event** as the trigger
  - Select your Lakehouse and monitor the `/Files` folder
  - Set condition: *When a new file is added*
- Define the **action**:
  - Select **Run a pipeline**
  - Choose the pipeline you created in Step 2

### Step 4: Test the Trigger
- Upload a new file to the Lakehouse `/Files` folder
- Confirm that:
  - The pipeline is triggered automatically
  - The file is processed and moved
  - Logs or changelogs are updated (if configured)

---

## Notes
- Reflex triggers currently support file creation, not modification or deletion
- You can extend this flow with semantic routing based on filename patterns
- For onboarding clarity, consider adding a `README.md` or `manifest.json` in each domain folder

---

## Reference
For a full walkthrough, see Microsoft’s official guide on [building event-driven pipelines in Fabric](https://learn.microsoft.com/en-us/fabric/real-time-hub/tutorial-build-event-driven-data-pipelines).
