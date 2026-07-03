# Reusable Pad Kit Distribution System

**Course:** C11665 - DPR400210: Database Programming
**Instructor:** Eric Maniraguha
**Assignment:** Group Assignment III - Design and Implementation of a Simple Database Application Using PL/SQL
**Database:** Oracle Database 21c Express Edition

## 1. Problem Statement

Community organizations that distribute reusable sanitary pad kits to
girls in rural areas need a simple way to track:

- Which **districts** and **distribution centers** they operate through
- Which **beneficiaries** (girls) are registered at each center
- What **kits** are in stock, and their price
- Every **distribution** (transaction) of kits to a beneficiary, so stock
  levels stay accurate and low-stock kits can be flagged before they run out

This project models that problem as a relational database and implements
the logic in PL/SQL.

## 2. Database Schema

| Table | Purpose |
|---|---|
| `districts` | Regions where distribution happens |
| `centers` | Local distribution points, each belongs to a district |
| `kits` | Pad kits available, with unit price and current stock |
| `beneficiaries` | Girls registered at a center |
| `distributions` | Transaction log: which beneficiary received which kit, when, and how many |

**Relationships**
- One district → many centers
- One center → many beneficiaries
- One beneficiary → many distributions
- One kit → many distributions

## 3. PL/SQL Concepts Demonstrated

| Concept | File | Object name | What it does |
|---|---|---|---|
| Window Functions | `sql/06_window_functions.sql` | (query) | Ranks centers by total kits distributed within their district, and computes a running total using `RANK()` and `SUM() OVER()` |
| Anonymous Block | `sql/05_anonymous_blocks.sql` | (block) | Loops through all kits and prints a low-stock alert for anything below a threshold |
| Stored Procedure | `sql/04_procedures.sql` | `distribute_kit` | Records a new distribution and reduces stock; rejects the transaction if there isn't enough stock, using exception handling |
| Function | `sql/03_functions.sql` | `get_beneficiary_total` | Returns the total number of kits a given beneficiary has received |

## 4. How to Run (VS Code + Oracle extension)

Run the files **in this order** against your Oracle 21c XE database:

```
sql/01_schema.sql
sql/02_sample_data.sql
sql/03_functions.sql
sql/04_procedures.sql
sql/05_anonymous_blocks.sql
sql/06_window_functions.sql
```

Make sure `SET SERVEROUTPUT ON` is enabled in your session so you can see
the `DBMS_OUTPUT.PUT_LINE` messages from the procedure, function, and
anonymous block.

## 5. Example Output

**Stored procedure (`distribute_kit`):**
```
Success: 3 kit(s) distributed to beneficiary 2
Error: Not enough stock for kit ID 2 (available: 12, requested: 100)
```

**Anonymous block (low stock report):**
```
--- Low Stock Report (threshold = 20) ---
OK: Reusable Pad Kit - Standard - 45 in stock
ALERT: Reusable Pad Kit - Teen - 12 left in stock
OK: Hygiene Add-on Pack - 40 in stock
--- End of Report ---
```

**Window function query** returns each center's total distributed kits,
its rank within its district, and a running total in district order.

## 6. Team Members

| Name | Role |
|---|---|
| (add member 1) | |
| (add member 2) | |
| (add member 3) | |
| (add member 4) | |
| (add member 5) | |

## 7. Repository Structure

```
mamalink_pad_distribution/
├── README.md
└── sql/
    ├── 01_schema.sql
    ├── 02_sample_data.sql
    ├── 03_functions.sql
    ├── 04_procedures.sql
    ├── 05_anonymous_blocks.sql
    └── 06_window_functions.sql
```
