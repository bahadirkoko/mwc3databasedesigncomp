# Database Design & SQL Terminology

A reference guide covering core database design concepts, SQL terminology, and advanced database topics relevant to this project and database design in general.

---

## Table of Contents

1. [Core Database Concepts](#1-core-database-concepts)
2. [Data Modeling & Design](#2-data-modeling--design)
3. [Normalization](#3-normalization)
4. [Keys & Constraints](#4-keys--constraints)
5. [Relationships](#5-relationships)
6. [SQL Fundamentals](#6-sql-fundamentals)
7. [Indexes](#7-indexes)
8. [Triggers](#8-triggers)
9. [Stored Procedures & Functions](#9-stored-procedures--functions)
10. [Transactions & ACID](#10-transactions--acid)
11. [Partitioning](#11-partitioning)
12. [Views](#12-views)
13. [Performance & Optimization](#13-performance--optimization)

---

## 1. Core Database Concepts

**Database**
An organized collection of structured data stored electronically. A database is managed by a Database Management System (DBMS).

**DBMS (Database Management System)**
Software that manages the creation, storage, retrieval, and administration of databases. Examples: Microsoft SQL Server, PostgreSQL, MySQL, Oracle.

**RDBMS (Relational Database Management System)**
A type of DBMS that stores data in tables with rows and columns and enforces relationships between tables using keys. SQL is the standard language used to interact with an RDBMS.

**Schema**
The structure or blueprint of a database. Defines the tables, columns, data types, constraints, and relationships without containing any actual data.

**Table**
The fundamental unit of storage in a relational database. Organized into rows (records) and columns (attributes). Equivalent to an entity in a data model.

**Row (Record / Tuple)**
A single entry in a table representing one instance of an entity. For example, one row in the `employee` table represents one employee.

**Column (Field / Attribute)**
A single property or characteristic of an entity. For example, `first_name` is a column in the `employee` table.

**Data Type**
Defines what kind of data a column can store. Common types include `INT`, `VARCHAR`, `DECIMAL`, `DATE`, `BOOLEAN`, and `TEXT`.

**NULL**
Represents the absence of a value. A `NULL` value means the data is unknown or not applicable. It is not the same as zero or an empty string.

---

## 2. Data Modeling & Design

**Data Model**
An abstract representation of the data structures, relationships, and rules of a system. There are three levels: conceptual, logical, and physical.

**Conceptual Model**
High-level overview of entities and their relationships without attributes or data types. Focuses on what data exists, not how it is stored.

**Logical Model**
More detailed than conceptual. Includes entities, attributes, primary keys, foreign keys, and relationships. Still independent of any specific database engine.

**Physical Model**
The actual implementation in a specific database system. Includes data types, indexes, constraints, and engine-specific syntax.

**ERD (Entity-Relationship Diagram)**
A visual diagram that represents the entities in a database and the relationships between them. Uses shapes and notation to show tables, attributes, primary keys, foreign keys, and cardinality.

**Entity**
A real-world object or concept that has data worth storing. In a relational database, an entity becomes a table. For example, `store`, `employee`, and `menu` are all entities.

**Attribute**
A property or characteristic of an entity. Becomes a column in a table. For example, `store_name` and `opening_date` are attributes of the `store` entity.

**Associative Entity (Bridge Table)**
A table that resolves a many-to-many relationship between two other tables. It holds the foreign keys of both tables and often carries its own attributes. For example, `menuitem` bridges `menu` and `recipe` and carries `price` and `description`.

**Crow's Foot Notation**
A standard ERD notation that uses symbols at the ends of relationship lines to represent cardinality. A single line means one, a crow's foot (three lines) means many, and combinations represent one-to-one, one-to-many, and many-to-many relationships.

**Cardinality**
Defines the numerical relationship between two entities. The main types are one-to-one (1:1), one-to-many (1:N), and many-to-many (M:N).

**Surrogate Key**
An artificially generated primary key with no business meaning, typically an auto-incrementing integer. Used to uniquely identify a row independent of its data. For example, `store_id` is a surrogate key.

**Natural Key**
A primary key made up of real-world data that already uniquely identifies a record, such as a Social Security Number or an email address. Natural keys can change over time which is a risk.

**Composite Key**
A primary key made up of two or more columns combined. Often used in bridge tables but surrogate keys are generally preferred for simplicity.

---

## 3. Normalization

**Normalization**
The process of organizing a database to reduce data redundancy and improve data integrity. Achieved by applying a series of rules called normal forms.

**Anomaly**
A problem that arises from poor database design. There are three types:
- **Insert anomaly** — cannot insert data without inserting unrelated data
- **Update anomaly** — updating one record requires updating multiple rows
- **Delete anomaly** — deleting a record causes unintended loss of other data

**1NF (First Normal Form)**
A table is in 1NF if every column contains atomic (indivisible) values and there are no repeating groups. For example, storing `phone_1`, `phone_2`, `phone_3` as separate columns violates 1NF. Moving phone numbers to a separate `phone` table resolves this.

**2NF (Second Normal Form)**
A table is in 2NF if it is in 1NF and every non-key column is fully dependent on the entire primary key, not just part of it. Relevant when a table has a composite primary key.

**3NF (Third Normal Form)**
A table is in 3NF if it is in 2NF and no non-key column depends on another non-key column (no transitive dependencies). Every attribute must depend on the key, the whole key, and nothing but the key. This is the target normal form for most production database designs.

**Denormalization**
The intentional introduction of redundancy into a database to improve read performance. A tradeoff made in data warehousing or reporting databases where query speed is prioritized over strict normalization.

**Transitive Dependency**
When a non-key column depends on another non-key column rather than directly on the primary key. This violates 3NF and must be resolved by moving the dependent column to its own table.

**Functional Dependency**
A relationship where the value of one column determines the value of another. Written as A → B, meaning knowing A tells you B. The basis of normalization theory.

---

## 4. Keys & Constraints

**Primary Key (PK)**
A column or set of columns that uniquely identifies each row in a table. Cannot be NULL and must be unique. Every table should have one.

**Foreign Key (FK)**
A column in one table that references the primary key of another table. Enforces referential integrity by ensuring a value in the FK column must exist in the referenced table.

**Unique Constraint**
Ensures all values in a column are distinct across all rows. Unlike a primary key, a unique constraint can allow one NULL value.

**NOT NULL Constraint**
Ensures a column cannot store a NULL value. Used when a value is always required.

**DEFAULT Constraint**
Specifies a default value for a column when no value is provided during an INSERT. For example, `is_active` defaults to `1` (true).

**CHECK Constraint**
Validates that values in a column satisfy a specific condition. For example, ensuring `price > 0`.

**Referential Integrity**
The guarantee that a foreign key value always refers to an existing primary key value in the referenced table. Prevents orphaned records.

**Cascade**
A referential action that automatically propagates changes from a parent table to child tables. `ON DELETE CASCADE` deletes child rows when the parent row is deleted. `ON UPDATE CASCADE` updates child FK values when the parent PK changes.

---

## 5. Relationships

**One-to-One (1:1)**
Each row in Table A relates to exactly one row in Table B and vice versa. Rare in practice. Often used to split a large table for performance or security reasons.

**One-to-Many (1:N)**
Each row in Table A can relate to many rows in Table B, but each row in Table B relates to only one row in Table A. The most common relationship type. For example, one `store` has many `email` records.

**Many-to-Many (M:N)**
Each row in Table A can relate to many rows in Table B and vice versa. Cannot be implemented directly in a relational database — requires a bridge table. For example, `employee` and `store` have a many-to-many relationship resolved by `employee_store`.

**Self-Referencing Relationship**
A table that has a foreign key pointing to its own primary key. Common for hierarchical data such as an employee who manages other employees.

**Mandatory vs Optional Relationship**
Refers to the minimum cardinality. A mandatory relationship means a record must have a related record (FK cannot be NULL). An optional relationship means the related record may or may not exist (FK can be NULL).

---

## 6. SQL Fundamentals

**DDL (Data Definition Language)**
SQL statements that define or modify the structure of a database. Includes `CREATE`, `ALTER`, `DROP`, and `TRUNCATE`.

**DML (Data Manipulation Language)**
SQL statements that manage data within tables. Includes `INSERT`, `UPDATE`, `DELETE`, and `SELECT`.

**DCL (Data Control Language)**
SQL statements that control access and permissions. Includes `GRANT` and `REVOKE`.

**TCL (Transaction Control Language)**
SQL statements that manage transactions. Includes `COMMIT`, `ROLLBACK`, and `SAVEPOINT`.

**SELECT**
Retrieves data from one or more tables. The most commonly used SQL statement.

**JOIN**
Combines rows from two or more tables based on a related column. Types include `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN`.

**INNER JOIN**
Returns only the rows where there is a match in both tables.

**LEFT JOIN**
Returns all rows from the left table and matching rows from the right table. Rows with no match return NULL for right table columns.

**GROUP BY**
Groups rows that share a value in a specified column so aggregate functions like `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX` can be applied per group.

**HAVING**
Filters groups after a `GROUP BY` is applied. Like a `WHERE` clause but for aggregated results.

**Subquery**
A query nested inside another query. Can be used in `SELECT`, `FROM`, or `WHERE` clauses.

**CTE (Common Table Expression)**
A temporary named result set defined using `WITH` that can be referenced within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. Makes complex queries more readable.

---

## 7. Indexes

**Index**
A database object that improves the speed of data retrieval on a table at the cost of additional storage and slightly slower writes. Works similarly to an index in a book — allows the database to find rows without scanning the entire table.

**Clustered Index**
Determines the physical order of data in a table. A table can have only one clustered index. In SQL Server the primary key is clustered by default.

**Non-Clustered Index**
A separate structure that stores a sorted copy of selected columns with pointers back to the actual rows. A table can have multiple non-clustered indexes. Used to speed up lookups on non-primary-key columns.

**Composite Index**
An index on two or more columns. Useful when queries frequently filter or sort by a combination of columns.

**Covering Index**
An index that includes all columns needed by a query so the database can answer the query entirely from the index without touching the actual table.

**Full Table Scan**
When the database reads every row in a table to find matching records. Happens when no suitable index exists. Slow on large tables.

**Selectivity**
How unique the values in an indexed column are. High selectivity (many distinct values) makes an index more effective. Low selectivity (few distinct values like a boolean) makes an index less useful.

**Index Fragmentation**
Over time as rows are inserted, updated, and deleted, index pages become fragmented and out of order, degrading performance. Indexes need to be rebuilt or reorganized periodically.

---

## 8. Triggers

**Trigger**
A stored procedure that automatically executes in response to a specific event on a table, such as an `INSERT`, `UPDATE`, or `DELETE`. Triggers run automatically and cannot be called manually.

**BEFORE Trigger**
Fires before the triggering event executes. Can be used to validate or modify data before it is committed.

**AFTER Trigger**
Fires after the triggering event executes. Commonly used for auditing, logging, or cascading changes to other tables.

**INSTEAD OF Trigger**
Replaces the triggering event with custom logic. Commonly used on views to make them updatable.

**Use Case in This Project**
A trigger could be used to automatically decrement `inventory.quantity` whenever a recipe is used, by referencing `recipeingredients.quantity` for each ingredient in the recipe. This was not implemented in this deliverable but the schema fully supports it.

---

## 9. Stored Procedures & Functions

**Stored Procedure**
A precompiled block of SQL code stored in the database that can be executed by name. Can accept parameters, perform logic, and return results. Useful for encapsulating business logic at the database level.

**Function (User-Defined Function)**
Similar to a stored procedure but must return a value and can be used inside a SQL query. Cannot perform side effects like modifying data (in most databases).

**Scalar Function**
Returns a single value. For example, a function that calculates the total cost of a recipe given a recipe ID.

**Table-Valued Function**
Returns a table result set that can be used like a regular table in a query.

---

## 10. Transactions & ACID

**Transaction**
A sequence of one or more SQL operations treated as a single unit of work. Either all operations succeed (commit) or all are rolled back (rollback).

**ACID**
The four properties that guarantee reliable transaction processing:

**Atomicity**
A transaction is all or nothing. If any part fails, the entire transaction is rolled back as if it never happened.

**Consistency**
A transaction brings the database from one valid state to another. All constraints and rules must be satisfied before and after the transaction.

**Isolation**
Concurrent transactions execute as if they were running sequentially. Changes made in one transaction are not visible to others until committed.

**Durability**
Once a transaction is committed, the changes are permanent even in the event of a system failure.

**COMMIT**
Permanently saves all changes made in the current transaction.

**ROLLBACK**
Undoes all changes made in the current transaction and returns the database to its previous state.

**Deadlock**
A situation where two transactions are each waiting for the other to release a lock, causing both to be stuck indefinitely. The database detects this and kills one of the transactions.

---

## 11. Partitioning

**Partitioning**
Dividing a large table into smaller, more manageable pieces called partitions while still appearing as one table to the user. Improves query performance and manageability on very large datasets.

**Horizontal Partitioning (Sharding)**
Splits a table by rows. Each partition holds a subset of rows based on a partition key. For example, partitioning an `inventory` table by `store_id` so each store's data is stored separately.

**Vertical Partitioning**
Splits a table by columns. Frequently accessed columns are kept in one partition and rarely accessed columns in another. Improves performance for queries that only need certain columns.

**Range Partitioning**
Partitions data based on a range of values in the partition key. For example, partitioning a sales table by year so all 2024 records are in one partition and all 2025 records in another.

**List Partitioning**
Partitions data based on a specific list of values. For example, partitioning stores by state.

**Hash Partitioning**
Distributes rows evenly across partitions using a hash function on the partition key. Useful when there is no natural range or list to partition by.

---

## 12. Views

**View**
A virtual table based on the result of a stored SQL query. Does not store data itself — it queries the underlying tables every time it is accessed. Used to simplify complex queries, restrict access to sensitive columns, or present data in a specific format.

**Updatable View**
A view that allows `INSERT`, `UPDATE`, and `DELETE` operations to pass through to the underlying tables, subject to certain conditions.

**Materialized View**
A view that actually stores the query result physically on disk and refreshes it periodically. Improves performance for expensive queries at the cost of storage and potential staleness. Not natively supported in SQL Server but achievable with indexed views.

**Indexed View (SQL Server)**
SQL Server's equivalent of a materialized view. The result set is stored physically and kept in sync with the underlying tables automatically.

---

## 13. Performance & Optimization

**Query Plan (Execution Plan)**
A step-by-step breakdown of how the database engine will execute a SQL query. Used to identify performance bottlenecks such as full table scans or missing indexes.

**Query Optimizer**
The internal component of a DBMS that analyzes a SQL query and determines the most efficient way to execute it based on available indexes, table statistics, and cost estimates.

**Statistics**
Metadata maintained by the database about the distribution of values in columns. Used by the query optimizer to estimate how many rows will match a condition and choose the best execution plan.

**Cardinality Estimation**
The process the query optimizer uses to estimate how many rows a query will return at each step. Poor estimates lead to suboptimal execution plans.

**N+1 Query Problem**
A performance antipattern where one query is made to fetch a list of records and then N additional queries are made to fetch related data for each record. Solved by using proper JOINs.

**Connection Pooling**
Reusing existing database connections rather than opening a new connection for every request. Significantly reduces overhead in applications that make frequent database calls.

**Soft Delete**
Instead of permanently deleting a record with `DELETE`, a column like `is_active` or `deleted_at` is used to mark the record as inactive. Preserves historical data and prevents accidental data loss.

**Hard Delete**
Permanently removing a row from a table using the `DELETE` statement. The data cannot be recovered unless a backup exists.

**Data Integrity**
The accuracy, consistency, and reliability of data stored in a database. Enforced through constraints, foreign keys, transactions, and validation logic.

**Referential Integrity**
A specific type of data integrity that ensures foreign key values always point to existing primary key values. Prevents orphaned records.