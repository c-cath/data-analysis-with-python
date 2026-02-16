CREATE TABLE IF NOT EXISTS online_retail (
	InvoiceNo VARCHAR(30), 
	CustomerName VARCHAR(30), 
	ProductCategory VARCHAR(30), 
	OrderDate DATE,
    ShippingDate DATE, 
	Price NUMERIC(10,2), 
	Quantity INT, 
	Country VARCHAR(30), 
	TotalAmount NUMERIC(10,2)
);

SELECT * FROM online_retail;

SELECT COUNT(*) FROM online_retail; 
