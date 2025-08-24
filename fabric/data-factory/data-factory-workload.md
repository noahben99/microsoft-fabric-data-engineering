# Microsoft Fabric Data Factory Workloads
- [What is the difference between Data Factory Workload and Power Query?](#jump-01)
- [Is a Data Factory Workload the same as Microsoft Fabric Data Factory?](#jump-02)
- [“Data Factory” in Fabric: A Conceptual Layer, Not a UI Label](#jump-03)

---
<a name="jump-01" /></a>

❓
> In Microsoft Fabric, what is the difference between Data Factory Workload and Power Query?

🤖 Copilot
> In Microsoft Fabric, Data Factory Workload and Power Query serve complementary but distinct roles in data integration and transformation.


### Data Factory Workload: Orchestration & Pipelines

**Purpose:**
- Designed for low-code orchestration of data movement and transformation across cloud-scale systems.

**Key Features:**
- Pipelines with multiple activities (copy, transformation, control flow)
- Supports incremental loads, watermarking, and CDC (Change Data Capture)
- Integrates with Dataflows Gen2, Power Automate, and Lakehouses
- Ideal for ETL engineers and data integrators

**Use Cases:**
- Medallion architecture ingestion
- Staging and archiving workflows
- Triggered automation across domains

**Skill Level:**
- Low-code / ETL / SQL-friendly

### Power Query: Data Wrangling & Transformation

**Purpose:**
- A no-code tool for interactive data preparation, often used by analysts and business users.

**Key Features:**
- GUI-based transformations (filtering, merging, pivoting)
- Integrated into Dataflows Gen2, Excel, Power BI, and even Fabric Pipelines
- Supports mashups across multiple data sources
- Great for lightweight transformations and exploratory prep

**Use Cases:**
- Domain-specific data shaping
- Onboarding-friendly transformation logic
- Semantic folder prep before pipeline ingestion

**Skill Level:**
- No-code / GUI-driven

### How They Work Together
You can embed Power Query steps inside Data Factory pipelines, especially when using Dataflows Gen2. This lets you:
- Use Power Query for transformation logic
- Use Data Factory for orchestration, scheduling, and automation
Think of it like this: 

| Layer              | Tool              | Role                            |
|--------------------|-------------------|----------------------------------|
| Transformation     | Power Query       | Wrangle, shape, prep data        |
| Orchestration      | Data Factory      | Move, schedule, automate         |
| Integration Bridge | Dataflows Gen2    | Connect both worlds              |


---
<a name="jump-02" /></a>

❓Me
> Tell me more about Data Factory Workloads.  Is that the same as Microsoft Fabric Data Factory?

🤖 Copilot
> Data Factory Workload is the Microsoft Fabric implementation of Data Factory. It’s not just a rebranding of Azure Data Factory; it’s a modernized, integrated experience tailored for Fabric’s unified analytics platform.

### What Is the Data Factory Workload in Microsoft Fabric?
Data Factory Workload refers to the dedicated experience within Microsoft Fabric for building, orchestrating, and automating data integration pipelines. It’s part of Fabric’s workload model, just like Power BI, Synapse, and Data Activator.
**Core Components:**

| Component | Description |                                                                       |
|:------------------------------------------------------------------------------------------------ |:--|:--|
| Data Pipelines | Low-code orchestration of ETL/ELT workflows across cloud and on-prem sources | |
| Dataflows Gen2 | GUI-based transformation using Power Query, embedded within pipelines |        |
| Copy Jobs | Fast, scalable data movement between supported connectors |                         |
| Apache Airflow Jobs | Advanced orchestration using Python-based DAGs (for pro users) |          |


### Why It’s Different from Azure Data Factory
While it shares DNA with Azure Data Factory, the Fabric version is:
- Integrated into OneLake and Fabric’s workspace model
- Optimized for Lakehouse ingestion and semantic modeling
- Copilot-enhanced for natural language pipeline generation and transformation explanations
- Unified with Power BI and other workloads, enabling end-to-end analytics in one platform

### How It Fits Your Workflow
Given your focus on reproducible onboarding and hybrid ETL, here’s how you might leverage it:
- Use Data Pipelines to orchestrate file movement from semantic folders into Lakehouse
- Embed Dataflows Gen2 for timestamped transformations and changelog logging
- Automate with triggers (e.g., storage events or scheduled refreshes)
- Document pipeline logic with Markdown snippets and Copilot-generated summaries


---
❓Me
> I feel like "data factory" is a concept that is not visible within the Fabric UI and appears more in marketing materials.

🤖 Copilot
> You're absolutely right, and you're picking up on a subtle but important distinction in how Microsoft Fabric presents itself.

## “Data Factory” in Fabric: A Conceptual Layer, Not a UI Label
In Fabric, Data Factory is essentially a workload—a collection of capabilities like pipelines, dataflows, copy activities, and orchestration tools. But unlike Power BI or Synapse, you won’t see a tab or label called “Data Factory” in the UI. Instead:
- Pipelines show up under “Data pipeline” items.
- Dataflows Gen2 are listed as “Dataflow” items.
- Copy jobs and Airflow orchestration are also categorized under “Processes”.
- The OneLake catalog and workspace views treat these as atomic items, not grouped under a “Data Factory” umbrella.
So yes—“Data Factory” is more of a marketing and documentation construct, used to describe the orchestration and transformation capabilities within Fabric. It’s helpful for positioning, but not reflected as a navigable entity in the UI.

## Strategic Implication for You
Since you're building onboarding-friendly workflows and semantic foldering, this abstraction can be a bit slippery. Here’s how you might handle it:
- Tag or prefix items with DF_ or ETL_ to semantically group Data Factory artifacts.
- Document your rationale in onboarding guides: e.g., “All items tagged DF_ are part of our orchestration layer (Fabric Data Factory workload).”
- Create semantic folders by domain + timestamp + workload type, even if Fabric doesn’t expose “Data Factory” as a filter.

