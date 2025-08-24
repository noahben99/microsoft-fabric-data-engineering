<div><div style='font-weight:800;font-size:1.5rem;padding-top:2rem'>Create new database in Fabric in a workspace</div><div>
<image src='../images/create-new-sql-database.png' width="700" alt="create-new-sql-database">
</div></div>

<div><div style='font-weight:800;font-size:1.5rem;padding-top:2rem'>Creating...</div><div>
<image src='../images/create-new-sql-database-2.png' width="700" alt="create-new-sql-database-2">
<div><div>
<div><div style='font-weight:800;font-size:1.5rem;padding-top:2rem'>Created</div><div>
<image src='../images/create-new-sql-database-3.png' width="700" alt="create-new-sql-database-3">
<div><div>
<div><div style='font-weight:800;font-size:1.5rem;padding-top:2rem'>Open in SSMS</div><div>
<image src='../images/open-sql-database-in-ssms.png' width="700" alt="open-sql-database-in-ssms">
<div><div>
<div><div style='font-weight:800;font-size:1.5rem;padding-top:2rem'>Message in SSMS when connecting to server</div><div>
<image src='../images/open-sql-database-in-ssms-2.png' width="700" alt="open-sql-database-in-ssms-2">
<div><div>

---
❓Me
> When connecting to this SQL server in,the name of the server<br>  is a very long string  (e.g."******************.datawarehouse.fabric.microsoft.com")<br>How do I create an alias for this server to help me understand the actual source?

## How to Create a SQL Server Alias (Windows)

You’ll use **SQL Server Configuration Manager** to set this up:

### 1. Open SQL Server Configuration Manager
- Press `Win + R`, type `SQLServerManager<version>.msc`  
  _(e.g., `SQLServerManager15.msc` for SQL Server 2019)_, and hit Enter.

### 2. Navigate to:
- `SQL Native Client Configuration` → `Aliases`

### 3. Create a New Alias
- Right-click → **New Alias**
- Fill in the following fields:

| Field        | Value                                                                 |
|--------------|-----------------------------------------------------------------------|
| Alias Name   | `FabricSalesDB` or `OnboardingSQL` _(choose a meaningful name)_       |
| Port No      | `1433` _(default SQL port)_                                           |
| Protocol     | `TCP/IP`                                                              |
| Server       | `**********.datawarehouse.fabric.microsoft.com` |

### 4. Save and Test
- Open **SQL Server Management Studio (SSMS)**  
- Connect using the alias name instead of the long server string.

### Notes
- Aliases are **client-side only**, so each machine that connects will need its own alias setup.
- This won’t work in **Power BI Desktop** unless you also configure the alias in the Windows `hosts` file or use DNS mapping.
