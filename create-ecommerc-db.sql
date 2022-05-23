CREATE DATABASE IF NOT EXISTS ecommerce_db;

USE ecommerce_db;

/*
delete existing tables
*/

DROP TABLE IF EXISTS rating;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS supplier_pricing;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS customer;

/*
create tables
*/

CREATE TABLE supplier(
	supp_id INT,
	supp_name VARCHAR(50) NOT NULL,
	supp_city VARCHAR(50) NOT NULL,
	supp_phone VARCHAR(50) NOT NULL,
	PRIMARY KEY (supp_id)
);

CREATE TABLE customer(
	cus_id INT,
	cus_name VARCHAR(20) NOT NULL,
	cus_phone VARCHAR(10) NOT NULL,
	cus_city VARCHAR(30) NOT NULL,
	cus_gender CHAR,
	PRIMARY KEY (cus_id)
);

CREATE TABLE category(
	cat_id INT,
	cat_name VARCHAR(20) NOT NULL,
	PRIMARY KEY (cat_id)
);

CREATE TABLE product(
	pro_id INT,
	pro_name VARCHAR(20) NOT NULL DEFAULT "Dummy",
	pro_desc VARCHAR(60),
	cat_id INT NOT NULL,
	PRIMARY KEY (pro_id),
	FOREIGN KEY (cat_id) REFERENCES category(cat_id)
);

CREATE TABLE supplier_pricing(
	pricing_id INT,
	pro_id INT NOT NULL,
	supp_id INT NOT NULL,
	supp_price INT DEFAULT 0,
	PRIMARY KEY (pricing_id),
	FOREIGN KEY (pro_id) REFERENCES product(pro_id),
	FOREIGN KEY (supp_id) REFERENCES supplier(supp_id)
);


CREATE TABLE `order`(
	ord_id INT,
	ord_amount INT NOT NULL,
	ord_date DATE NOT NULL,
	cus_id INT NOT NULL,
	pricing_id INT NOT NULL,
	PRIMARY KEY (ord_id),
	FOREIGN KEY (cus_id) REFERENCES customer(cus_id),
	FOREIGN KEY (pricing_id) REFERENCES supplier_pricing(pricing_id)
);

CREATE TABLE rating(
	rat_id INT,
	ord_id INT NOT NULL,
	rat_ratstars INT NOT NULL,
	PRIMARY KEY (rat_id),
	FOREIGN KEY (ord_id) REFERENCES `order`(ord_id)
);

/*
insert data into tables
*/

INSERT INTO supplier VALUES(1,"Rajesh Retails","Delhi",'1234567890');
INSERT INTO supplier VALUES(2,"Appario Ltd.","Mumbai",'2589631470');
INSERT INTO supplier VALUES(3,"Knome products","Banglore",'9785462315');
INSERT INTO supplier VALUES(4,"Bansal Retails","Kochi",'8975463285');
INSERT INTO supplier VALUES(5,"Mittal Ltd.","Lucknow",'7898456532');
INSERT INTO customer VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO customer VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO customer VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO customer VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO customer VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');
INSERT INTO category VALUES( 1,"BOOKS");
INSERT INTO category VALUES(2,"GAMES");
INSERT INTO category VALUES(3,"GROCERIES");
INSERT INTO category VALUES (4,"ELECTRONICS");
INSERT INTO category VALUES(5,"CLOTHES");
INSERT INTO product VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
INSERT INTO product VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO product VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
INSERT INTO product VALUES(4,"OATS","Highly Nutritious from Nestle",3);
INSERT INTO product VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
INSERT INTO product VALUES(6,"MILK","1L Toned MIlk",3);
INSERT INTO product VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO product VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO product VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO product VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO product VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO product VALUES(12,"Train Your Brain","By Shireen Stephen",1);
INSERT INTO supplier_pricing VALUES(1,1,2,1500);
INSERT INTO supplier_pricing VALUES(2,3,5,30000);
INSERT INTO supplier_pricing VALUES(3,5,1,3000);
INSERT INTO supplier_pricing VALUES(4,2,3,2500);
INSERT INTO supplier_pricing VALUES(5,4,1,1000);
INSERT INTO supplier_pricing VALUES(6,12,2,780);
INSERT INTO supplier_pricing VALUES(7,12,4,789);
INSERT INTO supplier_pricing VALUES(8,3,1,31000);
INSERT INTO supplier_pricing VALUES(9,1,5,1450);
INSERT INTO supplier_pricing VALUES(10,4,2,999); 
INSERT INTO supplier_pricing VALUES(11,7,3,549);
INSERT INTO supplier_pricing VALUES(12,7,4,529);
INSERT INTO supplier_pricing VALUES(13,6,2,105);
INSERT INTO supplier_pricing VALUES(14,6,1,99);
INSERT INTO supplier_pricing VALUES(15,2,5,2999);
INSERT INTO supplier_pricing VALUES(16,5,2,2999);
INSERT INTO `order` VALUES (101,1500,"2021-10-06",2,1);
INSERT INTO `order` VALUES(102,1000,"2021-10-12",3,5);
INSERT INTO `order` VALUES(103,30000,"2021-09-16",5,2);
INSERT INTO `order` VALUES(104,1500,"2021-10-05",1,1);
INSERT INTO `order` VALUES(105,3000,"2021-08-16",4,3);
INSERT INTO `order` VALUES(106,1450,"2021-08-18",1,9);
INSERT INTO `order` VALUES(107,789,"2021-09-01",3,7);
INSERT INTO `order` VALUES(108,780,"2021-09-07",5,6);
INSERT INTO `order` VALUES(109,3000,"2021-0-10",5,3);
INSERT INTO `order` VALUES(110,2500,"2021-09-10",2,4);
INSERT INTO `order` VALUES(111,1000,"2021-09-15",4,5);
INSERT INTO `order` VALUES(112,789,"2021-09-16",4,7);
INSERT INTO `order` VALUES(113,31000,"2021-09-16",1,8);
INSERT INTO `order` VALUES(114,1000,"2021-09-16",3,5);
INSERT INTO `order` VALUES(115,3000,"2021-09-16",5,3);
INSERT INTO `order` VALUES(116,99,"2021-09-17",2,14);
INSERT INTO rating VALUES(1,101,4);
INSERT INTO rating VALUES(2,102,3);
INSERT INTO rating VALUES(3,103,1);
INSERT INTO rating VALUES(4,104,2);
INSERT INTO rating VALUES(5,105,4);
INSERT INTO rating VALUES(6,106,3);
INSERT INTO rating VALUES(7,107,4);
INSERT INTO rating VALUES(8,108,4);
INSERT INTO rating VALUES(9,109,3);
INSERT INTO rating VALUES(10,110,5);
INSERT INTO rating VALUES(11,111,3);
INSERT INTO rating VALUES(12,112,4);
INSERT INTO rating VALUES(13,113,2);
INSERT INTO rating VALUES(14,114,1);
INSERT INTO rating VALUES(15,115,1);
INSERT INTO rating VALUES(16,116,0);