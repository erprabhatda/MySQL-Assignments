
-- ===================================================start assigment-- ===================================================
USE classicmodels;

-- 1st days

-- ●	State should not contain null values
-- ●	credit limit should be between 50000 and 100000
select customernumber, customername, state,creditlimit from  customers where state is not null 
and creditlimit between 50000 and 100000  order by creditlimit desc limit 14;

-- 2)	Show the unique productline values containing the word cars at the end from products table.
-- Expected output:

SELECT DISTINCT productline
FROM products
WHERE productline LIKE '%cars';

-- 2nd days
-- 1)	Show the orderNumber, status and comments from orders table for shipped 
-- status only. If some comments are having null values then show them as “-“.
SELECT
orderNumber,
status,
case when comments is not null then  comments
else'-'
end as comments
FROM orders
WHERE status = 'Shipped';

-- 2)	Select employee number, first name, job title and job title abbreviation from employees table based on following conditions.
-- If job title is one among the below conditions, then job title abbreviation column should show below forms.
-- ●	President then “P”
-- ●	Sales Manager / Sale Manager then “SM”
-- ●	Sales Rep then “SR”
-- ●	Containing VP word then “VP”
Select employeenumber, firstname, jobtitle ,
case
when jobtitle='president' then 'P'
when jobtitle='sale manager (EMEA)' then 'SM'
when jobtitle='sales manager (APAC)' then 'SM'
when jobtitle='sales manager (NA)' then 'SM'
when JOBTITLE= 'SALES REP' THEN 'SR'
when JOBTITLE='VP SALES' THEN 'VP'
when JOBTITLE='VP MARKETING ' THEN 'VP'

 END AS jobtitle_abbreviation 
FROM employees
order by  jobtitle;

-- 3rd DAYS
-- 1)	For every year, find the minimum amount value from payments table.

SELECT YEAR(paymentDate) AS paymentYear, MIN(amount) AS minPaymentAmount
FROM payments
GROUP BY paymentYear;


-- 2)	For every year and every quarter, find the unique customers and 
-- total orders from orders table. Make sure to show the quarter as Q1,Q2 etc.
SELECT
    YEAR(orderDate) AS orderYear,
    CONCAT('Q', QUARTER(orderDate)) AS orderQuarter,
    COUNT(DISTINCT customerNumber) AS uniqueCustomers,
    COUNT(*) AS totalOrders
FROM orders
GROUP BY orderYear, orderQuarter
ORDER BY orderYear, orderQuarter;


-- 3)	Show the formatted amount in thousands unit (e.g. 500K, 465K etc.) for every month (e.g. Jan, Feb etc.) 
-- with filter on total amount as 500000 to 1000000. Sort the output by total amount in descending mode. [ Refer. Payments Table]
SELECT
    DATE_FORMAT(paymentDate, '%b') AS month,
    CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS formatted_amount
FROM payments
GROUP BY month
HAVING SUM(amount) >= 500000 AND SUM(amount) <= 1000000
ORDER BY SUM(amount) DESC;

-----------------------------------------------------------
-----------------------------------------------------------

-- 4th DAYS
-- 1)	Create a journey table with following fields and constraints.

CREATE TABLE journey (
    Bus_ID INT PRIMARY KEY,
    Bus_Name VARCHAR(255) NOT NULL,
    Source_Station VARCHAR(255) NOT NULL,
    Destination VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE
);
select*FROM JOURNEY;

-- 2)	Create vendor table with following fields and constraints.

create table Vendor(
Vendor_ID smallint primary key,
Name char(255) not null,
Email VARCHAR(255) NOT NULL UNIQUE,
Country varchar(255) default('N/A') 
);
select *from vendor;

-- 3)	Create movies table with following fields and constraints.

 create table movies(
	Movie_ID int primary key,
	Name char(255) not null,
	Release_Year INT  DEFAULT('-') CHECK(Release_Year>=0 OR Release_Year='-'),
	Cast VARCHAR(255) NOT NULL,
	GENDER varchar(40) CHECK(GENDER='MALE' OR GENDER='FEMALE'),
	No_of_shows INT check(No_of_shows>0)
    );
    insert into movies values(1,'newmovie',7,'nopr','male',3);
    select*from movies;

-- 4)Create the following tables. Use auto increment wherever applicable

-- a)
	create  table Product(
	product_id smallint primary key  auto_increment,
	product_name char(255) not null UNIQUE,
	description text,
	supplier_id int,
	FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
    );
    select*from Product;
    
--     b) 
create table supplier(
	supplier_id smallint primary key auto_increment,
	supplier_name char(255) not null,
	location varchar(255)
);
select*from Supplier;


-- c) 
 create table Stock(
	id  int primary key auto_increment,
	product_id  int,
	balance_stock int,
     FOREIGN KEY (product_id) REFERENCES Product(product_id)
    );
    select*from  Stock;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--   5th  Day
