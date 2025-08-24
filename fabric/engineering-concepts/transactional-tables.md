
# Transactional Tables and Star Schemas

❓Me
> Please explain how a transactional table in a financial ERP works within a star schema.
  
🤖 Copilot
> Great question, Steven — your familiarity with transaction tables in financial databases gives you a solid foundation for understanding fact tables in star schemas. They’re conceptually similar but serve slightly different purposes depending on the context.

### Similarities Between Transaction Tables and Fact Tables
| Aspect       | Transaction Table (Finance)                     | Fact Table (Star Schema)                          |
| :----------- | :---------------------------------------------- | :------------------------------------------------ |
| Granularity  | Each row = one financial event (e.g., payment)  | Each row = one business event (e.g., sale)        |
| Time-stamped | Includes transaction date/time                  | Includes date/time via foreign key to DateDim     |
| Measures     | Contains amounts, fees, balances                | Contains metrics like revenue, quantity, discount |
| Foreign Keys | Links to accounts, customers, products          | Links to dimensions like Product, Store, Customer |
| Immutable    | Typically append-only for audit trail           | Also append-only to preserve historical accuracy  |
| Used for BI  | Supports financial reporting and reconciliation | Supports analytical reporting and dashboards      |

### Key Differences
- Normalization vs. Denormalization:
    - Transaction tables are often normalized for integrity and storage efficiency.
    - Fact tables are denormalized to optimize query performance in analytical workloads.

- Purpose
    - Transaction tables are operational — used for day-to-day processing and compliance.
    - Fact tables are analytical — designed for slicing, dicing, and aggregating data.
- Design Philosophy:
    - Financial systems prioritize accuracy and auditability.
    - Star schemas prioritize speed and usability in BI tools like Power BI.

### Example Mapping
Let’s say you have a financial transaction table like this:


| TransactionID | AccountID | Date       | Amount  | Type       |
| :------------ | :-------- | :--------- | :------ | :--------- |
| 1001          | A123      | 2025-08-01 | 500.00  | Deposit    |
| 1002          | A123      | 2025-08-02 | -200.00 | Withdrawal |

In a star schema, this might translate to:

**Transaction Fact Table**

- DateKey
- AccountKey
- TransactionTypeKey
- Amount
- TransactionCount

**Dimension Tables**

AccountDim 
- AccountID
- HolderName
- Type

DateDim 
- DateKey
- Month
- Year

TransactionTypeDim
- Deposit
- Withdrawal
- Transfer


If you're thinking about modeling financial data in Fabric for analytics, you could absolutely treat your transaction tables as fact tables — just enrich them with dimension keys and structure them for performance.