DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
   row_id        INTEGER  NOT NULL PRIMARY KEY,
   order_id      VARCHAR(20) NOT NULL,
   order_date    DATE  NOT NULL,
   ship_date     DATE  NOT NULL,
   ship_mode     VARCHAR(20) NOT NULL,
   customer_id   VARCHAR(10) NOT NULL,
   customer_name VARCHAR(30) NOT NULL,
   segment       VARCHAR(15) NOT NULL,
   country       VARCHAR(20) NOT NULL,
   city          VARCHAR(25) NOT NULL,
   state         VARCHAR(20) NOT NULL,
   postal_code   INTEGER,
   region        VARCHAR(15) NOT NULL,
   product_id    VARCHAR(30) NOT NULL,
   category      VARCHAR(25) NOT NULL,
   subcategory   VARCHAR(15) NOT NULL,
   product_name  VARCHAR(150) NOT NULL,
   sales         NUMERIC(9,4) NOT NULL,
   quantity      INTEGER  NOT NULL,
   discount      NUMERIC(4,2) NOT NULL,
   profit        NUMERIC(21,16) NOT NULL
);
set datestyle to 'ISO, MDY';