
# Gen2 Workflow Documentation
❓Me
> After I build a complex gen2 workflow, what’s a best practice for documentation in GitHub, or is there a better place to document within the fabric ecosystem?

🤖 Copilot
> That’s a strategic question, Steven — and it shows your instinct for building not just performant workflows, but discoverable, maintainable systems. You’re absolutely right to think beyond just GitHub and consider how documentation fits into the Fabric ecosystem itself.

Let’s break down the best practices across both worlds:

🧾 In GitHub: Portfolio-Driven Documentation
Since you’re already optimizing for recruiter visibility and reproducibility, GitHub remains essential. Here’s how to document your Gen2 workflows effectively:

📁 Recommended Structure
```

/Dataflows/
├── CustomerSalesSummary/
│   ├── README.md
│   ├── lineage.md
│   ├── transformations.sql
│   └── refresh_schedule.md
```
### Key Files
- README.md: Overview of the dataflow’s purpose, inputs, outputs, and business logic
- lineage.md: Diagram or table showing source tables → transformations → output
- transformations.sql: If you used SQL steps, include snippets or pseudocode
- refresh_schedule.md: Document how and when the dataflow refreshes

### Bonus Tips
- Use badges or tags like #Fabric, #DataflowGen2, #DP-700 for discoverability
- Link to your Fabric workspace or Power BI report (if public or demo)
- Include screenshots of the visual flow or lineage graph

### Inside Fabric: Native Documentation & Lineage
- Fabric gives you built-in lineage and metadata tracking, which you can leverage for internal clarity and collaboration.

### Best Practices in Fabric
- Name your dataflow clearly: Use semantic naming like df_CustomerSalesSummary
- Add descriptions to each step: You can annotate transformations inside Gen2
- Use tags and labels: Fabric supports tagging datasets and flows for searchability
- Leverage the Lineage View: Fabric auto-generates lineage graphs showing source → transformation → destination → report

### Semantic Model Integration
- If your dataflow feeds a semantic model:
    - Document measures and calculated columns inside the model
    - Use description fields for each table and column
    - This metadata flows into Power BI and helps report consumers understand the logic

### Hybrid Strategy: GitHub + Fabric
| Purpose                | GitHub        | Fabric       |
| :--------------------- | :------------ | :----------- |
| Recruiter visibility   | ✅ Yes        | ❌ Limited   |
| Internal collaboration | ✅ Yes        | ✅ Yes       |
| Lineage tracking       | ✅ Manual     | ✅ Automatic |
| Transformation logic   | ✅ Scripted   | ✅ Visual    |
| Refresh orchestration  | ✅ Documented | ✅ Native    |


---
## Documentation Best Practices

### Be self-explanatory
- Assume the next person has zero context
- Avoid jargon unless you define it
- Include diagrams, examples, and step-by-step logic

### Be discoverable
- Easy to find, navigate, and search
- Organized by purpose (e.g., ingestion, transformation, reporting)

### Be version-aware
- Track changes over time
- Note why decisions were made (not just what was done)

### Best Practice: GitHub as Your Source of Truth
Even if Fabric has built-in lineage and metadata, GitHub gives you:

| Benefit              | Why It Matters                                          |
| :------------------- | :------------------------------------------------------ |
| Version control      | Track changes to logic, structure, and refresh strategy |
| Portfolio visibility | Showcase your work for future roles or collaborators    |
| Markdown flexibility | Embed code, diagrams, links, and notes in one place     |
| Offline resilience   | If Fabric changes or access shifts, your docs persist   |


### Suggested Structure
```

/FabricSolutions/
├── Dataflow_CustomerSales/
│   ├── README.md         # Overview, purpose, inputs/outputs
│   ├── lineage.md        # Diagram or table of data sources and flow
│   ├── logic.md          # Transformation steps, joins, filters
│   ├── refresh.md        # Schedule, triggers, dependencies
│   └── changelog.md      # What changed and why
```

### Inside Fabric: Use Metadata + Descriptions
Even though GitHub is your anchor, you can still enrich Fabric with:
- Step descriptions in Dataflow Gen2
- Table and column descriptions in semantic models
- Tags and labels for searchability
- Lineage view screenshots to include in GitHub

This creates a bridge between your technical logic and the visual ecosystem others will inherit.

### Bonus: Document Your Thought Process
- Why you chose certain joins or aggregations
- Why you materialized a view vs. used a Lakehouse table
- What trade-offs you considered (e.g., performance vs. clarity)

This turns your repo into a living playbook, not just a code dump.

