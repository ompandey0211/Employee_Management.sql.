Microsoft Windows [Version 10.0.26200.8737]
(c) Microsoft Corporation. All rights reserved.

C:\Users\ASUS>mysql -u root -p
Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.46 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE Employee_Management;
Query OK, 1 row affected (0.05 sec)

mysql> CREATE TABLE Department
    -> (
    ->     Dept_ID INT PRIMARY KEY,
    ->     Dept_Name VARCHAR(50),
    ->     Location VARCHAR(50)
    -> );
ERROR 1046 (3D000): No database selected
mysql> show databases;
+---------------------+
| Database            |
+---------------------+
| employee_management |
| information_schema  |
| mysql               |
| performance_schema  |
| sys                 |
+---------------------+
5 rows in set (0.09 sec)

mysql> CREATE TABLE Department
    -> (
    ->     Dept_ID INT PRIMARY KEY,
    ->     Dept_Name VARCHAR(50),
    ->     Location VARCHAR(50)
    -> );
ERROR 1046 (3D000): No database selected
mysql> USE Employee_Management;
Database changed
mysql> CREATE TABLE Department
    -> (
    ->     Dept_ID INT PRIMARY KEY,
    ->     Dept_Name VARCHAR(50),
    ->     Location VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> DESC Department;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| Dept_ID   | int         | NO   | PRI | NULL    |       |
| Dept_Name | varchar(50) | YES  |     | NULL    |       |
| Location  | varchar(50) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.04 sec)

