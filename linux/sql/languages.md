# DDL: Data Definition Language

DDL commands are used to **define and manage the database structure** (tables, schemas, indexes, etc.), not the data itself.

Common DDL commands:

* CREATE
* ALTER
* DROP
* TRUNCATE

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/ddl.png">
</div>

---

## 1. CREATE

### What it does:

Used to **create new database objects** like tables, databases, schemas, views, etc.

### Syntax:

```sql
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype
);
```

### Example:

```sql
CREATE TABLE Employees (
    id INT,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);
```

## 2. ALTER

### What it does:

Used to **modify an existing table structure**.

You can:

* Add columns
* Modify columns
* Delete columns
* Rename columns

### Common Operations:

#### Add a column:

```sql
ALTER TABLE Employees
ADD email VARCHAR(100);
```

#### Modify a column:

```sql
ALTER TABLE Employees
MODIFY salary INT;
```

#### Drop a column:

```sql
ALTER TABLE Employees
DROP COLUMN email;
```

## 3. DROP

### What it does:

Used to **delete the entire database object permanently**.

### Syntax:

```sql
DROP TABLE table_name;
```

### Example:

```sql
DROP TABLE Employees;
```

## 4. TRUNCATE

### What it does:

Used to **delete all records from a table quickly** but keeps the table structure.

### Syntax:

```sql
TRUNCATE TABLE table_name;
```

### Example:

```sql
TRUNCATE TABLE Employees;
```


---
<br>








# DML: Data Manipulation Language

DML commands are used to **manage and manipulate the data inside tables**, not the table structure.

Common DML Commands:

* INSERT
* UPDATE
* DELETE

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/dml.png">
</div>

---

## 1. INSERT

### What it does:

Used to **add new records (rows)** into a table.

### Syntax:

```sql
INSERT INTO table_name (column1, column2)
VALUES (value1, value2);
```

### Example:

```sql
INSERT INTO Employees (id, name, salary)
VALUES (1, 'Shrushti', 30000);
```

### Insert Multiple Rows:

```sql
INSERT INTO Employees (id, name, salary)
VALUES 
(2, 'Amit', 35000),
(3, 'Neha', 40000);
```


## 2. UPDATE

### What it does:

Used to **modify existing data** in a table.

### Syntax:

```sql
UPDATE table_name
SET column1 = value1
WHERE condition;
```

### Example:

```sql
UPDATE Employees
SET salary = 45000
WHERE id = 1;
```

### Without WHERE (Danger ⚠️):

```sql
UPDATE Employees
SET salary = 50000;
```

➡️ This will update ALL rows in the table.


## 3. DELETE

### What it does:

Used to **remove specific records (rows)** from a table.

### Syntax:

```sql
DELETE FROM table_name
WHERE condition;
```

### Example:

```sql
DELETE FROM Employees
WHERE id = 2;
```

### Delete All Rows:

```sql
DELETE FROM Employees;
```



---
<br>









# DQL: Data Query Language

DQL is used to **retrieve and query data from the database**.

It does not modify data or structure — it only **reads data**.

Main DQL Command:

* SELECT

---

## SELECT

### What it does:

Used to **fetch data from one or more tables**.


### 1. Basic SELECT (All Columns)

#### Syntax:

```sql
SELECT * FROM table_name;
```

#### Example:

```sql
SELECT * FROM Employees;
```


### 2. SELECT Specific Columns

#### Syntax:

```sql
SELECT column1, column2
FROM table_name;
```

#### Example:

```sql
SELECT name, salary
FROM Employees;
```


### 3. SELECT with WHERE (Filtering Data)

#### What it does:

Used to **retrieve specific rows based on conditions**.

#### Syntax:

```sql
SELECT column_name
FROM table_name
WHERE condition;
```

#### Example:

```sql
SELECT * 
FROM Employees
WHERE salary > 30000;
```


### 4. SELECT with ORDER BY (Sorting)

#### What it does:

Used to **sort the result** in ascending or descending order.

#### Syntax:

```sql
SELECT column_name
FROM table_name
ORDER BY column_name ASC|DESC;
```

#### Example:

```sql
SELECT * 
FROM Employees
ORDER BY salary DESC;
```

### 5. SELECT with LIMIT (Top Records)

#### What it does:

Used to **limit the number of rows returned**.

#### Syntax:

```sql
SELECT column_name
FROM table_name
LIMIT number;
```

#### Example:

```sql
SELECT * 
FROM Employees
LIMIT 5;
```


### 6. SELECT with DISTINCT (Unique Values)

#### What it does:

Used to **remove duplicate values** from results.

#### Syntax:

```sql
SELECT DISTINCT column_name
FROM table_name;
```

#### Example:

```sql
SELECT DISTINCT department
FROM Employees;
```

---

