show databases;

use fingertips;
show tables;

-- Manufacturers
CREATE TABLE Manufacturers (
  Manufacturer_Code INT PRIMARY KEY,
  Manufacturer_Name VARCHAR(50)
);

-- Product Inventory
CREATE TABLE Product_Inventory (
  Product_Code INT PRIMARY KEY,
  Product_Name VARCHAR(200),
  Product_Price INT(20),
  Manufacturer_Code INT,
  FOREIGN KEY (Manufacturer_Code) REFERENCES Manufacturers(Manufacturer_Code)
);

-- Insert values into Manufacturers table
INSERT INTO Manufacturers (Manufacturer_Code, Manufacturer_Name)
VALUES
	(1, 'Western Digital'),
	(2, 'Samsung'),
	(3, 'Hewlett Packard'),
	(4, 'Corsair'),
	(5, 'Asus'),
	(6, 'Ant esports'),
	(7, 'Cosmic Byte'),
	(8, 'Zebronics'),
	(9, 'TP-Link'),
	(10, 'BoAt');

#INSERT VALUES IN TABLES
-- Insert values into Product_Inventory table
INSERT INTO Product_Inventory (Product_Code, Product_Name, Product_Price, Manufacturer_Code)
VALUES
	(1, '1 TB Hard Disk Drive', 2500, 1),
	(2, 'Printer', 6500, 3),
	(3, '64 GB Pen Drive', 700, 6),
	(4, '6 GB Graphic Card', 12800, 5),
	(5, '22 Inches Monitor', 10600, 2),
	(6, '512 GB Solid State Drive', 4200, 1),
	(7, 'Mouse', 400, 6),
	(8, '450 Watt Power Supply Unit', 3600, 4),
	(9, 'Printer Cartridge', 2500, 3),
	(10, 'Membrane Keyboard', 900, 4),
	(11, 'Bluetooth Speakers', 2000, 10),
	(12, '42 Inches Television', 24600, 2),
	(13, 'CPU  Cabinet', 1900, 6),
	(14, 'Laptop Adjustable Stand', 1250, 7),
	(15, '8 GB RAM', 2600, 4),
	(16, 'Motherboard', 6500, 8),
	(17, 'Ergonomic Chair', 9700, 6),
	(18, 'Monitor Arm Stand', 2600, 7),
	(19, 'Wifi Adapter', 300, 9),
	(20, 'HD Webcam', 1000, 8);

select * from Manufacturers;
select * from Product_Inventory;

-- 1. Select the names of all the products in the inventory.
SELECT Product_Name FROM Product_Inventory;


-- 2. Select the names and the prices of all the products in the inventory.
SELECT Product_Name, Product_Price FROM Product_Inventory;


-- 3. Use an Alias "Name" and print all the product names
SELECT Product_Name AS Name FROM Product_Inventory;


-- 4. Select the name of the products with a price less than or equal to 8000 Indian Rupees.
SELECT Product_Name FROM Product_Inventory
WHERE Product_Price <= 8000;


-- 5. Select all the products with a price between 2000 and 10000 Indian Rupees.
SELECT * FROM Product_Inventory
WHERE Product_Price BETWEEN 2000 AND 10000;


-- 6. List the details of all such products whose manufacturer_code is 6.
SELECT * FROM Product_Inventory
WHERE Manufacturer_Code = 6;


-- 7. List the details of all such products whose manufacturer_code is 6 as well as their price is greater than 5000.
SELECT * FROM Product_Inventory
WHERE Manufacturer_Code = 6 AND Product_Price > 5000;


-- 8. List the details of all such products other than whose manufacturer_code is 6.
SELECT * FROM Product_Inventory
WHERE Manufacturer_Code <> 6;


-- 9. Select the name of the products whose name starts with 'M'.
SELECT Product_Name FROM Product_Inventory
WHERE Product_Name LIKE 'M%';


-- 10. List the name of products whose name starts with "M" and ends with "D".
SELECT Product_Name FROM Product_Inventory
WHERE Product_Name LIKE 'M%D';


-- 11. List the name of products which starts from "M" ends with "D" but also has ONLY 9 characters in between.
SELECT Product_Name FROM Product_Inventory
WHERE Product_Name LIKE 'M_________D';