mysql> CREATE TABLE Employee
    -> (
    ->     Emp_ID INT PRIMARY KEY,
    ->     Emp_Name VARCHAR(50),
    ->     Age INT,
    ->     Gender VARCHAR(10),
    ->     City VARCHAR(50),
    ->     Salary INT,
    ->     Dept_ID INT,
    ->
    ->     FOREIGN KEY (Dept_ID)
    ->     REFERENCES Department(Dept_ID)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO Department VALUES
    -> (101,'IT','Delhi'),
    -> (102,'HR','Mumbai'),
    -> (103,'Finance','Bangalore'),
    -> (104,'Marketing','Delhi'),
    -> (105,'Sales','Pune');
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Employee VALUES
    -> (1,'Amit',28,'Male','Delhi',65000,101),
    -> (2,'Priya',26,'Female','Mumbai',55000,102),
    -> (3,'Rahul',30,'Male','Delhi',75000,101),
    -> (4,'Anjali',24,'Female','Pune',45000,105),
    -> (5,'Karan',35,'Male','Bangalore',80000,103),
    -> (6,'Neha',27,'Female','Delhi',60000,104),
    -> (7,'Arjun',29,'Male','Mumbai',52000,102),
    -> (8,'Riya',31,'Female','Pune',70000,105),
    -> (9,'Aman',23,'Male','Delhi',40000,101),
    -> (10,'Sneha',33,'Female','Mumbai',90000,103);
Query OK, 10 rows affected (0.03 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Employee;
+--------+----------+------+--------+-----------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City      | Salary | Dept_ID |
+--------+----------+------+--------+-----------+--------+---------+
|      1 | Amit     |   28 | Male   | Delhi     |  65000 |     101 |
|      2 | Priya    |   26 | Female | Mumbai    |  55000 |     102 |
|      3 | Rahul    |   30 | Male   | Delhi     |  75000 |     101 |
|      4 | Anjali   |   24 | Female | Pune      |  45000 |     105 |
|      5 | Karan    |   35 | Male   | Bangalore |  80000 |     103 |
|      6 | Neha     |   27 | Female | Delhi     |  60000 |     104 |
|      7 | Arjun    |   29 | Male   | Mumbai    |  52000 |     102 |
|      8 | Riya     |   31 | Female | Pune      |  70000 |     105 |
|      9 | Aman     |   23 | Male   | Delhi     |  40000 |     101 |
|     10 | Sneha    |   33 | Female | Mumbai    |  90000 |     103 |
+--------+----------+------+--------+-----------+--------+---------+
10 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Employee
    -> ORDER BY Salary DESC
    -> LIMIT 1;
+--------+----------+------+--------+--------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City   | Salary | Dept_ID |
+--------+----------+------+--------+--------+--------+---------+
|     10 | Sneha    |   33 | Female | Mumbai |  90000 |     103 |
+--------+----------+------+--------+--------+--------+---------+
1 row in set (0.00 sec)

mysql> SELECT AVG(Salary)
    -> FROM Employee;
+-------------+
| AVG(Salary) |
+-------------+
|  63200.0000 |
+-------------+
1 row in set (0.02 sec)

mysql> SELECT SUM(Salary)
    -> FROM Employee;
+-------------+
| SUM(Salary) |
+-------------+
|      632000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT
    -> d.Dept_Name,
    -> SUM(e.Salary) AS Total_Salary
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID
    -> GROUP BY d.Dept_Name;
+-----------+--------------+
| Dept_Name | Total_Salary |
+-----------+--------------+
| IT        |       180000 |
| HR        |       107000 |
| Finance   |       170000 |
| Marketing |        60000 |
| Sales     |       115000 |
+-----------+--------------+
5 rows in set (0.00 sec)

mysql> SELECT
    -> d.Dept_Name,
    -> COUNT(e.Emp_ID)
    -> FROM Department d
    -> LEFT JOIN Employee e
    -> ON d.Dept_ID=e.Dept_ID
    -> GROUP BY d.Dept_Name;
+-----------+-----------------+
| Dept_Name | COUNT(e.Emp_ID) |
+-----------+-----------------+
| IT        |               3 |
| HR        |               2 |
| Finance   |               2 |
| Marketing |               1 |
| Sales     |               2 |
+-----------+-----------------+
5 rows in set (0.02 sec)

mysql> SELECT
    -> d.Dept_Name,
    -> AVG(e.Salary) AS Avg_Salary
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID
    -> GROUP BY d.Dept_Name
    -> ORDER BY Avg_Salary DESC
    -> LIMIT 1;
+-----------+------------+
| Dept_Name | Avg_Salary |
+-----------+------------+
| Finance   | 85000.0000 |
+-----------+------------+
1 row in set (0.02 sec)

mysql> SELECT *
    -> FROM Employee
    -> WHERE Salary>50000;
+--------+----------+------+--------+-----------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City      | Salary | Dept_ID |
+--------+----------+------+--------+-----------+--------+---------+
|      1 | Amit     |   28 | Male   | Delhi     |  65000 |     101 |
|      2 | Priya    |   26 | Female | Mumbai    |  55000 |     102 |
|      3 | Rahul    |   30 | Male   | Delhi     |  75000 |     101 |
|      5 | Karan    |   35 | Male   | Bangalore |  80000 |     103 |
|      6 | Neha     |   27 | Female | Delhi     |  60000 |     104 |
|      7 | Arjun    |   29 | Male   | Mumbai    |  52000 |     102 |
|      8 | Riya     |   31 | Female | Pune      |  70000 |     105 |
|     10 | Sneha    |   33 | Female | Mumbai    |  90000 |     103 |
+--------+----------+------+--------+-----------+--------+---------+
8 rows in set (0.02 sec)

mysql> SELECT *
    -> FROM Employee
    -> WHERE Gender='Female';
+--------+----------+------+--------+--------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City   | Salary | Dept_ID |
+--------+----------+------+--------+--------+--------+---------+
|      2 | Priya    |   26 | Female | Mumbai |  55000 |     102 |
|      4 | Anjali   |   24 | Female | Pune   |  45000 |     105 |
|      6 | Neha     |   27 | Female | Delhi  |  60000 |     104 |
|      8 | Riya     |   31 | Female | Pune   |  70000 |     105 |
|     10 | Sneha    |   33 | Female | Mumbai |  90000 |     103 |
+--------+----------+------+--------+--------+--------+---------+
5 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Employee
    -> WHERE City='Delhi';
+--------+----------+------+--------+-------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City  | Salary | Dept_ID |
+--------+----------+------+--------+-------+--------+---------+
|      1 | Amit     |   28 | Male   | Delhi |  65000 |     101 |
|      3 | Rahul    |   30 | Male   | Delhi |  75000 |     101 |
|      6 | Neha     |   27 | Female | Delhi |  60000 |     104 |
|      9 | Aman     |   23 | Male   | Delhi |  40000 |     101 |
+--------+----------+------+--------+-------+--------+---------+
4 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Employee e
    -> WHERE Salary >
    -> (
    -> SELECT AVG(Salary)
    -> FROM Employee
    -> WHERE Dept_ID=e.Dept_ID
    -> );
+--------+----------+------+--------+--------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City   | Salary | Dept_ID |
+--------+----------+------+--------+--------+--------+---------+
|      1 | Amit     |   28 | Male   | Delhi  |  65000 |     101 |
|      2 | Priya    |   26 | Female | Mumbai |  55000 |     102 |
|      3 | Rahul    |   30 | Male   | Delhi  |  75000 |     101 |
|      8 | Riya     |   31 | Female | Pune   |  70000 |     105 |
|     10 | Sneha    |   33 | Female | Mumbai |  90000 |     103 |
+--------+----------+------+--------+--------+--------+---------+
5 rows in set (0.02 sec)

mysql> SELECT COUNT(*) AS Total_Employees
    -> FROM Employee;
+-----------------+
| Total_Employees |
+-----------------+
|              10 |
+-----------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(Salary) AS Maximum_Salary
    -> FROM Employee;
+----------------+
| Maximum_Salary |
+----------------+
|          90000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(Salary) AS Minimum_Salary
    -> FROM Employee;
+----------------+
| Minimum_Salary |
+----------------+
|          40000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(Salary) AS Average_Salary
    -> FROM Employee;
+----------------+
| Average_Salary |
+----------------+
|     63200.0000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT SUM(Salary) AS Total_Salary
    -> FROM Employee;
+--------------+
| Total_Salary |
+--------------+
|       632000 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) AS Male_Employees
    -> FROM Employee
    -> WHERE Gender='Male';
+----------------+
| Male_Employees |
+----------------+
|              5 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) AS Female_Employees
    -> FROM Employee
    -> WHERE Gender='Female';
