drop TABLE if exists retail_usa.sales_fact;
drop TABLE if exists retail_usa.shipping_dim;
drop TABLE if exists retail_usa.product_dim;
drop TABLE if exists retail_usa.location_dim;
drop TABLE if exists retail_usa.dates_dim;
drop TABLE if exists retail_usa.customer_dim;
drop schema if exists retail_usa;

create schema retail_usa authorization postgres;

-- ************************************** customer_dim

CREATE TABLE retail_usa.customer_dim
(
 customer_id   serial NOT NULL,
 customer_UID  varchar(10) NOT NULL,
 customer_name varchar(30) NOT NULL,
 segment       varchar(15) NOT NULL,
 CONSTRAINT PK_customer_dim PRIMARY KEY ( customer_id )
);

CREATE TABLE retail_usa.dates_dim
(
 date_id    serial NOT NULL,
 order_date date NOT NULL,
 ship_mode  date NOT NULL,
 year       int NOT NULL,
 quarter    int NOT NULL,
 month      int NOT NULL,
 week       int NOT NULL,
 day        int NOT NULL,
 CONSTRAINT PK_dates_dim PRIMARY KEY ( date_id )
);

-- ************************************** location_dim

CREATE TABLE retail_usa.location_dim
(
 location_id  serial NOT NULL,
 country_name varchar(20) NOT NULL,
 "state"        varchar(20) NOT NULL,
 city         varchar(25) NOT NULL,
 region       varchar(15) NOT NULL,
 postal_code  int NOT NULL,
 CONSTRAINT PK_geo_dim PRIMARY KEY ( location_id )
);

-- ************************************** product_dim

CREATE TABLE retail_usa.product_dim
(
 product_id   serial NOT NULL,
 product_UID  varchar(20) NOT NULL,
 category     varchar(25) NOT NULL,
 subcategory  varchar(15) NOT NULL,
 product_name varchar(150) NOT NULL,
 CONSTRAINT PK_product_dim PRIMARY KEY ( product_id )
);


-- ************************************** shipping_dim

CREATE TABLE retail_usa.shipping_dim
(
 ship_id   serial NOT NULL,
 ship_mode varchar(20) NOT NULL,
 CONSTRAINT PK_shipping_dim PRIMARY KEY ( ship_id )
);

-- ************************************** sales_fact

CREATE TABLE retail_usa.sales_fact
(
 order_id    serial NOT NULL,
 quantity    int NOT NULL,
 discount    numeric(4,2) NOT NULL,
 profit      numeric(21,16) NOT NULL,
 sales       numeric(9,4) NOT NULL,
 customer_id integer NOT NULL,
 location_id integer NOT NULL,
 ship_id     integer NOT NULL,
 date_id     integer NOT NULL,
 product_id  integer NOT NULL,
 CONSTRAINT PK_sales_fact PRIMARY KEY ( order_id ),
 CONSTRAINT FK_34 FOREIGN KEY ( customer_id ) REFERENCES retail_usa.customer_dim ( customer_id ),
 CONSTRAINT FK_70 FOREIGN KEY ( location_id ) REFERENCES retail_usa.location_dim ( location_id ),
 CONSTRAINT FK_73 FOREIGN KEY ( ship_id ) REFERENCES retail_usa.shipping_dim ( ship_id ),
 CONSTRAINT FK_76 FOREIGN KEY ( date_id ) REFERENCES retail_usa.dates_dim ( date_id ),
 CONSTRAINT FK_79 FOREIGN KEY ( product_id ) REFERENCES retail_usa.product_dim ( product_id )
);

CREATE INDEX fkIdx_35 ON retail_usa.sales_fact
(
 customer_id
);

CREATE INDEX fkIdx_71 ON retail_usa.sales_fact
(
 location_id
);

CREATE INDEX fkIdx_74 ON retail_usa.sales_fact
(
 ship_id
);

CREATE INDEX fkIdx_77 ON retail_usa.sales_fact
(
 date_id
);

CREATE INDEX fkIdx_80 ON retail_usa.sales_fact
(
 product_id
);


