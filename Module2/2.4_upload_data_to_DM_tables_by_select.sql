


		/*location inserts*/

	  insert into retail_usa.location_dim (country_name, state, city, region, postal_code)	
	  select country, state, city, region, postal_code 
		from public.orders
	group by country, region, state, city, postal_code
	order by city;


		/*shipping  inserts*/
	 
	  insert into retail_usa.shipping_mode_dim (ship_mode)
	  select ship_mode 
		from orders 
	group by ship_mode 
	order by ship_mode 

	
		/*customer inserts*/
 
	  insert into retail_usa.customer_dim (customer_UID, customer_name, segment)
	  select customer_id, customer_name, segment 
	    from orders 
	group by customer_id, customer_name, segment 
	order by customer_name

	
		/*product inserts*/
	
	  insert into retail_usa.product_dim (product_UID, category, subcategory, product_name)
	  select product_id, category, subcategory, product_name 
	    from orders o 
	group by product_id, category, subcategory, product_name 
	order by product_id 

	
		/*order date inserts*/
	
	  insert into retail_usa.date_order_dim (order_date, "year", "quarter", "month", "week", "day")
	  select order_date, extract (YEAR FROM order_date), extract (QUARTER FROM order_date), extract (MONTH FROM order_date), extract ( WEEK FROM order_date), extract (day FROM order_date) 
	    from orders o 
	group by order_date, extract (YEAR FROM order_date), extract (QUARTER FROM order_date),	extract (MONTH FROM order_date), extract ( WEEK FROM order_date), extract (day FROM order_date) 
	order by order_date
	
	
		/*ship date inserts*/
	
	  insert into retail_usa.ship_date_dim (ship_date, "year", "quarter", "month", "week", "day")
	  select ship_date, extract (YEAR FROM ship_date), extract (QUARTER FROM ship_date), extract (MONTH FROM ship_date), extract ( WEEK FROM ship_date), extract (day FROM ship_date) 
	    from orders o 
	group by ship_date, extract (YEAR FROM ship_date), extract (QUARTER FROM ship_date), extract (MONTH FROM ship_date), extract ( WEEK FROM ship_date), extract (day FROM ship_date) 
	order by ship_date

	
		/*sales facts inserts */
 			
	  INSERT INTO retail_usa.sales_fact(order_uid, quantity, discount, profit, sales, customer_id, location_id, ship_id, date_id, product_id, ship_date_id)
	  select public.orders.order_id, 
			 public.orders.quantity, 
			 public.orders.discount, 
			 public.orders.profit, 
			 public.orders.sales,
			 retail_usa.customer_dim.customer_id,
			 retail_usa.location_dim.location_id,
			 retail_usa.shipping_mode_dim.ship_id,
			 retail_usa.date_order_dim.date_id,
			 retail_usa.product_dim.product_id,
			 retail_usa.ship_date_dim.ship_date_id
	    from public.orders
	   inner join retail_usa.customer_dim on public.orders.customer_id = retail_usa.customer_dim.customer_uid
	   inner join retail_usa.location_dim on public.orders.postal_code = retail_usa.location_dim.postal_code and public.orders.city = retail_usa.location_dim.city
	   inner join retail_usa.shipping_mode_dim on public.orders.ship_mode = retail_usa.shipping_mode_dim.ship_mode
	   inner join retail_usa.date_order_dim on public.orders.order_date = retail_usa.date_order_dim.order_date
	   inner join retail_usa.product_dim on public.orders.product_id = retail_usa.product_dim.product_uid and public.orders.product_name = retail_usa.product_dim.product_name 
	   inner join retail_usa.ship_date_dim on public.orders.ship_date = retail_usa.ship_date_dim.ship_date
	   ORDER BY public.orders.order_id

	   /*check insertion to sales fact table*/
	   
	   select * from retail_usa.sales_fact sf 
	   