+------------------+
| Female_Employees |
+------------------+
|                5 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT Dept_ID, AVG(Salary) AS Avg_Salary
    -> FROM Employee
    -> GROUP BY Dept_ID;
+---------+------------+
| Dept_ID | Avg_Salary |
+---------+------------+
|     101 | 60000.0000 |
|     102 | 53500.0000 |
|     103 | 85000.0000 |
|     104 | 60000.0000 |
|     105 | 57500.0000 |
+---------+------------+
5 rows in set (0.02 sec)

mysql> SELECT Dept_ID, MAX(Salary) AS Max_Salary
    -> FROM Employee
    -> GROUP BY Dept_ID;
+---------+------------+
| Dept_ID | Max_Salary |
+---------+------------+
|     101 |      75000 |
|     102 |      55000 |
|     103 |      90000 |
|     104 |      60000 |
|     105 |      70000 |
+---------+------------+
5 rows in set (0.00 sec)

mysql> SELECT Dept_ID, MIN(Salary) AS Min_Salary
    -> FROM Employee
    -> GROUP BY Dept_ID;
+---------+------------+
| Dept_ID | Min_Salary |
+---------+------------+
|     101 |      40000 |
|     102 |      52000 |
|     103 |      80000 |
|     104 |      60000 |
|     105 |      45000 |
+---------+------------+
5 rows in set (0.00 sec)

mysql> SELECT Dept_ID, SUM(Salary) AS Total_Salary
    -> FROM Employee
    -> GROUP BY Dept_ID;
+---------+--------------+
| Dept_ID | Total_Salary |
+---------+--------------+
|     101 |       180000 |
|     102 |       107000 |
|     103 |       170000 |
|     104 |        60000 |
|     105 |       115000 |
+---------+--------------+
5 rows in set (0.00 sec)

mysql> SELECT Dept_ID, COUNT(*) AS Employee_Count
    -> FROM Employee
    -> GROUP BY Dept_ID
    -> HAVING COUNT(*) > 3;
Empty set (0.00 sec)

mysql> SELECT Dept_ID, COUNT(*) AS Employee_Count
    -> FROM Employee
    -> GROUP BY Dept_ID
    -> HAVING COUNT(*) > 3;
Empty set (0.00 sec)

mysql> SELECT Dept_ID, AVG(Salary) AS Avg_Salary
    -> FROM Employee
    -> GROUP BY Dept_ID
    -> HAVING AVG(Salary) > 50000;
