# File Storage Strategy in Microsoft Fabric: Decision Summary

## Goal
Design a scalable, discoverable, and reproducible file storage workflow in Microsoft Fabric that:
- Supports ETL via Dataflows Gen2
- Enables semantic organization by domain and timestamp
- Facilitates onboarding and changelog hygiene
- Preserves future accessibility and clarity for collaborators

---

## Key Concerns
- **Dataflows Gen2 limitation**: Can only access files in the root of the Lakehouse `/Files` folder—not subfolders.
- **Cost efficiency**: ADLS Gen2 offers tiered pricing, but may be overkill for our storage needs (~4 TB).
- **Workflow clarity**: Need to track file origin, ETL status, and semantic meaning in folder structure.

---

## Options Considered

| Option | Pros | Cons | Outcome |
|--------|------|------|---------|
| **ADLS Gen2** | Tiered pricing (Hot/Cool/Archive), flexible folder structure | Higher complexity, not tightly integrated with Fabric, overprovisioned for our needs | ❌ Eliminated due to cost and complexity |
| **OneLake with subfolders (e.g., `/Files/Orders/...`)** | Semantic clarity, domain-based organization, future-proofing | Not accessible by Dataflows Gen2 for ETL | ✅ Used for post-ETL archiving |
| **OneLake root folder ingestion** | Compatible with Dataflows Gen2 | Flat structure, less semantic clarity | ✅ Used for staging incoming files |
| **Fabric Pipelines for file movement** | Supports subfolder routing, post-ETL archiving | Requires orchestration and logging | ✅ Selected for post-ETL file relocation |

---

## Final Workflow Design

1. **Incoming files land in `/Files` root**  
   Ensures compatibility with Dataflows Gen2 for ETL.

2. **Run Dataflow Gen2 to process the file**

3. **Use a Pipeline to move the file to semantic subfolder**  
   Example: `/Files/Orders/2025-08-22/data.csv`

4. **Log the move in a changelog or manifest file**  
   Tracks source, destination, timestamp, and ETL status.

---

## Why This Choice Was Selected

- Balances **Fabric limitations** with **semantic clarity**
- Enables **ETL compatibility** and **post-processing discoverability**
- Supports **onboarding documentation** and **future reproducibility**
- Avoids unnecessary cost and complexity of ADLS Gen2
