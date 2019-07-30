USE production ;

-- Each product also belongs a category specified by the category_id column. Also, each category may have zero or many products.

-- https://tableplus.io/blog/2018/08/mysql-how-to-drop-constraint-in-mysql.html

-- Supp la FK (en vue de la recréer)
#ALTER TABLE products
#DROP fk_products_category;


ALTER TABLE products
ADD CONSTRAINT fk_products_categories
  FOREIGN KEY (category_id)
  REFERENCES categories (category_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;


-- Each product belongs to a brand specified by the brand_id column. Hence, a brand may have zero or many products.

#ALTER TABLE products
#DROP fk_products_brand;

ALTER TABLE products
ADD CONSTRAINT fk_products_brands
  FOREIGN KEY (brand_id)
  REFERENCES brands (brand_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;


#ALTER TABLE stocks
#DROP fk_products_stocks

ALTER TABLE stocks
ADD CONSTRAINT fk_stocks_product
  FOREIGN KEY (product_id)
  REFERENCES products (product_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;

ALTER TABLE stocks
ADD CONSTRAINT fk_stocks_stores
  FOREIGN KEY (store_id)
  REFERENCES stores(store_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;


-- Each staff belong to a store specified by store_id column
-- Each staff belong to a manager specified by manager_id column

ALTER TABLE staffs
ADD CONSTRAINT fk_staffs_stores
  FOREIGN KEY (store_id)
  REFERENCES stocks(store_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;

ALTER TABLE staffs
ADD CONSTRAINT fk_self_managers
  FOREIGN KEY (manager_id)
  REFERENCES staffs(staff_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;

-- Each stores belong to a 

ALTER TABLE stores
ADD FOREIGN KEY (store_id)
  REFERENCES stocks(store_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;


ALTER TABLE order_items
ADD FOREIGN KEY (product_id)
  REFERENCES stocks(product_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;

ALTER TABLE orders
ADD FOREIGN KEY (customer_id)
  REFERENCES customers(customer_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;

ALTER TABLE orders
ADD FOREIGN KEY (store_id)
  REFERENCES stores(store_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;

ALTER TABLE orders
ADD FOREIGN KEY (staff_id)
  REFERENCES staffs(staff_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;



