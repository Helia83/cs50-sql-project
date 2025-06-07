
# Design Document
## customer-bank database system

By Heliasadat Mohammadi

your project’s title : customer-bank database system
your name : Heliasadat Mohammadi
your GitHub username : Helia83
and edX usernames : Helia_2004
your city and country : Tehran, Iran
and, the date you have recorded this video : 2/22/2025

and this is the link of video : https://drive.google.com/file/d/1UrtAzLyIun1Z_QQULNlcAr1zxAhsa_3N/view?usp=sharing

now, lets write about the  database’s purpose, scope, entities, relationships, optimizations, and limitations:


### **Introduction**

The customer-bank database system is designed to manage and track customer details, branch information, deposits, and loans (borrows) within a banking system. The database is structured to accommodate multiple customers, each having the ability to deposit money into different bank branches and borrow money from these branches. The design ensures data integrity, efficient querying, and scalability for basic banking operations.


## Scope

The database is designed to manage customer information, bank branches, deposits, and loans. It includes entities necessary to track customer details, their deposits, and loans taken from specific bank branches. The database's scope includes:

- **Customers**, including their name, city, and street.
- **Branches**, including the bank name and city.
- **Deposits**, which represent the accounts customers have created in specific branches.
- **Borrow**, which represent the money customers have borrowed from specific branches.

Out of scope are elements like transaction histories, interest rates, and other non-core attributes.

## Functional Requirements

This database will support:

- **CRUD operations** for customers, branches, deposits, and loans.
- **Tracking deposits and loans** for each customer.
- **Ensuring data integrity** through foreign key constraints and cascading deletes.

## Representation

Entities are captured in SQLite tables with the following schema.

### Entities

The database includes the following entities:

#### Customer

The `customer` table includes:

- `c_name`, which specifies the customer's name as `TEXT`. This column has the `PRIMARY KEY` constraint applied.
- `c_city`, which specifies the customer's city as `TEXT`. This column has the `NOT NULL` constraint applied.
- `c_street`, which specifies the customer's street as `TEXT`. This column has the `NOT NULL` constraint applied.

#### Branch

The `branch` table includes:

- `b_name`, which specifies the branch's name as `TEXT`. This column has the `PRIMARY KEY` constraint applied.
- `b_city`, which specifies the branch's city as `TEXT`. This column has the `NOT NULL` constraint applied.

#### Deposit

The `deposit` table includes:

- `c_name`, which specifies the customer's name as `TEXT`. This column has the `FOREIGN KEY` constraint applied, referencing the `c_name` column in the `customer` table.
- `b_name`, which specifies the branch's name as `TEXT`. This column has the `FOREIGN KEY` constraint applied, referencing the `b_name` column in the `branch` table.
- `A_no`, which specifies the account number as `INTEGER`. This column has the `PRIMARY KEY` and `UNIQUE` constraints applied.
- `balance`, which specifies the account balance as `INTEGER`. This column has the `NOT NULL` constraint applied, along with a `CHECK` constraint to ensure the balance is not zero.

#### Borrow

The `borrow` table includes:

- `c_name`, which specifies the customer's name as `TEXT`. This column has the `FOREIGN KEY` constraint applied, referencing the `c_name` column in the `customer` table.
- `b_name`, which specifies the branch's name as `TEXT`. This column has the `FOREIGN KEY` constraint applied, referencing the `b_name` column in the `branch` table.
- `L_no`, which specifies the loan number as `INTEGER`. This column has the `PRIMARY KEY` and `UNIQUE` constraints applied.
- `amount`, which specifies the loan amount as `INTEGER`. This column has the `NOT NULL` constraint applied, along with a `CHECK` constraint to ensure the amount is not zero.

### Relationships

The entity relationship diagram describes the relationships among the entities in the database.

- **Customer to Deposit**: One customer can have 0 to many deposits. A deposit is associated with one and only one customer.
- **Customer to Borrow**: One customer can have 0 to many loans. A loan is associated with one and only one customer.
- **Branch to Deposit**: One branch can have 0 to many deposits. A deposit is associated with one and only one branch.
- **Branch to Borrow**: One branch can have 0 to many loans. A loan is associated with one and only one branch.

+----------------+          +----------------+          +----------------+
|   Customer     |          |    Branch       |          |    Deposit      |
|----------------|          |----------------|          |----------------|
| c_name (PK)    |<-------->| b_name (PK)    |<-------->| A_no (PK)       |
| c_city         |          | b_city         |          | c_name (FK)     |
| c_street       |          |                |          | b_name (FK)     |
+----------------+          +----------------+          | balance         |
       ^                           ^                   +----------------+
       |                           |
       |                           |
       |                           |
       |                           |
       |                           |
+----------------+          +----------------+
|    Borrow      |          |    Branch       |
|----------------|          |----------------|
| L_no (PK)      |<-------->| b_name (PK)    |
| c_name (FK)    |          | b_city         |
| b_name (FK)    |          |                |
| amount         |          +----------------+
+----------------+

photo of the ER diagram: https://drive.google.com/file/d/1Mgoc7-d64P3dpISDt2U6MoXPyChuzSYp/view?usp=sharing

### Optimizations

To speed up queries, indexes are created on the following columns:

- `customer_index` on the `c_name` column in the `customer` table.
- `branch_index` on the `b_name` column in the `branch` table.
- `deposit_index` on the `c_name` column in the `deposit` table.
- `borrow_index` on the `b_name` column in the `borrow` table.

### Views

A view named `Sun_acc` is created to display customers who have accounts in the "Sun" branch:

```sql
CREATE VIEW "Sun_acc" AS
SELECT "c_name" FROM "deposit"
WHERE "b_name" = "Sun";
```

## Limitations

- The current schema assumes that each deposit and loan is associated with a single customer and branch. Collaborative accounts or loans would require a shift to a many-to-many relationship between customers and deposits/loans.
- The schema does not support tracking transaction histories or interest rates.
