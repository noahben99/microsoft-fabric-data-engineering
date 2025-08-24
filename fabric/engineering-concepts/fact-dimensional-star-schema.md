
# Fact tables Dimensional tables and Star Schema
❓Me
> Please tell me more about fact tables Dimensional tables and Star Schema


🤖 Copilot
> Fact and dimension tables are the backbone of star schema and snowflake schema designs in data warehousing, and they’re central to how Microsoft Fabric’s Data Warehouse and Lakehouse models organize analytical data.

### Fact Tables — The “What Happened”
Fact tables store measurable, quantitative data — the actual events or transactions you want to analyze.

**Characteristics**
- Contain metrics like sales amount, quantity, revenue, clicks, etc.
- Include foreign keys pointing to related dimension tables
- Often very large — millions or billions of rows
- Support aggregations (SUM, AVG, COUNT) in BI tools

**Example**
| DateKey	| ProductKey	| StoreKey	| SalesAmount |	UnitsSold|
|------------|------------|------------|------------|------------|
|20250801|101|501|1200.00|3|

This row says: *“On August 1st, product 101 was sold at store 501 for $1200, 3 units.”*

### Dimension Tables — The “Context”
Dimension tables store descriptive attributes — the who, what, where, when, and how of each fact.

**Characteristics**
- Contain textual or categorical data (names, categories, locations)
- Are typically wide (many columns) but shallow (fewer rows)
- Help slice and filter fact data in reports
- Often used in hierarchies (e.g., Year → Quarter → Month)

**Example: Product Dimension**
|ProductKey|ProductName|Category|Brand|
|----|----|----|----|
|101|Fabric Hoodie|Apparel|Contoso|

This lets you say: *“Show me total sales by brand” or “Compare hoodie sales across categories.”*

**How They Work Together**
In a star schema, the fact table sits at the center, surrounded by dimension tables:


```
           +-------------+
           | Date Dim    |
           +-------------+
                 |
+-------------+  |  +-------------+
| Product Dim |--+--| Store Dim   |
+-------------+     +-------------+
        \             /
         \           /
     +------------------+
     |   Fact Table     |
     +------------------+
```

In Fabric’s Data Warehouse and Lakehouse:

- You define fact tables in SQL or Delta format to store metrics
- You build dimension tables to support semantic models in Power BI
- You can use Direct Lake mode to query them directly from Power BI with blazing speed

Here’s a full star schema design for a Fabric-based sales dashboard.

## 🌟 Star Schema: Retail Sales Analytics

### Fact Table: SalesFact
Stores the measurable events — each row is a transaction.

| Column Name    | Description                       | Type     |
| :------------- | :-------------------------------- | :------- |
| SalesID        | Unique identifier for the sale    | INT (PK) |
| DateKey        | Foreign key to Date dimension     | INT (FK) |
| ProductKey     | Foreign key to Product dimension  | INT (FK) |
| StoreKey       | Foreign key to Store dimension    | INT (FK) |
| CustomerKey    | Foreign key to Customer dimension | INT (FK) |
| UnitsSold      | Quantity sold                     | INT      |
| SalesAmount    | Total revenue                     | DECIMAL  |
| DiscountAmount | Discount applied                  | DECIMAL  |

### Dimension Tables

#### ProductDim
Describes each product.

| Column Name | Description       |
| :---------- | :---------------- |
| ProductKey  | Unique product ID |
| ProductName | Name of product   |
| Category    | Product category  |
| Brand       | Brand name        |
| UnitPrice   | Standard price    |


#### StoreDim
Describes each store location.

| Column Name | Description       |
| :---------- | :---------------- |
| StoreKey    | Unique store ID   |
| StoreName   | Name of store     |
| Region      | Geographic region |
| ManagerName | Store manager     |

#### CustomerDim
Describes each customer.

| Column Name | Description        |
| :---------- | :----------------- |
| CustomerKey | Unique customer ID |
| FullName    | Customer name      |
| Gender      | Gender             |
| AgeGroup    | Age bracket        |
| LoyaltyTier | Loyalty program    |

#### DateDim
Describes the time of sale.

| Column Name | Description     |
| :---------- | :-------------- |
| DateKey     | YYYYMMDD format |
| Date        | Full date       |
| Month       | Month name      |
| Quarter     | Q1–Q4           |
| Year        | Calendar year   |


#### Why This Works in Fabric
- You can store these tables in Lakehouse or Warehouse using Delta or SQL formats.
- Use Direct Lake mode in Power BI to query them instantly without import delays.
- Dimension tables support slicing and filtering in reports (e.g., “Sales by Region” or “Top Products by Brand”).
- Fact tables support aggregations (e.g., total revenue, average discount).

#### Optional Enhancements
- Add a TimeDim table if you want to analyze by hour/minute.
- Include a PromotionDim if discounts are tied to campaigns.
- Use surrogate keys for better performance and flexibility.

