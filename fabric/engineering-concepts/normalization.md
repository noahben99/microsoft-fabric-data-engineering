

# Normalization and denormalization

❓Me
> Tell me more about normalization and denormalization

🤖 Copilot
> Understanding normalization and denormalization is key to designing efficient databases and analytical models. These concepts shape how data is structured, stored, and queried — especially in systems like Microsoft Fabric, where both transactional and analytical workloads coexist.

### Normalization — “Organize to Minimize Redundancy”
Normalization is the process of structuring a relational database to reduce data duplication and improve data integrity.

🔹 Goals:
- Eliminate redundant data
- Ensure consistency across updates
- Break data into logical, related tables

🔹 Example:
Instead of storing customer names in every order record:

Orders Table

| OrderID | CustomerID | Date       |
| :------ | :--------- | :--------- |
| 1001    | C001       | 2025-08-01 |

Customers Table

| CustomerID | FullName      | Email            |
| :--------- | :------------ | :--------------- |
| C001       | Steven Jacobs | steven@email.com |

Now, if Steven updates his email, it only changes in one place.


### Denormalization — “Flatten for Speed”
Denormalization is the process of intentionally adding redundancy to improve query performance, especially in analytical systems.

🔹 Goals:
- Reduce joins during queries
- Speed up reads for dashboards and reports
- Simplify schema for BI tools

🔹 Example:
Instead of joining multiple tables, you might store customer name directly in the orders table:

Orders Table (Denormalized)

| OrderID | CustomerName  | Email            | Date       |
| :------ | :------------ | :--------------- | :--------- |
| 1001    | Steven Jacobs | steven@email.com | 2025-08-01 |

This makes reporting faster, but if Steven changes his name, you now have to update it in every row.

### When to Use Each
| Use Case                               | Normalization                     | Denormalization                 |
| :------------------------------------- | :-------------------------------- | :------------------------------ |
| OLTP (Online Transaction Processing)   | ✅ Yes — integrity and efficiency | ❌ Avoid — slows writes         |
| OLAP (Online Analytical Processing)    | ❌ Avoid — too many joins         | ✅ Yes — faster reads           |
| Microsoft Fabric Lakehouse / Warehouse | ❌ Avoid deep normalization       | ✅ Favor star/snowflake schemas |


---

# "Normal Form" Concepts 
**1NF – First Normal Form**
Rule: Every column should contain atomic values — meaning indivisible, single pieces of data.
- ❌ Bad: PhoneNumbers = "123-4567, 987-6543" (a list in one field)
- ✅ Good: Each phone number gets its own row or column
Why it matters: It prevents ambiguity and makes querying easier. You don’t want to parse lists inside cells.

**2NF – Second Normal Form**
Rule: No partial dependencies on a composite key (a key made of multiple columns).
- Applies only if your table has a composite primary key.
- A column should depend on the whole key, not just part of it.
Example: If your key is (StudentID, CourseID), then CourseName should not be in the same table — it depends only on CourseID, not the full key.
Why it matters: Keeps related data in the right place and avoids duplication across rows.

**3NF – Third Normal Form**
Rule: No transitive dependencies — non-key columns should depend only on the primary key.
- ❌ Bad: StudentID → AdvisorID → AdvisorName
- ✅ Good: Split into two tables: one for students, one for advisors
Why it matters: Prevents update anomalies. If an advisor’s name changes, you don’t want to update it in 50 places.

**Why “Normal Form”?**
- In logic and mathematics, a "normal form" is a way to simplify or standardize expressions so they follow a consistent structure.
- Codd applied this idea to databases: each "normal form" represents a level of refinement in how data is structured.
- The goal was to make databases more predictable, efficient, and resistant to update anomalies.


**Why are they numbered 1NF, 2NF, 3NF?**
The numbering reflects a progressive hierarchy:

| Normal Form | What It Fixes                          | Builds On          |
| :---------- | :----------------------------------- | :---------------- |
| 1NF         | Atomic values                         | no repeating groups |
| 2NF         | No partial dependencies on composite keys | 1NF               |
| 3NF         | No transitive dependencies             | 2NF               |

- Each form inherits the rules of the previous one and adds stricter constraints.

