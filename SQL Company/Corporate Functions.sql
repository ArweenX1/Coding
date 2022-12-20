-- Find the number of employees

SELECT COUNT(emp_id) FROM employee;

--Count how many employess have supervisors

SELECT COUNT (position) From employee;

--Find the number of female employess born after 1970

SELECT COUNT(emp_id)
FROM employee
WHERE
    sex = 'F'
    AND birth_day > '1970-01-01';

--Find the average of all employee salaries

SELECT AVG(salary) FROM employee;

--FIND the average salary for male employees

SELECT AVG(salary) FROM employee WHERE sex = 'M';

--Find the sum of all employee salaries

SELECT SUM(salary) FROM employee;

--Find out how many males and females there AFTER (aggregation)

SELECT COUNT(sex), sex FROM employee GROUP BY sex;

--Find the total sales of each salesman (aggregation)

SELECT
    SUM(total_sales),
    emp_id
FROM work_with
GROUP BY emp_id;

--Find how much money each client actually spent with the branch (aggregation)

SELECT
    SUM(total_sales),
    client_id
FROM work_with
GROUP BY client_id;

-----------------------------------------------WILD CARDS AND LIKE KEYWORD...

--Find any client that is an LCC (% = any number of characters basically % is begining from or ending

--with and you can put it in front or behind and _ = one charachter)

SELECT * FROM client WHERE client_name LIKE '%LLC';

--Find and branch suppliers who are in the label business

SELECT *
FROM branch_supplie
WHERE
    supplier_name LIKE '%lable%';

--Find any employee born october

SELECT * FROM employee WHERE birth_day LIKE '____-10%';

--Find any employee born Februaru

SELECT * FROM employee WHERE birth_day LIKE '____-02%';

--Find any client who are schools

SELECT * FROM client WHERE client_name LIKE '%school%';

-------------------------------

----------------------------UNIONS = operator to combine results of multiple select statements into one result

--Find a list of employees and branch names

SELECT
    first_name AS Company_Names
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

--Find a list of all clients and branch supplier names

SELECT client_name, branch_id
FROM client
UNION
SELECT
    supplier_name,
    branch_id
FROM branch_supplie;

--Find a list of all money spent or earned

SELECT total_sales
FROM work_with
UNION
SELECT salary
FROM employee;

----------------------------JOINS = combine rows from 2 or more tables based on related column between them

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

----exmaple inner JOIN = combine rows when they have the shared column in common (employee id = manager id)

--Find all branches and the names of their managers

SELECT
    employee.emp_id,
    employee.first_name,
    branch.branch_name
FROM employee
    JOIN branch ON employee.emp_id = branch.mgr_id;

--join employee table and branch table together into 1 table, and join them together on a specific column

--*RECIEVE ONLY MANAGER AND BRANCHES*

----example left JOIN = we include all of the rows from the left table (the FROM statement), but only the rows that matched will be included

----from the branch table because that is the right table

-- FIND all branched and the names of their managers

SELECT
    employee.emp_id,
    employee.first_name,
    branch.branch_name
FROM employee
    LEFT JOIN branch ON employee.emp_id = branch.mgr_id;

--all employees got included

--*RECIEVE MANAGER AND BRANCHES AND ALL THE EMPLOYESS FROM THE LEFT TABLE THAT ARE NOT MANAGER*

----example right JOIN = we include all of the rows from the right table (the FROM statement), include everything from the branch table

----because that is the right table

-- FIND all branched and the names of their managers

SELECT
    employee.emp_id,
    employee.first_name,
    branch.branch_name
FROM employee
    RIGHT JOIN branch ON employee.emp_id = branch.mgr_id;

--*RECIEVE MANAGER AND BRANCHES AND ALL THE BRANCH NAMES FROM RIGHT TABLE DONR HAVE MANAGERS*

---example FULL OUTER JOIN = COMBINE FROM LEFT AND RIGHT (Not availble in my SQL)

--------------------------NESTED QUERIES = a query where you use multiple select statements to get a specific piece of information

--Find names of all employess who have sold over 30,000 to a single client

SELECT
    work_with.emp_id
