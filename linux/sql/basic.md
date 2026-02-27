# SQL - Structured Query Language

**Structured Query Language (SQL)** is a standard language used to store, manage, and retrieve data from relational databases. 
- **Earlier**, in the 1970s, SQL was developed to handle structured data efficiently in systems like IBM’s research projects, and it became widely adopted as businesses began digitizing records. 
- In the **present** scenario, SQL remains a core skill in data management, cloud computing, analytics, and DevOps workflows, powering modern applications and large-scale data systems. 
- **Popular SQL-based database management systems** include MySQL, PostgreSQL, Microsoft SQL Server, and Oracle Database, which are widely used in web apps, enterprise software, and cloud platforms today.
- SQL keywords are **NOT case sensitive**: select is the same as SELECT

---

## DBMS (Database Management System)
A Database Management System (DBMS) is software that helps users **create, manage, and organize databases** efficiently. 
- In the early days of computing, data was stored in file systems with limited structure and high redundancy, which made management difficult.
- DBMS was introduced to solve these issues by providing structured storage, security, data consistency, and controlled access. 
- Today, DBMS plays a critical role in modern applications, banking systems, e-commerce platforms, and cloud services by ensuring reliable and scalable data handling. 
- Popular DBMS software includes MySQL, Oracle Database, Microsoft SQL Server, and MongoDB.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/database.png">
</div>

### Types of Databases

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/dbtype.png">
</div>

#### 1. Relational Database (SQL)

A Relational Database stores data in structured tables (rows and columns) and uses SQL to manage and query data. It follows a fixed schema and ensures data consistency using relationships between tables. Examples: MySQL, PostgreSQL.

#### NoSQL Databases

NoSQL databases are designed for flexible, scalable, and unstructured or semi-structured data.

#### 2. Key-Value Database

Stores data as simple key-value pairs, making it fast and efficient for caching and real-time applications.
Example: Redis

#### 3. Column-Based Database

Stores data in columns instead of rows, which improves performance for analytics and large datasets.
Example: Apache Cassandra

#### 4. Graph Database

Focuses on relationships between data using nodes and edges, ideal for social networks and recommendation systems.
Example: Neo4j

#### 5. Document Database

Stores data in JSON-like documents, allowing flexible schema and easy scalability.
Example: MongoDB

---

### Basic Database Concepts

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/schema_a.png"> <img src="/linux/assets/images/schema_b.png"> <img src="/linux/assets/images/schema_c.png">
</div>

#### Schema

A schema is the blueprint or structure of a database that defines how data is organized, including tables, columns, and relationships.

#### Table

A table is a collection of related data stored in rows and columns, similar to a spreadsheet.

#### Row

A row (record) represents a single entry of data in a table.

#### Column

A column (field) represents a specific attribute of the data, such as name, age, or ID.

#### Primary Key

A primary key is a unique identifier for each row in a table that ensures no duplicate records (e.g., Student_ID).

#### Value

A value is the actual data stored inside a cell (intersection of a row and column), like “Shrushti” or 22.

#### Types of Values (Data Types)

Common data types define the kind of values stored in a database, such as:

* INT – whole numbers
* VARCHAR – text/string data
* FLOAT/DECIMAL – decimal numbers
* DATE – date values
* BOOLEAN – true or false values

---

### DDL: Data Definition Language

DDL is used to define and modify the structure of a database, such as creating, altering, or deleting tables and schemas.
Common commands: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`

### DML: Data Manipulation Language

DML is used to manage and manipulate the data stored inside tables.
Common commands: `INSERT`, `UPDATE`, `DELETE`

### DQL: Data Query Language

DQL is used to retrieve and query data from the database.
Main command: `SELECT`

[Detailed notes on DDL, DML, DQL](/linux/sql/languages.md)

---

