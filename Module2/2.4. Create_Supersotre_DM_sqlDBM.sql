drop TABLE if exists retail_usa.sales_fact CASCADE;
drop TABLE if exists retail_usa.shipping_dim CASCADE;
drop TABLE if exists retail_usa.product_dim CASCADE;
drop TABLE if exists retail_usa.location_dim CASCADE;
drop TABLE if exists retail_usa.dates_dim CASCADE;
drop TABLE if exists retail_usa.customer_dim CASCADE;
drop schema if exists retail_usa;

create schema retail_usa authorization postgres;



-- ************************************** customer_dim

CREATE TABLE customer_dim
(
 customer_id   serial NOT NULL,
 customer_UID  varchar(10) NOT NULL,
 customer_name varchar(30) NOT NULL,
 segment       varchar(15) NOT NULL,
 CONSTRAINT PK_customer_dim PRIMARY KEY ( customer_id )
);

-- ************************************** date_order_dim

CREATE TABLE date_order_dim
(
 date_id    serial NOT NULL,
 order_date date NOT NULL,
 year       int NOT NULL,
 quarter    int NOT NULL,
 month      int NOT NULL,
 week       int NOT NULL,
 day        int NOT NULL,
 CONSTRAINT PK_dates_dim PRIMARY KEY ( date_id )
);

-- ************************************** ship_date_dim

CREATE TABLE ship_date_dim
(
 ship_date_id serial NOT NULL,
 ship_date    date NOT NULL,
 year         int NOT NULL,
 quarter      int NOT NULL,
 month        int NOT NULL,
 week         int NOT NULL,
 day          int NOT NULL,
 CONSTRAINT PK_ship_order_dim PRIMARY KEY ( ship_date_id )
);

-- ************************************** location_dim

CREATE TABLE location_dim
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

CREATE TABLE product_dim
(
 product_id   serial NOT NULL,
 product_UID  varchar(20) NOT NULL,
 category     varchar(25) NOT NULL,
 subcategory  varchar(15) NOT NULL,
 product_name varchar(150) NOT NULL,
 CONSTRAINT PK_product_dim PRIMARY KEY ( product_id )
);

-- ************************************** shipping_mode_dim

CREATE TABLE shipping_mode_dim
(
 ship_id   serial NOT NULL,
 ship_mode varchar(20) NOT NULL,
 CONSTRAINT PK_shipping_dim PRIMARY KEY ( ship_id )
);


-- ************************************** sales_fact

CREATE TABLE sales_fact
(
 order_id     serial NOT NULL,
 order_uid    varchar(50) NOT NULL,
 quantity     int NOT NULL,
 discount     numeric(4,2) NOT NULL,
 profit       numeric(21,16) NOT NULL,
 sales        numeric(9,4) NOT NULL,
 customer_id  integer NOT NULL,
 location_id  integer NOT NULL,
 ship_id      integer NOT NULL,
 date_id      integer NOT NULL,
 product_id   integer NOT NULL,
 ship_date_id integer NOT NULL,
 CONSTRAINT PK_sales_fact PRIMARY KEY ( order_id ),
 CONSTRAINT FK_34 FOREIGN KEY ( customer_id ) REFERENCES customer_dim ( customer_id ),
 CONSTRAINT FK_70 FOREIGN KEY ( location_id ) REFERENCES location_dim ( location_id ),
 CONSTRAINT FK_73 FOREIGN KEY ( ship_id ) REFERENCES shipping_mode_dim ( ship_id ),
 CONSTRAINT FK_76 FOREIGN KEY ( date_id ) REFERENCES date_order_dim ( date_id ),
 CONSTRAINT FK_79 FOREIGN KEY ( product_id ) REFERENCES product_dim ( product_id ),
 CONSTRAINT FK_95 FOREIGN KEY ( ship_date_id ) REFERENCES ship_date_dim ( ship_date_id )
);

CREATE INDEX fkIdx_35 ON sales_fact
(
 customer_id
);

CREATE INDEX fkIdx_71 ON sales_fact
(
 location_id
);

CREATE INDEX fkIdx_74 ON sales_fact
(
 ship_id
);

CREATE INDEX fkIdx_77 ON sales_fact
(
 date_id
);

CREATE INDEX fkIdx_80 ON sales_fact
(
 product_id
);

CREATE INDEX fkIdx_96 ON sales_fact
(
 ship_date_id
);



