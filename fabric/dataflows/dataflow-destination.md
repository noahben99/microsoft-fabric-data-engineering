## Refreshing Column Mapping in Dataflows Gen2

To ensure destination schema reflects your latest transformations:
*This forces Fabric to re-map columns based on the final transformation step.*
1. Remove the destination table from the dataflow canvas
2. Re-select the same Lakehouse and table name
3. Confirm overwrite is enabled (if schema should be replaced)

---

## What Happens When Source Schema Changes?
### If You Add a Column to the Source:
- Fabric does not automatically update the destination schema.
- The new column will not be mapped unless you:
   - Remove and re-select the destination table (to trigger re-mapping)
   - Or enable overwrite mode, which replaces the destination schema with the new one

### If You Change a Columns Data Type:
- Fabric will attempt to load the data using the original destination schema.
- If the new type is compatible (e.g., Int64 → Double), it may succeed silently.
- If the new type is incompatible (e.g., Text → DateTime), the dataflow may:
   - Fail during execution
   - Or drop the column silently, depending on the backend behavior


### Behavior Summary
| Scenario                        | Outcome                                                   |
| :------------------------------ | :-------------------------------------------------------- |
| Add new column to source        | Not mapped unless destination is refreshed or overwritten |
| Rename column in source         | Treated as a new column; original mapping breaks          |
| Change data type (compatible)   | May succeed silently                                      |
| Change data type (incompatible) | May cause load failure or silent column drop              |