+---------+------------+
| Dept_ID | Avg_Salary |
+---------+------------+
|     101 | 60000.0000 |
|     102 | 53500.0000 |
|     103 | 85000.0000 |
|     104 | 60000.0000 |
|     105 | 57500.0000 |
+---------+------------+
5 rows in set (0.00 sec)

mysql> SELECT City, COUNT(*) AS Employee_Count
    -> FROM Employee
    -> GROUP BY City;
+-----------+----------------+
| City      | Employee_Count |
+-----------+----------------+
| Delhi     |              4 |
| Mumbai    |              3 |
| Pune      |              2 |
| Bangalore |              1 |
+-----------+----------------+
4 rows in set (0.00 sec)

mysql> SELECT City, AVG(Salary) AS Avg_Salary
    -> FROM Employee
    -> GROUP BY City;
+-----------+------------+
| City      | Avg_Salary |
+-----------+------------+
| Delhi     | 60000.0000 |
| Mumbai    | 65666.6667 |
| Pune      | 57500.0000 |
| Bangalore | 80000.0000 |
+-----------+------------+
4 rows in set (0.00 sec)

mysql> SELECT
    ->     e.Emp_Name,
    ->     d.Dept_Name
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID;
+----------+-----------+
| Emp_Name | Dept_Name |
+----------+-----------+
| Amit     | IT        |
| Rahul    | IT        |
| Aman     | IT        |
| Priya    | HR        |
| Arjun    | HR        |
| Karan    | Finance   |
| Sneha    | Finance   |
| Neha     | Marketing |
| Anjali   | Sales     |
| Riya     | Sales     |
+----------+-----------+
10 rows in set (0.00 sec)

mysql> SELECT
    ->     e.Emp_Name,
    ->     d.Location
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID;
+----------+-----------+
| Emp_Name | Location  |
+----------+-----------+
| Amit     | Delhi     |
| Rahul    | Delhi     |
| Aman     | Delhi     |
| Priya    | Mumbai    |
| Arjun    | Mumbai    |
| Karan    | Bangalore |
| Sneha    | Bangalore |
| Neha     | Delhi     |
| Anjali   | Pune      |
| Riya     | Pune      |
+----------+-----------+
10 rows in set (0.00 sec)

mysql>
mysql> SELECT e.*
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID
    -> WHERE d.Dept_Name='IT';
+--------+----------+------+--------+-------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City  | Salary | Dept_ID |
+--------+----------+------+--------+-------+--------+---------+
|      1 | Amit     |   28 | Male   | Delhi |  65000 |     101 |
|      3 | Rahul    |   30 | Male   | Delhi |  75000 |     101 |
|      9 | Aman     |   23 | Male   | Delhi |  40000 |     101 |
+--------+----------+------+--------+-------+--------+---------+
3 rows in set (0.02 sec)

mysql> SELECT *
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID;
+--------+----------+------+--------+-----------+--------+---------+---------+-----------+-----------+
| Emp_ID | Emp_Name | Age  | Gender | City      | Salary | Dept_ID | Dept_ID | Dept_Name | Location  |
+--------+----------+------+--------+-----------+--------+---------+---------+-----------+-----------+
|      1 | Amit     |   28 | Male   | Delhi     |  65000 |     101 |     101 | IT        | Delhi     |
|      3 | Rahul    |   30 | Male   | Delhi     |  75000 |     101 |     101 | IT        | Delhi     |
|      9 | Aman     |   23 | Male   | Delhi     |  40000 |     101 |     101 | IT        | Delhi     |
|      2 | Priya    |   26 | Female | Mumbai    |  55000 |     102 |     102 | HR        | Mumbai    |
|      7 | Arjun    |   29 | Male   | Mumbai    |  52000 |     102 |     102 | HR        | Mumbai    |
|      5 | Karan    |   35 | Male   | Bangalore |  80000 |     103 |     103 | Finance   | Bangalore |
|     10 | Sneha    |   33 | Female | Mumbai    |  90000 |     103 |     103 | Finance   | Bangalore |
|      6 | Neha     |   27 | Female | Delhi     |  60000 |     104 |     104 | Marketing | Delhi     |
|      4 | Anjali   |   24 | Female | Pune      |  45000 |     105 |     105 | Sales     | Pune      |
|      8 | Riya     |   31 | Female | Pune      |  70000 |     105 |     105 | Sales     | Pune      |
+--------+----------+------+--------+-----------+--------+---------+---------+-----------+-----------+
10 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Department d
    -> LEFT JOIN Employee e
    -> ON d.Dept_ID=e.Dept_ID;
