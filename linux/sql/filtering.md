# 📌 Filtering Data 

## 🔎 SQL `WHERE` Clause Operators

The `WHERE` clause is used to **filter rows** based on conditions.

---

## 1️⃣ Comparison Operators

Used to compare two values.

### ✅ Syntax

```sql
expression operator expression
```

### ✅ Common Operators

| Operator     | Meaning               |
| ------------ | --------------------- |
| `=`          | Equal                 |
| `!=` or `<>` | Not equal             |
| `>`          | Greater than          |
| `<`          | Less than             |
| `>=`         | Greater than or equal |
| `<=`         | Less than or equal    |

### ✅ Examples

```sql
-- column = value
SELECT * FROM employees
WHERE salary = 50000;

-- column1 = column2
SELECT * FROM orders
WHERE order_amount = paid_amount;

-- function = value
SELECT * FROM orders
WHERE YEAR(order_date) = 2025;

-- expression = value
SELECT * FROM products
WHERE price * quantity > 1000;

-- subquery comparison
SELECT * FROM orders
WHERE sales = (SELECT AVG(sales) FROM orders);
```

---

## 2️⃣ Logical Operators

Used to combine multiple conditions.

| Operator | Meaning                             |
| -------- | ----------------------------------- |
| `AND`    | Both conditions must be true        |
| `OR`     | At least one condition must be true |
| `NOT`    | Reverses condition                  |

### Example

```sql
SELECT * FROM employees
WHERE department = 'IT'
AND salary > 40000;
```

---

## 3️⃣ Range Operator

Used to check if a value lies within a range.

### `BETWEEN`

```sql
SELECT * FROM products
WHERE price BETWEEN 100 AND 500;
```

👉 Includes both 100 and 500 (inclusive).

---

## 4️⃣ Membership Operator

Used to match values in a list.

### `IN`

```sql
SELECT * FROM employees
WHERE department IN ('IT', 'HR', 'Finance');
```

👉 Works like multiple OR conditions.

---

## 5️⃣ Search Operator

Used for pattern matching.

### `LIKE`

| Symbol | Meaning                  |
| ------ | ------------------------ |
| `%`    | Any number of characters |
| `_`    | Single character         |

```sql
-- Names starting with 'A'
SELECT * FROM employees
WHERE name LIKE 'A%';
(M% ; %in ; %r%)

-- Names with exactly 5 characters
SELECT * FROM employees
WHERE name LIKE '_____';
('__b' so this will retrieve names which have 'b' in 3rd place)
```

---
<br>






# 📌 Combining Data

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/combining.png">
</div>

**JOINS** are used to combine data from two or more tables based on a related column (usually a key). They merge tables horizontally, meaning the result contains **columns** from each table. JOINS are useful when retrieving related data stored separately, such as linking employee details with department information using [INNER JOIN, LEFT JOIN, RIGHT JOIN, or FULL JOIN](/linux/sql/query.md) depending on the matching requirement.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/joins.png">
</div>

**SET Operators** are used to combine the results of two or more SELECT queries into a single result set. They merge results vertically, meaning **rows** from one query are stacked on top of another. Common set operators include UNION (removes duplicates), UNION ALL (keeps duplicates), INTERSECT (returns common records), and EXCEPT/MINUS (returns records present in one query but not the other). They require the same number and compatible data types of columns in each query.

---


## JOINS (Advanced)

### 1️⃣ Left Anti Join  
Returns rows from the left table that **do NOT have a match** in the right table.

**Example:** Customers who have not placed any orders.

```sql
SELECT c.customerId, c.customerName
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerId = o.customerId
WHERE o.customerId IS NULL;
```

### 2️⃣ Right Anti Join

Returns rows from the right table that **do NOT have a match** in the left table.

**Example:** Orders that do not have a matching customer record.

```sql
SELECT o.orderId, o.customerId
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customerId = o.customerId
WHERE c.customerId IS NULL;
```

### 3️⃣ Full Anti Join

Returns rows from both tables where there is **no match on either side**.

**Example:** Customers without orders + Orders without customers.

```sql
SELECT c.customerId, o.orderId
FROM customers AS c
FULL JOIN orders AS o
ON c.customerId = o.customerId
WHERE c.customerId IS NULL 
   OR o.customerId IS NULL;
```
### 4️⃣ Cross Join  

Returns the **Cartesian product** of two tables, meaning every row from the first table
is combined with every row from the second table. It does not require a matching condition.

**Example:** Combine all customers with all products.

```sql
SELECT c.customerName, p.productName
FROM customers AS c
CROSS JOIN products AS p;
```

---


## SET Operators

SET operators (`UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT / MINUS`) are used to combine the results of multiple `SELECT` queries vertically (row-wise).

---

### 📌 Rules of SET Operators

#### Rule 1️⃣: SQL Clauses
- SET operators can be used with `WHERE`, `GROUP BY`, and `HAVING` inside individual queries.
- `ORDER BY` is allowed **only once**, at the very end of the final combined query.


#### Rule 2️⃣: Number of Columns
- Each `SELECT` query must return the **same number of columns**.


#### Rule 3️⃣: Matching Data Types
- The corresponding columns must have **compatible data types**.


#### Rule 4️⃣: Same Order of Columns
- The **order of columns** in each `SELECT` must be the same.


#### Rule 5️⃣: Column Aliases (First Query Controls Column Names)
- The final result set column names are determined by the **first query**.


#### Rule 6️⃣: Correct Column Mapping
- Even if SQL shows no error, incorrect column selection can produce wrong results.
- Always ensure logical column mapping between queries.

---

## ✅ Must Follow 

1. `ORDER BY` only once (at the end)  
2. Same number of columns  
3. Matching data types  
4. Same column order  
5. First query controls aliases  
6. Map correct columns logically  
