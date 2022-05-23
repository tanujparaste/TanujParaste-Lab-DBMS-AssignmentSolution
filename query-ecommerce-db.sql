/* 
3) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.
*/
SELECT cus_gender, COUNT(cus_gender) total_number
FROM customer
WHERE cus_id IN (SELECT DISTINCT cus_id FROM `order` WHERE ord_amount >= 3000)
GROUP BY cus_gender;
    
/*
4) Display all the orders along with product name ordered by a customer having Customer_Id=2
*/
SELECT o.*, p.pro_name
FROM customer c
JOIN `order` o
ON c.cus_id = o.cus_id
JOIN supplier_pricing sp
ON sp.pricing_id = o.pricing_id
JOIN product p
ON p.pro_id = sp.pro_id
WHERE c.cus_id = 2;

/*
5) Display the Supplier details who can supply more than one product.
*/
SELECT * 
FROM supplier 
WHERE supp_id IN (SELECT supp_id
FROM supplier_pricing
GROUP BY supp_id
HAVING COUNT(supp_id) > 1);

/*
6) Find the least expensive product from each category and print the table with category id, name, product name and price of the product
*/
SELECT c.cat_id, c.cat_name, p.pro_name, MIN(sp.supp_price) price
FROM supplier_pricing sp
JOIN product p
ON p.pro_id = sp.pro_id
JOIN category c
ON c.cat_id = p.cat_id
GROUP BY c.cat_id;

/*
7) Display the Id and Name of the Product ordered after “2021-10-05”.
*/
SELECT pro_id, pro_name
FROM product
WHERE pro_id IN (SELECT pro_id
FROM supplier_pricing
WHERE pricing_id IN (SELECT pricing_id
FROM `order` 
WHERE ord_date > '2021-10-05'));

/*
8) Display customer name and gender whose names start or end with character 'A'.
*/
SELECT cus_name, cus_gender
FROM customer
WHERE cus_name LIKE 'A%' OR cus_name LIKE '%A';

/*
9) Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent
Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
*/

DELIMITER //
DROP PROCEDURE IF EXISTS getSupplierServiceQuality;
CREATE PROCEDURE getSupplierServiceQuality()
BEGIN
SELECT s.supp_id, s.supp_name, r.rat_ratstars,
CASE
	WHEN r.rat_ratstars = 5 THEN "Excellent Service"
    WHEN r.rat_ratstars > 4 THEN "Good Service"
    WHEN r.rat_ratstars > 2 THEN "Average Service"
    ELSE "Poor Service"
END AS Type_of_Service
FROM supplier s
JOIN supplier_pricing sp
ON s.supp_id = sp.supp_id
JOIN `order` o
ON o.pricing_id = sp.pricing_id
JOIN rating r
ON r.ord_id = o.ord_id;
END//
DELIMITER ;

CALL getSupplierServiceQuality();