-- 12. Concatenate name of the product with its price in a single column.
SELECT CONCAT(Product_Name, ' - ', Product_Price) AS Product_Details
FROM Product_Inventory;


-- 13. Select the name and price in dollars (i.e. the price must be divided by 80.)
SELECT Product_Name, (Product_Price / 80) AS Price_in_Dollars
FROM Product_Inventory;


-- 14. Compute the average price of all the products in Indian Rupees.
SELECT AVG(Product_Price) AS Avg_Price
FROM Product_Inventory;


-- 15. Compute the average price of all products with manufacturer code equal to 3.
SELECT AVG(Product_Price) AS Avg_Price
FROM Product_Inventory
WHERE Manufacturer_Code = 3;


-- 16. What is the total cost of products where manufacturer_code is 2?
SELECT SUM(Product_Price) AS Total_Cost
FROM Product_Inventory
WHERE Manufacturer_Code = 2;


-- 17. Compute the number of products with a price greater than or equal to 5000.
SELECT COUNT(*) AS Total_Products
FROM Product_Inventory
WHERE Product_Price >= 5000;


-- 18. Select the name and price of all products with a price >= 5000 and sort them
SELECT Product_Name, Product_Price
FROM Product_Inventory
WHERE Product_Price >= 5000
ORDER BY Product_Price DESC, Product_Name ASC;


-- 19. Select all the data from the inventory, including all the data for each product's manufacturer.
SELECT *
FROM Product_Inventory p
JOIN Manufacturers m
ON p.Manufacturer_Code = m.Manufacturer_Code;


-- 20. Select the product name, price, and manufacturer name of all the products.
SELECT p.Product_Name, p.Product_Price, m.Manufacturer_Name
FROM Product_Inventory p
JOIN Manufacturers m
ON p.Manufacturer_Code = m.Manufacturer_Code;


-- 21. Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT Manufacturer_Code, AVG(Product_Price) AS Avg_Price
FROM Product_Inventory
GROUP BY Manufacturer_Code;


-- 22. Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT m.Manufacturer_Name, AVG(p.Product_Price) AS Avg_Price
FROM Product_Inventory p
JOIN Manufacturers m
ON p.Manufacturer_Code = m.Manufacturer_Code
GROUP BY m.Manufacturer_Name;


-- 23. Select the names of manufacturer whose products have an average price >= 5000.
SELECT m.Manufacturer_Name
FROM Product_Inventory p
JOIN Manufacturers m
ON p.Manufacturer_Code = m.Manufacturer_Code
GROUP BY m.Manufacturer_Name
HAVING AVG(p.Product_Price) >= 5000;


-- 24. Select the name and price of the cheapest product.
SELECT Product_Name, Product_Price
FROM Product_Inventory
ORDER BY Product_Price ASC
LIMIT 1;


-- 25. Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT m.Manufacturer_Name, p.Product_Name, p.Product_Price
FROM Product_Inventory p
JOIN Manufacturers m
ON p.Manufacturer_Code = m.Manufacturer_Code
WHERE p.Product_Price = (
    SELECT MAX(Product_Price)
    FROM Product_Inventory
    WHERE Manufacturer_Code = p.Manufacturer_Code
);


-- 26. Add a new product: Speaker with price 1000 INR and manufacturer code 10.
INSERT INTO Product_Inventory (Product_Code, Product_Name, Product_Price, Manufacturer_Code)
VALUES (21, 'Speaker', 1000, 10);


-- 27. Update the name of the product "Speakers" to "Wired Speakers".
UPDATE Product_Inventory
SET Product_Name = 'Wired Speakers'
WHERE Product_Name = 'Speaker';


-- 28. Apply a 10% discount to all products.
UPDATE Product_Inventory
SET Product_Price = Product_Price * 0.9;


-- 29. Apply a 10% discount to all products with price >= 5000.
UPDATE Product_Inventory
SET Product_Price = Product_Price * 0.9
WHERE Product_Price >= 5000;


-- 30. List the name of the products along with their manufacturer name and price sorted by price.
SELECT p.Product_Name, m.Manufacturer_Name, p.Product_Price
FROM Product_Inventory p
JOIN Manufacturers m
ON p.Manufacturer_Code = m.Manufacturer_Code
ORDER BY p.Product_Price ASC;