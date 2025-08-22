# 📥 Automated File Ingestion and ETL Trigger in Microsoft Fabric

## 🎯 Goal
Automate ingestion of Excel files received via email, process them using a Gen2 Dataflow, and maintain semantic clarity through controlled naming and pipeline orchestration.

---

## 🛠️ Workflow Overview

1. **Trigger**: Email with Excel attachment arrives
2. **Power Automate Flow**:
   - Extract the attachment
   - Rename the file to match expected Dataflow input (e.g., `orders.xlsx`)
   - Upload the file to the **Lakehouse `/Files` root folder**
3. **Pipeline Execution**:
   - Trigger a Fabric pipeline via REST API or HTTP with Entra ID
   - Pipeline runs the **Gen2 Dataflow** configured to ingest `orders.xlsx`
   - Optional: Post-ETL file movement or logging can be added later

---

## ✅ Why This Approach Was Selected

- **Gen2 Dataflow compatibility**: Files must reside in the Lakehouse root folder
- **Simplified orchestration**: Power Automate handles file arrival and naming
- **Reproducibility**: File names are predictable and aligned with Dataflow configuration
- **Scalability**: Additional flows can be added for other domains (e.g., `customers.xlsx`, `inventory.xlsx`)

---

## 📌 Notes

- File naming convention ensures discoverability and onboarding clarity
- Pipeline can be extended to include post-ETL archiving or changelog logging
- Reflex triggers were considered but excluded due to subfolder ingestion limitations

