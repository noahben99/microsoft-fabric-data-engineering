### Save vs Save and Run in Dataflows Gen2

#### Use **Save** when:
- You want to **preserve your query logic** without triggering execution.
- You're still **testing or refining transformations**.
- You’re preparing the dataflow for **scheduled or triggered runs** later (e.g. via pipeline or Power Automate).
- You want to **avoid writing to the destination table** until you're ready.

#### Use **Save and run** when:
- You’ve finalized your transformations and want to **execute the dataflow immediately**.
- You need to **validate output** in the Lakehouse (e.g. schema, row count, column mapping).
- You’re doing a **manual test run** before automating or scheduling.
- You want to **log results** for onboarding or changelog documentation.

#### Tip: 
If you're troubleshooting pipeline triggers or validating changelog logging, “Save and run” gives you immediate feedback. For version-controlled onboarding flows, “Save” lets you stage changes before execution.