-- 1)	Show employee number, Sales Person (combination of first and last names of employees), 
-- unique customers for each employee number and sort the data by highest to lowest unique customers.

Select employees.employeenumber ,concat(employees.firstName,employees.lastname) As Salesperson,
Count(customers.customernumber)As unique_customer
 from employees join customers
on employees.employeenumber=customers.salesRepemployeenumber
group by employees.employeenumber order by unique_customer desc;

    
--  ==================================================================
-- 2)

SELECT
	temp.CustomerNumber,temp.customername,products.productcode,products.productname,
    temp.quantityordered as ordered_qty,products.quantityinstock as totalinventory,
    (products.quantityinstock-temp.quantityordered) as left_qtr 
    from products
JOIN(
  select  Orders.customernumber,orderdetails.quantityordered,orderdetails.productcode,customers.customername from orders
JOIN
    Orderdetails  ON orderdetails.ordernumber = orders.ordernumber
JOIN customers on orders.customernumber=customers.customernumber) as temp
on products.productcode=temp.productcode
ORDER BY customernumber,customername,productcode;
  
 --    ========================================
--  3)	Create below tables and fields. (You can add the data as per your wish)

-- ●	Laptop: (Laptop_Name)
-- ●	Colours: (Colour_Name)
-- Perform cross join between the two tables and find number of rows.

-- Create the Laptop table
CREATE TABLE Laptop (
    Laptop_Name VARCHAR(50)
);
INSERT INTO Laptop (Laptop_Name)
VALUES 
    ('dell'),
    ('hp');


-- Create the Colours table
CREATE TABLE Colours (
    Colour_Name VARCHAR(20)
);

-- Insert sample data into the Colours table
INSERT INTO Colours (Colour_Name)
VALUES 
    ('white'),
    ('silver'),
    ('Black');

-- Perform a cross join between the two tables
SELECT * 
FROM Laptop
 JOIN Colours;






-- ======================================================
-- 4)

create table project(
	EmployeeID int ,
	FullName char(255),
	Gender varchar(255),
	ManagerID varchar(255)
);
drop table project;

INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

select e2.fullName, e1.fullName from
project  as e1  join project as e2
on e1.ManagerID = e2.EmployeeID
order by e2.fullname;


select*from project;
-- ================================================================================
-- ================================================================================

--  6th days
-- Create table facility. Add the below fields into it.
-- ●	Facility_ID
-- ●	Name
-- ●	State
-- ●	Country
-- i) Alter the table by adding the primary key and auto increment to Facility_ID column.
-- ii) Add a new column city after name with data type as varchar which should not accept any null values.
-- ALL MOST DONE  ONLY AUTOICREMENY
create table facility(
Facility_ID int,
name char(100),
state varchar(100) ,
country varchar(100)
);
drop table  facility;
alter table  facility add  city  varchar(100)not null after name ;
alter table  facility add primary key auto_increment(Facility_ID);

select*from facility;
desc facility;
-- ===================================================================
-- ================================================================================
-- ================================================================================

-- 7th days
-- Create table university with below fields.
-- ●	ID
-- ●	Name
-- Add the below data into it as it is.
-- INSERT INTO University
-- VALUES (1, "       Pune          University     "), 
--                (2, "  Mumbai          University     "),
--               (3, "     Delhi   University     "),
--               (4, "Madras University"),
--               (5, "Nagpur University");
-- Remove the spaces from everywhere and update the column like Pune University etc.

CREATE TABLE University(
ID INT ,
NAME CHAR(255)
);
INSERT INTO  university 
 VALUES (1, "       Pune          University     "), 
                (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
               (4, "Madras University"),
               (5, "Nagpur University");
select id,replace(replace(replace(trim(name),' ','()'),')(',''),'()',' ') AS name from university;

-- =====================================================================================
-- 10)
create view products_status as 
select year (orders.orderdate) as year , concat(count(orderdetails.productcode),'(',
floor((count(orderdetails.productcode)*100/(select count(*) from orderdetails))),'%)') as value
 from orders
 join orderdetails  on orders.ordernumber =orderdetails.ordernumber
 group by year(orders.orderdate) order by value desc;
 
 select *from products_status;



-- ===========================================================================
-- ================================================================================
-- ================================================================================

-- 8th days
-- 1)	Create a stored procedure GetCustomerLevel which takes input as customer number and 
-- gives the output as either Platinum, Gold or Silver as per below criteria.

DELIMITER //

CREATE PROCEDURE GetCustomerLevel(IN customerNumber INT, OUT customerLevel VARCHAR(20))
BEGIN
    DECLARE creditLimit DECIMAL(10, 2);

    -- Get the credit limit for the given customer number
    SELECT creditLimit INTO creditLimit FROM Customers WHERE customerNumber = customerNumber;

    -- Determine the customer level based on creditLimit
    IF creditLimit > 100000 THEN
        SET customerLevel = 'Platinum';
    ELSEIF creditLimit BETWEEN 25000 AND 100000 THEN
        SET customerLevel = 'Gold';
    ELSE
        SET customerLevel = 'Silver';
    END IF;
