use NORTHWND


use Datamart1
SELECT *
INTO Datamart1.dbo.DCustomer
FROM NORTHWND.dbo.Customers
where 1 = 0

select *
from Datamart1.dbo.DCustomer


SELECT *
INTO Datamart1.dbo.DShippers
FROM NORTHWND.dbo.Shippers
where 1 = 0

select *
from Datamart1.dbo.DShippers

SELECT *
INTO Datamart1.dbo.DOrders
FROM NORTHWND.dbo.Orders
where 1 = 0

select *
from Datamart1.dbo.DOrders


-- AGREGA LA RESTRICCION DE PRIMARY KEY A LA TABLA DCUSTOMERS

alter table Datamart1.dbo.dCustomer
add constraint pk_dCustomer
primary key (customerId)

-- AGREGA LA RESTRICCION DE PRIMARY KEY A LA TABLA DSHIPPERS

alter table Datamart1.dbo.dShippers
add constraint pk_dShippers
primary key (shipperId)

-- AGREGA LA RESTRICCION DE PRIMARY KEY A LA TABLA DOrders

alter table Datamart1.dbo.dOrders
add constraint pk_dOrders
primary key (OrderID)

-- AGREGA LA RESTRICCION DE FOREIGN KEY A LA TABLA DOrders

alter table Datamart1.dbo.dOrders
add constraint fk_dOrders
foreign key (ShipVia) 
REFERENCES Datamart1.dbo.dShippers (ShipperId);

-- AGREGA LA RESTRICCION DE FOREIGN KEY A LA TABLA DOrders

alter table Datamart1.dbo.dOrders
add constraint fk_dOrders
foreign key (ShipVia) 
REFERENCES Datamart1.dbo.dShippers (ShipperId);

-- AGREGA LA RESTRICCION DE FOREIGN KEY A LA TABLA DOrders

alter table Datamart1.dbo.dOrders
add constraint fk_dOrders_dCustomer
foreign key (CustomerId) 
REFERENCES Datamart1.dbo.dCustomer (CustomerId);

--SUBCONSULTA DE UNA TABLA---
--COMIENZO DIAGRAMA ESTRELLA---

SELECT o.OrderID, o.OrderDate, o.EmployeeID, e.FullName, c.CompanyName,
c.City, c.Country, od.Quantity, od.UnitPrice, od.Discount, od.Mount, p.ProductName
FROM Orders as o
inner join (
select employeeid, 
CONCAT(FirstName, ' ' ,LastName)
as FullName
from Employees
)as e
on o.EmployeeID = e.EmployeeID
INNER JOIN(
SELECT CompanyName, City, Country, CustomerID
FROM Customers  
) AS c
ON o.CustomerID=c.CustomerID 
INNER JOIN(
SELECT UnitPrice, Quantity, Discount, (UnitPrice*Quantity) as
Mount, OrderID, ProductID
FROM [Order Details]
) AS od
on o.OrderID = od.OrderID
INNER JOIN(
SELECT ProductID, ProductName
FROM Products
)AS p
on od.ProductID  = p.ProductID

-- CREAR REPORTE VISTA


CREATE VIEW REPORTEVENTAS
AS 

SELECT o.OrderID, o.OrderDate, o.EmployeeID, e.FullName, c.CompanyName,
c.City, c.Country, od.Quantity, od.UnitPrice, od.Discount, od.Mount, p.ProductName
FROM Orders as o
inner join (
select employeeid, 
CONCAT(FirstName, ' ' ,LastName)
as FullName
from Employees
)as e
on o.EmployeeID = e.EmployeeID
INNER JOIN(
SELECT CompanyName, City, Country, CustomerID
FROM Customers  
) AS c
ON o.CustomerID=c.CustomerID 
INNER JOIN(
SELECT UnitPrice, Quantity, Discount, (UnitPrice*Quantity) as
Mount, OrderID, ProductID
FROM [Order Details]
) AS od
on o.OrderID = od.OrderID
INNER JOIN(
SELECT ProductID, ProductName
FROM Products
)AS p
on od.ProductID  = p.ProductID


SELECT * FROM REPORTEVENTAS
WHERE ProductName ='Queso Cabrales'