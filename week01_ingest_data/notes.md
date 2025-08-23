# 📚 Week 1 – Ingest data with Microsoft Fabric

> Module link: [Ingest Data with Microsoft Fabric](https://learn.microsoft.com/en-us/training/paths/ingest-data-with-microsoft-fabric/)  
> Dates: 2025-08-17 → YYYY‑MM‑DD

---

## 🎯 Module Objectives
By the end of this module, I will be able to:
- Explain the core ingestion capabilities of Microsoft Fabric
- Identify supported data sources and connectors
- Set up and configure a Data Pipeline in Fabric
- Monitor, validate, and troubleshoot ingestion jobs

---

## 🛠 Hands‑On Labs

### Lab 1 – Connect to a Data Source
- **Goal:** Connect Fabric to a sample source (e.g., Azure Blob Storage, SQL DB)
- **Steps:**  
  1. Open Fabric workspace → Data Engineering experience  
  2. Create new Data Pipeline  
  3. Add `Copy Data` activity from source to Lakehouse  

---

### Lab 2 – Transform on Ingest
- **Goal:** Apply basic transformations during ingestion
- **Steps:**  
  1. Configure mapping in Dataflow Gen2  
  2. Apply filters, column renames, and data type conversions  
  3. Validate schema in Lakehouse explorer  

---

### Lab 3 – Monitor & Troubleshoot
- **Goal:** Use monitoring tools to track pipeline runs
- **Steps:**  
  1. Access Activity Run view  
  2. Check success/failure logs  
  3. Export and store run history in `/assets` for documentation  

---

## 🖼 Key Screenshots
> *(Save images into `week01_ingest_data/assets/` and embed them here)*

1. **Fabric workspace & pipeline overview**
   ![Pipeline Overview](assets/pipeline_overview.png)
2. **Dataflow mapping settings**
   ![Dataflow Mapping](assets/dataflow_mapping.png)
3. **Successful ingestion run log**
   ![Ingestion Log](assets/ingestion_log.png)

---

## 💭 Reflection
- **What I learned:**  
  _e.g., “How Fabric simplifies ingestion with native connectors.”_
- **Challenges faced:**  
  _e.g., “Connection failed when using service principal — resolved by updating credential scope.”_
- **Next steps:**  
  _e.g., “Explore incremental load patterns for large datasets in Week 2.”_

---

## ✅ Completion Checklist
- [ ] All labs completed successfully
- [ ] Screenshots captured and saved in `/assets`
- [ ] README link to this file verified
- [ ] Reflection section filled in
