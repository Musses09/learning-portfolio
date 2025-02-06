# MySQL & SQLite Basic Commands Cheat Sheet

| **Command** | **Description** | **Compatible With** |
|-------------|-----------------|---------------------|
| `CREATE DATABASE database_name;` | Create a new database. | **MySQL** |
| `SHOW DATABASES;` | Show all databases. | **MySQL** |
| `USE database_name;` | Select a database to use. | **MySQL** |
| `DROP DATABASE database_name;` | Drop (delete) a database. | **MySQL** |
| `CREATE TABLE table_name (column1 datatype, column2 datatype, ...);` | Create a new table with specified columns and data types. | **MySQL**, **SQLite** |
| `SHOW TABLES;` | Show all tables in the current database. | **MySQL** |
| `.tables` | List all tables in the SQLite database. | **SQLite** |
| `DESCRIBE table_name;` | Show the schema of a table (column names and types). | **MySQL** |
| `.schema table_name` | Show the schema of a table (column names and types) in SQLite. | **SQLite** |
| `DROP TABLE table_name;` | Drop (delete) a table. | **MySQL**, **SQLite** |
| `INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);` | Insert data into a table. | **MySQL**, **SQLite** |
| `SELECT * FROM table_name;` | Select all columns from a table. | **MySQL**, **SQLite** |
| `SELECT column1, column2 FROM table_name;` | Select specific columns from a table. | **MySQL**, **SQLite** |
| `SELECT * FROM table_name WHERE condition;` | Select rows that meet the condition. | **MySQL**, **SQLite** |
| `SELECT * FROM table_name WHERE condition1 AND/OR condition2;` | Filter results with multiple conditions. | **MySQL**, **SQLite** |
| `SELECT * FROM table_name LIMIT number;` | Limit the number of rows returned. | **MySQL**, **SQLite** |
| `SELECT * FROM table_name ORDER BY column_name ASC/DESC;` | Sort results by a specified column (ascending or descending). | **MySQL**, **SQLite** |
| `UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;` | Update data in a table. | **MySQL**, **SQLite** |
| `DELETE FROM table_name WHERE condition;` | Delete rows from a table. | **MySQL**, **SQLite** |
| `SELECT column1, column2 FROM table1 INNER JOIN table2 ON table1.column = table2.column;` | Inner join two tables on a matching column (returns only matching rows). | **MySQL**, **SQLite** |
| `SELECT column1, column2 FROM table1 LEFT JOIN table2 ON table1.column = table2.column;` | Left join two tables (returns all rows from the left table and matched rows from the right). | **MySQL**, **SQLite** |
| `SELECT column, COUNT(*) FROM table_name GROUP BY column;` | Group results by a column and perform aggregation (e.g., COUNT). | **MySQL**, **SQLite** |
| `SELECT COUNT(*), AVG(column), SUM(column), MIN(column), MAX(column) FROM table_name;` | Perform aggregation on columns (count, average, sum, min, max). | **MySQL**, **SQLite** |
| `CREATE INDEX index_name ON table_name (column_name);` | Create an index on a table to improve search performance. | **MySQL**, **SQLite** |
| `ALTER TABLE table_name ADD PRIMARY KEY (column_name);` | Add a primary key constraint to a column. | **MySQL**, **SQLite** |
| `ALTER TABLE table_name ADD CONSTRAINT fk_name FOREIGN KEY (column_name) REFERENCES other_table (other_column);` | Add a foreign key constraint to link two tables. | **MySQL**, **SQLite** |
| `.mode csv` | Set output format to CSV (for SQLite). | **SQLite** |
| `.output table_name.csv` | Direct output to a CSV file (for SQLite). | **SQLite** |
| `SELECT * FROM table_name;` | Export table data to the specified CSV file (for SQLite). | **SQLite** |
| `mysqldump -u username -p database_name > backup_file.sql` | Export a MySQL database to a SQL dump file. | **MySQL** |
| `SELECT USER();` | Show the current user. | **MySQL** |
| `SELECT DATABASE();` | Show the current database in use. | **MySQL** |

---

### Notes:
- **MySQL** and **SQLite** share many basic commands, but there are key differences in their support for features like database management (`CREATE DATABASE`, `DROP DATABASE`), as well as the way certain commands are used (e.g., `.tables` for SQLite vs `SHOW TABLES` for MySQL).
- **SQLite** is more lightweight and is designed to work with a single file, so it doesn't require or support multi-database management.
- When working with **SQLite**, certain commands, like `.mode csv` and `.output`, are specific to the SQLite CLI and are not supported by MySQL.

---

Feel free to copy this into your `.md` file for GitHub! It clearly distinguishes between commands supported by **MySQL** and **SQLite**. Let me know if you'd like any additional modifications!
