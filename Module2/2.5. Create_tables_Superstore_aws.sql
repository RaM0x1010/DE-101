/*create schemes and tables for staging and data warehouse mode in data warehouse storage*/
	
	drop schema if exists stg;
	drop schema if exists dwh;

	create schema stg authorization postgres;
	create schema dwh authorization postgres;

	drop table if exists stg.orders CASCADE;
	drop table if exists stg.people CASCADE;
	drop table if exists stg.returns CASCADE;

	drop TABLE if exists dwh.sales_fact CASCADE;
	drop TABLE if exists dwh.shipping_dim CASCADE;
	drop TABLE if exists dwh.product_dim CASCADE;
	drop TABLE if exists dwh.location_dim CASCADE;
	drop TABLE if exists dwh.dates_dim CASCADE;
	drop TABLE if exists dwh.customer_dim CASCADE;


	/*Staging tables*/

	CREATE TABLE stg.orders(
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
	
	CREATE TABLE stg.people(
	  person VARCHAR(30) NOT NULL PRIMARY KEY,
	  region VARCHAR(10) NOT NULL
	);
	
	CREATE TABLE stg.returns(
	   returned   VARCHAR(7) NOT NULL,
	   order_id   VARCHAR(25) NOT NULL
	);


	/*data warehouse tables*/

	CREATE TABLE dwh.customer_dim
	(
	 customer_id   serial NOT NULL,
	 customer_UID  varchar(10) NOT NULL,
	 customer_name varchar(30) NOT NULL,
	 segment       varchar(15) NOT NULL,
	 CONSTRAINT PK_customer_dim PRIMARY KEY ( customer_id )
	);
	
	-- ************************************** date_order_dim
	
	CREATE TABLE dwh.date_order_dim
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
	
	CREATE TABLE dwh.ship_date_dim
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
	
	CREATE TABLE dwh.location_dim
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
	
	CREATE TABLE dwh.product_dim
	(
	 product_id   serial NOT NULL,
	 product_UID  varchar(20) NOT NULL,
	 category     varchar(25) NOT NULL,
	 subcategory  varchar(15) NOT NULL,
	 product_name varchar(150) NOT NULL,
	 CONSTRAINT PK_product_dim PRIMARY KEY ( product_id )
	);
	
	-- ************************************** shipping_mode_dim
	
	CREATE TABLE dwh.shipping_mode_dim
	(
	 ship_id   serial NOT NULL,
	 ship_mode varchar(20) NOT NULL,
	 CONSTRAINT PK_shipping_dim PRIMARY KEY ( ship_id )
	);
	
	
	-- ************************************** sales_fact
	
	CREATE TABLE dwh.sales_fact
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
	 CONSTRAINT FK_34 FOREIGN KEY ( customer_id ) REFERENCES dwh.customer_dim ( customer_id ),
	 CONSTRAINT FK_70 FOREIGN KEY ( location_id ) REFERENCES dwh.location_dim ( location_id ),
	 CONSTRAINT FK_73 FOREIGN KEY ( ship_id ) REFERENCES dwh.shipping_mode_dim ( ship_id ),
	 CONSTRAINT FK_76 FOREIGN KEY ( date_id ) REFERENCES dwh.date_order_dim ( date_id ),
	 CONSTRAINT FK_79 FOREIGN KEY ( product_id ) REFERENCES dwh.product_dim ( product_id ),
	 CONSTRAINT FK_95 FOREIGN KEY ( ship_date_id ) REFERENCES dwh.ship_date_dim ( ship_date_id )
	);
	
	CREATE INDEX fkIdx_35 ON dwh.sales_fact
	(
	 customer_id
	);
	
	CREATE INDEX fkIdx_71 ON dwh.sales_fact
	(
	 location_id
	);
	
	CREATE INDEX fkIdx_74 ON dwh.sales_fact
	(
	 ship_id
	);
	
	CREATE INDEX fkIdx_77 ON dwh.sales_fact
	(
	 date_id
	);
	
	CREATE INDEX fkIdx_80 ON dwh.sales_fact
	(
	 product_id
	);
	
	CREATE INDEX fkIdx_96 ON dwh.sales_fact
	(
	 ship_date_id
	);


/*create */