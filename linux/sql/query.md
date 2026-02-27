# 📘 SQL Query

An **SQL Query** is used to retrieve or manipulate data from a database.

---

## 🧩 Basic Query Structure

```sql
SELECT column1, column2
FROM table_name
WHERE condition
GROUP BY column
HAVING condition
ORDER BY column;
```

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/query.png">
</div>

---
<br>

## 1. SELECT

* Specifies the columns to retrieve.
* `*` selects all columns.

```sql
SELECT name, age FROM users;
SELECT * FROM users;
```

<br>

## 2. DISTINCT

* Removes duplicate values.

```sql
SELECT DISTINCT country FROM users;
```

<br>

## 3. TOP / LIMIT

* Returns a limited number of rows.
* `TOP` → SQL Server
* `LIMIT` → MySQL/PostgreSQL

```sql
SELECT TOP 5 * FROM users;      -- SQL Server
SELECT * FROM users LIMIT 5;    -- MySQL/PostgreSQL
```

<br>

## 4. FROM

* Specifies the table to query.

```sql
SELECT * FROM orders;
```

<br>

## 5. JOIN

* Combines rows from multiple tables.

### Types of JOIN:

1. **INNER JOIN** - Returns only rows that have matching values in both tables

```sql
SELECT users.name, orders.amount
FROM users
INNER JOIN orders
ON users.id = orders.user_id;
```

Here, we joined two tables (users,orders) and the common column was id.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/innerjoin.png">
</div>

**JOIN Multiple Tables**

```sql
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID;
```

---

2. **LEFT JOIN** - Returns all rows from the left table, and only the matched rows from the right table

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/outerjoin.png">
</div>

---

3. **RIGHT JOIN** -  Returns all rows from the right table, and only the matched rows from the left table.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/rightjoin.png">
</div>

---

4. **FULL JOIN** - Returns all rows when there is a match in either the left or right table

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/fulljoin.png">
</div>


<br>


## 6. WHERE

* Filters rows before grouping.

```sql
SELECT * FROM users
WHERE age > 25;
```

<br>

## 7. GROUP BY

* Groups rows with the same values.
* Used with aggregate functions.

```sql
SELECT country, COUNT(*)
FROM users
GROUP BY country;
```

<br>

## 8. HAVING

* Filters grouped results.
* Used after `GROUP BY`.

```sql
SELECT country, COUNT(*)
FROM users
GROUP BY country
HAVING COUNT(*) > 5;
```

<br>

## 9. ORDER BY

* Sorts the result.
* `ASC` (default) / `DESC`

```sql
SELECT * FROM users
ORDER BY age DESC;
```

**Combine ASC and DESC**

```sql
SELECT Country, CustomerName  FROM Customers
ORDER BY Country ASC, CustomerName DESC;
```

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/both.png">
</div>


---
<br>


## 🧠 Query Execution Order  

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/executionOrder.png">
</div>

1. FROM
2. JOIN
3. WHERE
4. GROUP BY
5. HAVING
6. SELECT
7. DISTINCT
8. ORDER BY
9. LIMIT / TOP

---