+---------+-----------+-----------+--------+----------+------+--------+-----------+--------+---------+
| Dept_ID | Dept_Name | Location  | Emp_ID | Emp_Name | Age  | Gender | City      | Salary | Dept_ID |
+---------+-----------+-----------+--------+----------+------+--------+-----------+--------+---------+
|     101 | IT        | Delhi     |      1 | Amit     |   28 | Male   | Delhi     |  65000 |     101 |
|     101 | IT        | Delhi     |      3 | Rahul    |   30 | Male   | Delhi     |  75000 |     101 |
|     101 | IT        | Delhi     |      9 | Aman     |   23 | Male   | Delhi     |  40000 |     101 |
|     102 | HR        | Mumbai    |      2 | Priya    |   26 | Female | Mumbai    |  55000 |     102 |
|     102 | HR        | Mumbai    |      7 | Arjun    |   29 | Male   | Mumbai    |  52000 |     102 |
|     103 | Finance   | Bangalore |      5 | Karan    |   35 | Male   | Bangalore |  80000 |     103 |
|     103 | Finance   | Bangalore |     10 | Sneha    |   33 | Female | Mumbai    |  90000 |     103 |
|     104 | Marketing | Delhi     |      6 | Neha     |   27 | Female | Delhi     |  60000 |     104 |
|     105 | Sales     | Pune      |      4 | Anjali   |   24 | Female | Pune      |  45000 |     105 |
|     105 | Sales     | Pune      |      8 | Riya     |   31 | Female | Pune      |  70000 |     105 |
+---------+-----------+-----------+--------+----------+------+--------+-----------+--------+---------+
10 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Employee
    -> WHERE Dept_ID IS NULL;
Empty set (0.00 sec)

mysql> SELECT
    ->     d.Dept_Name,
    ->     COUNT(e.Emp_ID) AS Employee_Count
    -> FROM Department d
    -> LEFT JOIN Employee e
    -> ON d.Dept_ID=e.Dept_ID
    -> GROUP BY d.Dept_Name;
+-----------+----------------+
| Dept_Name | Employee_Count |
+-----------+----------------+
| IT        |              3 |
| HR        |              2 |
| Finance   |              2 |
| Marketing |              1 |
| Sales     |              2 |
+-----------+----------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     d.Dept_Name,
    ->     e.Emp_Name,
    ->     e.Salary
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID
    -> WHERE e.Salary =
    -> (
    ->     SELECT MAX(Salary)
    ->     FROM Employee
    ->     WHERE Dept_ID=e.Dept_ID
    -> );
+-----------+----------+--------+
| Dept_Name | Emp_Name | Salary |
+-----------+----------+--------+
| IT        | Rahul    |  75000 |
| HR        | Priya    |  55000 |
| Finance   | Sneha    |  90000 |
| Marketing | Neha     |  60000 |
| Sales     | Riya     |  70000 |
+-----------+----------+--------+
5 rows in set (0.02 sec)

mysql> SELECT
    ->     e.Emp_Name,
    ->     e.Salary,
    ->     d.Dept_Name,
    ->     d.Location
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID;
+----------+--------+-----------+-----------+
| Emp_Name | Salary | Dept_Name | Location  |
+----------+--------+-----------+-----------+
| Amit     |  65000 | IT        | Delhi     |
| Rahul    |  75000 | IT        | Delhi     |
| Aman     |  40000 | IT        | Delhi     |
| Priya    |  55000 | HR        | Mumbai    |
| Arjun    |  52000 | HR        | Mumbai    |
| Karan    |  80000 | Finance   | Bangalore |
| Sneha    |  90000 | Finance   | Bangalore |
| Neha     |  60000 | Marketing | Delhi     |
| Anjali   |  45000 | Sales     | Pune      |
| Riya     |  70000 | Sales     | Pune      |
+----------+--------+-----------+-----------+
10 rows in set (0.00 sec)

mysql> SELECT e.*
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.Dept_ID=d.Dept_ID
    -> WHERE d.Location='Delhi';
