


		/*location inserts*/

	  insert into dwh.location_dim (country_name, state, city, region, postal_code)	
	  select country, state, city, region, postal_code 
		from stg.orders
	group by country, region, state, city, postal_code
	order by city;


		/*shipping  inserts*/
	 
	  insert into dwh.shipping_mode_dim (ship_mode)
	  select ship_mode 
		from stg.orders 
	group by ship_mode 
	order by ship_mode;

	
		/*customer inserts*/
 
	  insert into dwh.customer_dim (customer_UID, customer_name, segment)
	  select customer_id, customer_name, segment 
	    from stg.orders 
	group by customer_id, customer_name, segment 
	order by customer_name;

	
		/*product inserts*/
	
	  insert into dwh.product_dim (product_UID, category, subcategory, product_name)
	  select product_id, category, subcategory, product_name 
	    from stg.orders
	group by product_id, category, subcategory, product_name 
	order by product_id;

	
		/*order date inserts*/
	
	  insert into dwh.date_order_dim (order_date, "year", "quarter", "month", "week", "day")
	  select order_date, extract (YEAR FROM order_date), extract (QUARTER FROM order_date), extract (MONTH FROM order_date), extract ( WEEK FROM order_date), extract (day FROM order_date) 
	    from stg.orders
	group by order_date, extract (YEAR FROM order_date), extract (QUARTER FROM order_date),	extract (MONTH FROM order_date), extract ( WEEK FROM order_date), extract (day FROM order_date) 
	order by order_date;
	
	
		/*ship date inserts*/
	
	  insert into dwh.ship_date_dim (ship_date, "year", "quarter", "month", "week", "day")
	  select ship_date, extract (YEAR FROM ship_date), extract (QUARTER FROM ship_date), extract (MONTH FROM ship_date), extract ( WEEK FROM ship_date), extract (day FROM ship_date) 
	    from stg.orders
	group by ship_date, extract (YEAR FROM ship_date), extract (QUARTER FROM ship_date), extract (MONTH FROM ship_date), extract ( WEEK FROM ship_date), extract (day FROM ship_date) 
	order by ship_date;

	
		/*sales facts inserts */
 			
	  INSERT INTO dwh.sales_fact(order_uid, quantity, discount, profit, sales, customer_id, location_id, ship_id, date_id, product_id, ship_date_id)
	  select stg.orders.order_id, 
			 stg.orders.quantity, 
			 stg.orders.discount, 
			 stg.orders.profit, 
			 stg.orders.sales,
			 dwh.customer_dim.customer_id,
			 dwh.location_dim.location_id,
			 dwh.shipping_mode_dim.ship_id,
			 dwh.date_order_dim.date_id,
			 dwh.product_dim.product_id,
			 dwh.ship_date_dim.ship_date_id
	    from stg.orders
	   inner join dwh.customer_dim on stg.orders.customer_id = dwh.customer_dim.customer_uid
	   inner join dwh.location_dim on stg.orders.postal_code = dwh.location_dim.postal_code and stg.orders.city = dwh.location_dim.city
	   inner join dwh.shipping_mode_dim on stg.orders.ship_mode = dwh.shipping_mode_dim.ship_mode
	   inner join dwh.date_order_dim on stg.orders.order_date = dwh.date_order_dim.order_date
	   inner join dwh.product_dim on stg.orders.product_id = dwh.product_dim.product_uid and stg.orders.product_name = dwh.product_dim.product_name 
	   inner join dwh.ship_date_dim on stg.orders.ship_date = dwh.ship_date_dim.ship_date
	   ORDER BY stg.orders.order_id;

	   /*check insertion to sales fact table*/
	   
	   select * from dwh.sales_fact sf 
	   