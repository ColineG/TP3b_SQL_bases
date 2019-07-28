
-- Désactiver temporairement les contraintes pr éviter les pb
SET FOREIGN_KEY_CHECKS = 0 ;
-- https://stackoverflow.com/questions/1905470/cannot-delete-or-update-a-parent-row-a-foreign-key-constraint-fails

-- CREATE SCHEMA

DROP SCHEMA IF EXISTS production ;
CREATE SCHEMA production ;
USE production ;


-- CREATE TABLES

-- The categories table stores the bike’s categories such as children bicycles, comfort bicycles, and electric bikes.

CREATE TABLE categories (
	category_id INT AUTO_INCREMENT  PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

-- The brands table stores the brand’s information of bikes (caaracteristiques, particularités des vélos), for example, Electra, Haro, and Heller

CREATE TABLE brands (
	brand_id INT AUTO_INCREMENT  PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

-- The products table stores the product’s information such as name, brand, category, model year, and list price.
-- Each product belongs to a brand specified by the brand_id column. Hence, a brand may have zero or many products.
-- Each product also belongs a category specified by the category_id column. Also, each category may have zero or many products.

CREATE TABLE products (
	product_id INT AUTO_INCREMENT  PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL
-- 	FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
-- 	FOREIGN KEY (brand_id) REFERENCES brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- The production.stocks table stores the inventory information i.e. the quantity of a particular product in a specific store.
-- Each stocks belong to a store specified by the store_id. Hence a store may have zero or many product in stock
-- Each stocks contains product specified by product_id. Each stock may have zero or many product

CREATE TABLE stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id)
-- 	FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE
-- 	FOREIGN KEY (store_id) REFERENCES sales.stores(store_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

-- The staffs table store the staff's informations such as name, email, phone, activity (0 actif, 1 inactif), store_id where they work and manager_id
-- Each staffs belong to one store specified by stocks(store_id). Each staffs may have one or many store

CREATE TABLE staffs (
	staff_id INT AUTO_INCREMENT  PRIMARY KEY NOT NULL,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (50) NOT NULL,
	phone VARCHAR(15) NOT NULL,
	active ENUM('0','1'), 
	store_id INT NOT NULL,
	manager_id INT 
--  FOREIGN KEY (store_id) REFERENCES stocks(store_id)
--  FOREIGN KEY (manager_id) REFERENCES managers(manager_id)
);

-- The stores table store the store's informations such as name, email, phone, adress

CREATE TABLE stores (
	store_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	store_name VARCHAR (50) NOT NULL,
	phone VARCHAR(15) NOT NULL,
	email VARCHAR (50) NOT NULL,
	street VARCHAR (50) NOT NULL,
	city VARCHAR (50) NOT NULL,
	state VARCHAR (50) NOT NULL,
	zip_code VARCHAR(15) NOT NULL
--  FOREIGN KEY(store_id) REFERENCES stocks(store_id)
);

-- create table order_items

CREATE TABLE order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price INT NOT NULL,
	discount DECIMAL(4,2) DEfAULT '0' NOT NULL ,
	PRIMARY KEY (order_id, item_id)
--  FOREIGN KEY(product_id) REFERENCES stocks(product_id)
);

-- create table customers 

CREATE TABLE customers(
	customer_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	phone VARCHAR(15),
	email VARCHAR (50) NOT NULL,
	street VARCHAR (50) NOT NULL,
	city VARCHAR (50) NOT NULL,
	state VARCHAR (50) NOT NULL,
	zip_code VARCHAR(15) NOT NULL
);

-- create table orders 

CREATE TABLE orders (
	order_id INT,
	customer_id INT NOT NULL, 
	order_status ENUM('Commande en cours', 'Commande dans panier', 'Commande en préparation', 'Commande terminé') NOT NULL,
	order_date DATETIME DEFAULT NOW() NOT NULL,
	required_date DATETIME NOT NULL,
	shipped_date DATETIME,
	store_id INT NOT NULL,
	staff_id INT NOT NULL
--	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
--	FOREIGN KEY (store_id) REFERENCES stores(store_id),
--	FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);

-- The manager table store all manager's informations such as name, address, 

CREATE TABLE managers (
	manager_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (50) NOT NULL,
	phone VARCHAR(15) NOT NULL,
	activity ENUM('0','1'), 
	store_id INT NOT NULL
--  FOREIGN KEY(store_id) REFERENCES stocks(store_id)
);