+--------+----------+------+--------+-------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City  | Salary | Dept_ID |
+--------+----------+------+--------+-------+--------+---------+
|      1 | Amit     |   28 | Male   | Delhi |  65000 |     101 |
|      3 | Rahul    |   30 | Male   | Delhi |  75000 |     101 |
|      9 | Aman     |   23 | Male   | Delhi |  40000 |     101 |
|      6 | Neha     |   27 | Female | Delhi |  60000 |     104 |
+--------+----------+------+--------+-------+--------+---------+
4 rows in set (0.00 sec)

mysql> SELECT
    ->     d.Dept_Name,
    ->     SUM(e.Salary) AS Total_Salary
    -> FROM Department d
    -> JOIN Employee e
    -> ON d.Dept_ID=e.Dept_ID
    -> GROUP BY d.Dept_Name;
+-----------+--------------+
| Dept_Name | Total_Salary |
+-----------+--------------+
| IT        |       180000 |
| HR        |       107000 |
| Finance   |       170000 |
| Marketing |        60000 |
| Sales     |       115000 |
+-----------+--------------+
5 rows in set (0.02 sec)

mysql> SELECT
    ->     d.Dept_Name,
    ->     COUNT(e.Emp_ID) AS Employee_Count
    -> FROM Department d
    -> JOIN Employee e
    -> ON d.Dept_ID=e.Dept_ID
    -> GROUP BY d.Dept_Name
    -> HAVING COUNT(e.Emp_ID)>5;
Empty set (0.00 sec)

mysql> SELECT Dept_ID, AVG(Salary) AS Avg_Salary
    -> FROM Employee
    -> GROUP BY Dept_ID
    -> ORDER BY Avg_Salary DESC
    -> LIMIT 1;
+---------+------------+
| Dept_ID | Avg_Salary |
+---------+------------+
|     103 | 85000.0000 |
+---------+------------+
1 row in set (0.00 sec)

mysql>
mysql> SELECT Dept_ID, COUNT(*) AS Employee_Count
    -> FROM Employee
    -> GROUP BY Dept_ID
    -> ORDER BY Employee_Count DESC
    -> LIMIT 1;
+---------+----------------+
| Dept_ID | Employee_Count |
+---------+----------------+
|     101 |              3 |
+---------+----------------+
1 row in set (0.00 sec)

mysql> SELECT *
    -> FROM Employee
    -> WHERE Age >
    -> (
    ->     SELECT AVG(Age)
    ->     FROM Employee
    -> );
+--------+----------+------+--------+-----------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City      | Salary | Dept_ID |
+--------+----------+------+--------+-----------+--------+---------+
|      3 | Rahul    |   30 | Male   | Delhi     |  75000 |     101 |
|      5 | Karan    |   35 | Male   | Bangalore |  80000 |     103 |
|      7 | Arjun    |   29 | Male   | Mumbai    |  52000 |     102 |
|      8 | Riya     |   31 | Female | Pune      |  70000 |     105 |
|     10 | Sneha    |   33 | Female | Mumbai    |  90000 |     103 |
+--------+----------+------+--------+-----------+--------+---------+
5 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Employee e
    -> WHERE Salary >
    -> (
    ->     SELECT AVG(Salary)
    ->     FROM Employee
    ->     WHERE Dept_ID=e.Dept_ID
    -> );
+--------+----------+------+--------+--------+--------+---------+
| Emp_ID | Emp_Name | Age  | Gender | City   | Salary | Dept_ID |
+--------+----------+------+--------+--------+--------+---------+
|      1 | Amit     |   28 | Male   | Delhi  |  65000 |     101 |
|      2 | Priya    |   26 | Female | Mumbai |  55000 |     102 |
|      3 | Rahul    |   30 | Male   | Delhi  |  75000 |     101 |
|      8 | Riya     |   31 | Female | Pune   |  70000 |     105 |
|     10 | Sneha    |   33 | Female | Mumbai |  90000 |     103 |
+--------+----------+------+--------+--------+--------+---------+
5 rows in set (0.02 sec)

mysql> mysqldump -u root -p Employee_Management > Employee_Management.sql
    -> Employee_Management.sql.
    -> exit;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'mysqldump -u root -p Employee_Management > Employee_Management.sql
Employee_Mana' at line 1
mysql> exit;
