SELECT TOP 10 * FROM clients WHERE Lastname = "Silva";

SELECT * FROM orders JOIN clients ON orders.idOrderClient = clients.idClient;

SELECT DISTINCT pname FROM products WHERE category = "eletrônicos";

SELECT idpayclient COUNT (*).AVG (payvalue) FROM paynments GROUP BY idpayclient WHERE payment.idpayclient = clients.idClient;

SELECT pname COUNT (*) FROM produts WHERE products.idprodut = productstorage.idproductstorage GROUP BY pname HAVING  productstorage.quantity (*) > 5 ORDER BY products.pname;