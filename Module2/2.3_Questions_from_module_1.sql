select * from orders o limit 10
select count(*) from orders o 

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
/*Customer Ranking*/
     
/*Sales per region*/
     
     
     SELECT 	
	EXTRACT(YEAR FROM order_date) as sale_month
	,EXTRACT(MONTH FROM order_date) as sale_month
	,category
	,round(SUM(sales), 2) AS sales
FROM orders
group by 1,2,3
order by 1,2
	