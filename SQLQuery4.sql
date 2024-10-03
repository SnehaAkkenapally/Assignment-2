

--1.      How many products can you find in the Production.Product table?
SELECT COUNT(DISTINCT ProductNumber) AS Totalnumofproducts
FROM Production.Product

--2.      Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT *
FROM Production.Product

SELECT COUNT(DISTINCT ProductNumber) AS Totalnumofproducts
FROM Production.Product WHERE ProductSubcategoryID IS NOT NULL


--3.      How many Products reside in each SubCategory? Write a query to display the results with the following titles.

--ProductSubcategoryID CountedProducts

-------------------- ---------------\
SELECT ProductSubcategoryID , 
 COUNT(*) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

--4.      How many products that do not have a product subcategory.
SELECT ProductSubcategoryID,COUNT(DISTINCT ProductNumber) AS Totalnumofproducts
FROM Production.Product where ProductSubcategoryID IS NULL
GROUP BY ProductSubcategoryID


--5.      Write a query to list the sum of products quantity of each product in the Production.ProductInventory table.

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY ProductID

--6.    Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.

             -- ProductID    TheSum

              -----------        ----------
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100

--7.    Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100

    --Shelf      ProductID    TheSum

    ----------   -----------        -----------
SELECT Shelf,ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf,ProductID
HAVING SUM(Quantity) < 100


--8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.

SELECT Shelf,ProductID, Avg(Quantity) as AverageQuantity
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY Shelf,ProductID 



9.    Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory

    ProductID   Shelf      TheAvg

    ----------- ---------- -----------
SELECT ProductID,Shelf, Avg(Quantity) as AverageQuantity
FROM Production.ProductInventory
GROUP BY Shelf,ProductID 

10.  Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory

    ProductID   Shelf      TheAvg

    ----------- ---------- -----------
SELECT ProductID,Shelf, Avg(Quantity) as AverageQuantity
FROM Production.ProductInventory
Where Shelf <> 'N/A'
GROUP BY Shelf,ProductID 

11.  List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.

    Color                        Class              TheCount          AvgPrice

    -------------- - -----    -----------            ---------------------
SELECT 
    Color, 
    Class, 
    COUNT(*) AS Rows, 
    AVG(ListPrice) AS AvgPrice
FROM 
    Production.Product
WHERE 
    NOT (Color IS NULL OR Class IS NULL)
GROUP BY 
    Color, Class


--Joins:

--12.   Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.

    --Country                        Province

    ---------                          ----------------------
SELECT 
    CR.Name AS Country, 
    SP.Name AS Province
FROM 
    Person.CountryRegion CR
JOIN 
    Person.StateProvince SP ON CR.CountryRegionCode = SP.CountryRegionCode

--13.  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
-- Country                        Province

    ---------                          ----------------------
 SELECT 
    CR.Name AS Country, 
    SP.Name AS Province
FROM 
    Person.CountryRegion CR
JOIN 
    Person.StateProvince SP ON CR.CountryRegionCode = SP.CountryRegionCode
Where CR.Name IN ('Germany', 'Canada')



 Using Northwnd Database: (Use aliases for all the Joins)

--14.  List all Products that has been sold at least once in last 27 years.
SELECT 
    O.OrderID, 
    O.OrderDate, 
    C.CustomerID, 
    C.CompanyName
FROM 
    Orders O 
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
WHERE 
    O.OrderDate >= DATEADD(YEAR, -27, GETDATE()); 

--15.  List top 5 locations (Zip Code) where the products sold most.

SELECT TOP 5 
    C.PostalCode, 
    COUNT(O.OrderID) AS ProductsSold
FROM 
    Orders O
JOIN 
    Customers C ON O.CustomerID = C.CustomerID  WHERE  C.PostalCode IS NOT NULL
GROUP BY 
    C.PostalCode
ORDER BY 
    ProductsSold DESC;

--16.  List top 5 locations (Zip Code) where the products sold most in last 27 years.
SELECT TOP 5 
    C.PostalCode, 
    COUNT(O.OrderID) AS ProductsSold
