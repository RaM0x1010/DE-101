/*Total sales*/
		select count(distinct sales) 
		  from orders o 

/*Total profit*/
		select sum(profit)
		  from orders o

/*Profit Ratio*/
		select (sum(profit)/sum(sales))*100 
		  from orders 

/*Profit per order*/
        select order_id, sum(profit) as "Profit per Order"
        from orders o 
    group by order_id 
    order by order_id asc;

/*Sales per Customer*/
        select customer_name, sum(sales) as "Sales per Customer"
          from orders
      group by customer_name
      order by sum(sales) desc;
               
/*Avg. Discount*/
        select round(AVG(discount) * 100, 2) as "Avg. Discount"
          from orders;

/*Monthly Sales by Segment*/
        select date_part('month', order_date) as "Month", segment, sum(sales)
          from orders
      group by date_part('month', order_date), segment
      order by date_part('month', order_date) desc;

/*Monthly Sales by Product Category*/
		select date_part('month', order_date) as "Month", category, sum(sales)
          from orders
      group by date_part('month', order_date), category
      order by date_part('month', order_date) desc;

/*Sales and Profit by Customer*/
		select customer_name as "Good booy!", sum(sales) as "Sales", sum(profit) as "Profit"
		  from orders
	  group by customer_name
	  order by customer_name;
/*Customer Ranking. Top 10*/
     select customer_name as "Top customers", sum(profit) as "Total profit"
       from orders o 
   group by customer_name
   order by sum(profit) desc
   limit 10;
	 
/*Sales per region*/
     select region as "Region", sum(sales)
       from orders
   group by region 
   order by sum(sales) desc;

	