FROM work_with
WHERE
    work_with.total_sales > 30000
SELECT
    employee.first_name,
    employee.last_name
FROM employee
WHERE employee.emp_id IN (
        SELECT work_with.emp_id
        FROM work_with
        WHERE
            work_with.total_sales > 30000
    );

-- Find all clients who are handled by the branch that michel scott manager (assume you know michaels ID)

SELECT branch.branch_id FROM branch WHERE branch.mgr_id = 102;

SELECT client.client_name
FROM client
WHERE client.branch_id IN (
        SELECT branch.branch_id
        FROM branch
        WHERE branch.mgr_id = 102
        LIMIT
            1 -- just in case he is the manager at multiple branches
    );

----------------------ON DELETE = used when entries are deleted it effects foreighn keys, to fix ->

----------------------ON DELETE SET NULL = if we delete an employee that means the manager id (foreighn key/associated attribute) will be set to null

----------------------ON DELETE CASCADE = if we delete an employe then attributed row (manager id) will be deleted as well

DELETE FROM employee WHERE emp_id = 102;

-- delete michel scott from employee

-- ON DELETE SET NULL EXAMPLE

SELECT * from branch;

-- manager id is now set to null, becuase we added that previously

SELECT * from employee;

--super id now set to null, because we added on delete set to null to employee table

-- ON DELETE CASCADE EXAMPLE

DELETE FROM branch WHERE branch_id = 2;

SELECT * FROM branch_supplie;

-- any row with brand ID is deleted now ADD

INSERT INTO employee
VALUES (
        109,
        'Oscar',
        'Meyer',
        '2022-08-02',
        'M',
        350000,
        NULL,
        NULL
    );

Values ( ADD 110, 'Michael' 'Sam' );

-- why was it okay to use on delete cascade on the branch table? because the manager_id in the brach table was just a foreighn key not a primary KEY

--Continuing the branch supplier to it is bad because the primary composite uses branch ID and primarys cant have null values

--crucial to define key relationship

---------------------------TRIGGERS = block of SQL code we can write that will define a certain action that should happen when a

---------------------------a certain operation gets performed on the database (ex. we can write a trigger which would tell my SQL

---------------------------to do something when a entry was added into a particular table or when something was deleted from a DB table

---------------------------basically we can tell it "hey anytime a row gets deleted from this table i want to insert something into something else")

--Illustraion example (not needed)

--CREATE TABLE trigger_test (

--message VARCHAR(100)

--

--when writing triggers we need to use mysql command line center

--Trigger example (usually semicolon is the SQL delimiter, but in triggers we have to use a semicolon within the trigger)

--??????????????????????????????????

--------------------------------------------ER DIAGRAMS = diagram that consists of different shapes, symbols, text the combines together to define relationship model(great way to take data storage requirements

------------------------------------------, Busines requirements and convert them to DB SCHEMA

-----------DB SCHEMA = all the diferent tables, attributes on the tables, requirements for different data, different relationships (we use er diagram to act as middle man between storage requirements and the

-----------actual DB shema that is going to get implenmented in the DBMS)

--ER Diagram for school -> students, classes,gpa,etc..

--ENtity = an object we want to model & store information about (student)

--Attributed = Specific pieces of information about an entity (name,grade,GPA)

--PRimary Key = an attirbute that uniquely identifies and entry in the DB Table (underlined student ID)

--composite attributes = an attribute that can be broken up into sub-attributes (fname, lname)

--Multi values Attrivute = an attribute that can have more than one value (school clubs)

--Derived attribute = an attribute that can be derived from the other attribute ('has_honors' could be derived from GPA attribute, lets say school says anyone above 3.0GPA has honors)

--Multiple entities = you can more than one enity (we had student with attributes attached ot it, another entity is class)

--Relationship = defines a relationsjip between two entities

--Total participation - All members must participate in the relationship

--Relationship attribute - an attribute about the relationship

--Relationship cardinality = the number of instances of an entity from a relation that can be associated with the relation

--Weak entity - an entity that cannot be uniqely indentified by its attrbiutes alone ('Exam' only exists for a class)

--indentifying relationship - a relationship that serves to uniquely indentify the weak entity