FROM 
    Orders O
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
WHERE 
    C.PostalCode IS NOT NULL 
    AND O.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY 
    C.PostalCode
ORDER BY 
    ProductsSold DESC;

--17.   List all city names and number of customers in that city.    
SELECT 
    City, 
    COUNT(CustomerID) AS NumberOfCustomers
FROM 
    Customers
GROUP BY 
    City
ORDER BY 
    NumberOfCustomers DESC;

--18.  List city names which have more than 2 customers, and number of customers in that city
SELECT 
    City, 
    COUNT(CustomerID) AS NumberOfCustomers
FROM 
    Customers
GROUP BY 
    City
HAVING 
    COUNT(CustomerID) > 2
ORDER BY 
    NumberOfCustomers DESC;

--19.  List the names of customers who placed orders after 1/1/98 with order date.
SELECT C.ContactName, O.OrderDate 
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID 
WHERE O.OrderDate > '1998-01-01' ORDER BY O.OrderDate;

--20.  List the names of all customers with most recent order dates

SELECT C.ContactName, MAX(O.OrderDate) AS MostRecentOrderDate
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.ContactName ORDER BY MostRecentOrderDate DESC;

--21.  Display the names of all customers  along with the  count of products they bought
SELECT C.ContactName, Count(OrderID) As CountofProducts
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.ContactName   ORDER BY   CountofProducts DESC;


--22.  Display the customer ids who bought more than 100 Products with count of products.
Select C.CustomerId,Count(OrderID) As CountofProducts from Customers C Join Orders O on  C.CustomerID = O.CustomerID
Group by C.CustomerID Having Count(OrderID) > 100 



--23.  List all of the possible ways that suppliers can ship their products. Display the results as below

   -- Supplier Company Name                Shipping Company Name

    ---------------------------------            ----------------------------------
	SELECT 
    S.CompanyName AS [Supplier Company Name], 
    Sh.CompanyName AS [Shipping Company Name]
FROM 
    Suppliers S
JOIN 
    Shippers Sh ON S.SupplierID = Sh.ShipperID 
ORDER BY 
    S.CompanyName, Sh.CompanyName;
	
--24.  Display the products order each day. Show Order date and Product Name.

SELECT 
    O.OrderDate, 
    P.ProductName
FROM 
    Orders O
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID  -- Using brackets to reference the table
JOIN 
    Products P ON OD.ProductID = P.ProductID
ORDER BY 
    O.OrderDate, P.ProductName;
    

--25.  Displays pairs of employees who have the same job title.
SELECT 
    E1.Firstname AS Employee1Firstname, 
   E1.Lastname AS Employee1Lastname, 
    E2.Firstname AS Employee2Firstname, 
    E2.Lastname AS Employee2Lastname, 
    E1.Title
FROM 
    Employees E1 
JOIN 
    Employees E2 ON E1.Title = E2.Title 
WHERE 
    E1.EmployeeID < E2.EmployeeID ORDER BY 
    E1.Title, Employee1Firstname, Employee2Firstname;

--26.  Display all the Managers who have more than 2 employees reporting to them.
SELECT 
    M.Firstname AS ManagerFirstname, 
    M.Lastname AS ManagerLastname, 
    COUNT(E.EmployeeID) AS EmployeeCount
FROM 
    Employees M
JOIN 
    Employees E ON M.EmployeeID = E.ReportsTo
WHERE 
    M.Title = 'Sales Manager' 
GROUP BY 
    M.EmployeeID, M.Firstname, M.Lastname
HAVING 
    COUNT(E.EmployeeID) > 2;


select *  from Employees

--27.  Display the customers and suppliers by city. The results should have the following columns

City

Name

Contact Name,

Type (Customer or Supplier)

SELECT C.City, C.CompanyName AS Name, C.ContactName, 'Customer' AS Type FROM Customers C 
UNION ALL 
SELECT S.City, S.CompanyName AS Name, S.ContactName, 'Supplier' AS Type FROM Suppliers S 
ORDER BY City, Type, Name;