END //

DELIMITER ;

-- 2)	Create a stored procedure Get_country_payments which takes in year and country as inputs and gives year wise, country wise total amount as an output. Format the total amount to nearest thousand unit (K)
-- Tables: Customers, Payments


DELIMITER //

CREATE PROCEDURE Get_country_payments(IN p_year INT, IN p_country VARCHAR(50), OUT p_total_amount VARCHAR(50))
BEGIN
    DECLARE total DECIMAL(10, 2);

    -- Calculate the total payment amount for the given year and country
    SELECT FORMAT(SUM(p.amount) / 1000, 0) INTO p_total_amount
    FROM Payments p
    JOIN Customers c ON p.customerNumber = c.customerNumber
    WHERE YEAR(p.paymentDate) = p_year AND c.country = p_country;
    
END //

DELIMITER ;
-- ===============================================================================
-- 12)
-- 1)
select year,month,total_orders,concat(round((total_orders-previous_month_sales)
/previous_month_sale*100),'%') as percentageYOY_change
from (select year(orderdate) as year,monthname(orderdate)as 
month,count(orderdate) as total_orders,
lag(count(ordernumber),1)over(order by year(orderdate))
previous_month_sales from orders group by year(orderdate),monthname(orderdate))
 as temp_table;









-- =======================================================================
-- ================================================================================
-- ================================================================================

-- 9th days 
-- 2)
CREATE TABLE emp_udf (
    Emp_ID INT PRIMARY KEY AUTO_INCREMENT ,
    Name VARCHAR(255) NOT NULL,
    DOB DATE 
);


INSERT INTO emp_udf (Name, DOB)
VALUES 
    ("Piyush", "1990-03-30"),
    ("Aman", "1992-08-15"),
    ("Meena", "1998-07-28"),
    ("Ketan", "2000-11-21"),
    ("Sanjay", "1995-05-21");
    select*,calculate_age(DOB) as age from emp_udf;

-- Create the user-defined function calculate_age
set global log_bin_trust_function_creators=1;

DELIMITER //

CREATE FUNCTION calculate_age(dob DATE)
RETURNS VARCHAR(50)
BEGIN
    DECLARE years INT;
    DECLARE months INT;
    DECLARE age VARCHAR(50);
    

    SET years = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    SET months = TIMESTAMPDIFF(MONTH, dob, CURDATE()) - (years * 12);
    SET age = CONCAT(years, ' years ', months, ' months');
    
    RETURN age;
END //

DELIMITER ;
-- ======================================================================
-- ================================================================================
-- ================================================================================

-- 10th days
-- 1)
SELECT customerNumber, customerName
FROM Customers
WHERE customerNumber NOT IN (
    SELECT customerNumber
    FROM ORDERS);
 
--  2)
    
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS orderCount
FROM Customers c
LEFT JOIN Orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName

UNION 

SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS orderCount
FROM Customers c
RIGHT JOIN Orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName;

-- 3)
SELECT
    orderNumber,
    MAX(quantityOrdered) AS second_highest_quantity
FROM
    Orderdetails AS o1
WHERE
    quantityOrdered < (
        SELECT MAX(quantityOrdered)
        FROM Orderdetails AS o2
        WHERE o1.orderNumber = o2.orderNumber
    )
GROUP BY
    orderNumber;
-- 4)

select min(total),max(total) from (select count(distinct productcode) as total from orderdetails 
group by ordernumber) as temp_table;
    
--     5)

SELECT productLine, COUNT(*) AS productLineCount
FROM Products
WHERE buyPrice > (
    SELECT AVG(buyPrice)
    FROM Products
)
GROUP BY productLine;

-- 10th DAYS)
-- Create the Emp_EH table
CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(255),
    EmailAddress VARCHAR(255)
);
SELECT*FROM Emp_EH;
-- Create the procedure with error handling
DELIMITER //

CREATE PROCEDURE Insert_Emp_EH(IN p_EmpID INT, IN p_EmpName VARCHAR(255), IN p_EmailAddress VARCHAR(255))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error by displaying a custom message
        SELECT 'Error occurred' AS ErrorMessage;
    END;

    -- Insert the values into the Emp_EH table
    INSERT INTO Emp_EH (EmpID, EmpName, EmailAddress)
    VALUES (p_EmpID, p_EmpName, p_EmailAddress);
END //

DELIMITER ;
-- ==================================================================
-- ================================================================================
-- ================================================================================


-- 11th DAYS

-- Create the Emp_BIT table
CREATE TABLE Emp_BIT (
    Name VARCHAR(255),
    Occupation VARCHAR(255),
    Working_date DATE,
    Working_hours INT
);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);

SELECT*FROM Emp_BIT ;
-- Create a before insert trigger
DELIMITER //
CREATE TRIGGER Emp_BIT_BeforeInsert
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = -NEW.Working_hours;
    END IF;
END //

DELIMITER ;



