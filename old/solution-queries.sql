-- 1) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000

SELECT cus_gender, COUNT(cus_gender) total_number FROM (SELECT
c.cus_gender
FROM
customer c
INNER JOIN
`order` o
ON c.cus_id = o.cus_id
WHERE o.ord_amount >= 3000
GROUP BY c.cus_id
) AS p
GROUP BY cus_gender;

-- using subqueries
SELECT 
	cus_gender,
    COUNT(cus_gender) total_number
FROM customer
WHERE cus_id IN (SELECT 
	DISTINCT cus_id 
FROM `order` 
WHERE ord_amount >= 3000)
GROUP BY cus_gender;

-- 2) Display all the orders along with product name ordered by a customer having Customer_Id=2
SELECT
ORD.*, PRO.PRO_NAME
FROM `ORDER` ORD
JOIN SUPPLIER_PRICING SUPP
ON SUPP.PRICING_ID = ORD.PRICING_ID
JOIN PRODUCT PRO
ON PRO.PRO_ID = SUPP.PRO_ID
WHERE ORD.CUS_ID = 2;

-- 3) Display the Supplier details who can supply more than one product.
SELECT * FROM SUPPLIER WHERE SUPP_ID IN (SELECT SUPP_ID FROM SUPPLIER_PRICING GROUP BY SUPP_ID HAVING COUNT(PRO_ID) > 1);

-- 4) Find the least expensive product from each category and print the table with category id, name, product name and price of the product
SELECT
C.CAT_ID,
C.CAT_NAME,
P.PRO_NAME,
MIN(SP.SUPP_PRICE) PRICE
FROM SUPPLIER_PRICING SP
JOIN PRODUCT P
ON SP.PRO_ID = P.PRO_ID
JOIN CATEGORY C
ON C.CAT_ID = P.CAT_ID
GROUP BY C.CAT_ID;


-- 5) Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT
P.PRO_ID,
O.ORD_DATE
FROM `ORDER` O
JOIN SUPPLIER_PRICING SP
ON O.PRICING_ID = SP.PRICING_ID
JOIN PRODUCT P
ON P.PRO_ID = SP.PRO_ID
WHERE O.ORD_DATE > '2021-10-05';

-- 6) Display customer name and gender whose names start or end with character 'A'
SELECT 
CUS_NAME,
CUS_GENDER
FROM CUSTOMER
WHERE CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';

-- 7) Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”

DELIMITER //

CREATE PROCEDURE displaySupplierRatings()
BEGIN
	SELECT
	S.SUPP_ID,
	S.SUPP_NAME,
	RAT_RATSTARS,
	CASE
	WHEN RAT_RATSTARS = 5 THEN "Excellent Service"
	WHEN RAT_RATSTARS > 4 AND RAT_RATSTARS < 5 THEN "Good Service"
	WHEN RAT_RATSTARS > 2 AND RAT_RATSTARS <=4 THEN "Average Service"
	ELSE "Poor Service"
	END AS TYPE_OF_SERVICE
	FROM SUPPLIER S
	JOIN SUPPLIER_PRICING SP
	ON S.SUPP_ID = SP.SUPP_ID
	JOIN `ORDER` O
	ON O.PRICING_ID = SP.PRICING_ID
	JOIN RATING R
	ON R.ORD_ID = O.ORD_ID;
END //
DELIMITER ;

CALL displaySupplierRatings();