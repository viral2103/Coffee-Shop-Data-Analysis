use project;

-- 1. Select all records from the coffeeshop table
select * from coffeeshop;

-- 2. Select distinct coffee names and their corresponding prices
select distinct coffee_name,money from coffeeshop;

-- 3. Rename column 'money' to 'price' and set data type as INTEGER
alter table coffeeshop change column money price int;

-- 4. Rename column 'cash_type' to 'payment_method' with a VARCHAR(30) data type
alter table coffeeshop change column cash_type payment_method varchar(30);

-- 5. Add a new column 'month' to store the month name
alter table coffeeshop add column month varchar(20);

-- 6. Populate 'month' column with the month name extracted from the 'date' column
UPDATE coffeeshop 
SET month = DATE_FORMAT(date, '%M');

-- 7. Count the total number of coffee sales
select count(coffee_name) as TotalCoffee from coffeeshop;

-- 8. List all unique coffee names
select distinct coffee_name from coffeeshop;

-- 9. List all unique coffee names along with their prices
select distinct coffee_name,price from coffeeshop;

-- 10. Find the top 3 most expensive coffees
select coffee_name,max(price) as MaxPrice from coffeeshop group by coffee_name order by MaxPrice desc limit 3;

-- 11. Find the top 3 cheapest coffees
select coffee_name,min(price) as MinPrice from coffeeshop group by coffee_name order by MinPrice asc limit 3;


-- 12. Find total sales per coffee type and order them from highest to lowest
select coffee_name,sum(price) as HighestSellingCoffee from coffeeshop group by coffee_name order by HighestSellingCoffee desc;

-- 13. Find the top 3 highest-selling coffee types
select coffee_name,sum(price) as HighestSellingCoffee from coffeeshop group by coffee_name order by HighestSellingCoffee desc limit 3;

-- 14. Find total sales per coffee type and order them from lowest to highest
select coffee_name,sum(price) as LowestSellingCoffee from coffeeshop group by coffee_name order by LowestSellingCoffee asc;

-- 15. Find the top 3 lowest-selling coffee types
select coffee_name,sum(price) as LowestSellingCoffee from coffeeshop group by coffee_name order by LowestSellingCoffee asc limit 3;

-- 16. Rank coffee prices using dense rank
select distinct coffee_name,price,dense_rank() over(order by price desc) as CoffeePriceRank from coffeeshop;

-- 17. Rank coffee sales revenue
select distinct coffee_name,sum(price) as CoffeePrice, dense_rank() over(order by sum(price) desc) as Pricerank from coffeeshop group by coffee_name;

-- 18. Calculate total and average coffee sales
select sum(price)as CoffeePrice,avg(price) as AvgCoffee from coffeeshop;

-- 19. Count occurrences of each payment method
select payment_method,count(payment_method) as paymenttype from coffeeshop group by payment_method; -- these query use for row wise count payment type

-- 20. Count payments made via card and cash separately
select 
	count(case when payment_method="card" then 1 end) as Card,
    count(case when payment_method="cash" then 1 end) as Cash   -- these query give me different cashtype  columns with count his different payment type
from coffeeshop;

-- 21. Calculate total sales amount per payment method
select payment_method,sum(price) as TotalPrice from coffeeshop group by payment_method;

-- 22. Get total revenue per month, ordered by month
select monthname(date) as Month,sum(price) as TotalPrice from coffeeshop group by monthname(date),month(date) order by month(date);

-- 23. Get distinct months from sales data
select distinct month from coffeeshop;

-- 24. Count unique card users
select count(distinct card) as total from coffeeshop;

-- 25. Count repeated orders per card
select distinct card,count(card) as RepeatOrder from coffeeshop group by card;

-- 26. Count repeated orders per card, ordered from highest to lowest
select distinct card,count(card) as RepeatOrder from coffeeshop group by card order by RepeatOrder desc;

-- 27. Rank customers based on order frequency
select card,count(card) as TotalRepeatOrder,dense_rank() over(order by count(card) desc) as CardRanking from coffeeshop group by card;

-- 28. Find the total amount spent per customer
select card,sum(price) as TotalAmount from coffeeshop group by card order by TotalAmount desc;

-- 29. Find the total amount spent by each customer per coffee type
select card,coffee_name,sum(price) as TotalAmount from coffeeshop group by card,coffee_name order by card asc;

-- 30. Find the total amount spent by each customer per coffee type in descending order
select card,coffee_name,sum(price) as TotalAmount from coffeeshop group by card,coffee_name order by card desc;

-- 31. Find customers who have ordered the same coffee more than once
SELECT card, coffee_name, COUNT(*) AS RepeatOrder
FROM coffeeshop
GROUP BY card, coffee_name
HAVING COUNT(*) > 1;

-- 32. Find the top 10 customers who bought the most coffee
select distinct card,count(coffee_name) as TotalCoffee,dense_rank() over(order by count(coffee_name) desc) as TopBuyerCoffee from coffeeshop group by card limit 10;

-- 33. Find the customers who bought the least amount of coffee
select distinct card,count(coffee_name) as TotalCoffee,dense_rank() over(order by count(coffee_name) asc) as LeastBuyerCoffee from coffeeshop group by card;

-- 34. Find total revenue per month and coffee type
select monthname(date) as Month,coffee_name,sum(price) as TotalSellingCoffee from coffeeshop group by coffee_name,monthname(date),Month(date) order by Month(date);

-- 35. Calculate the total revenue from coffee sales
select sum(price) as TotalAmountSellingCoffee from coffeeshop;

-- 36. Find the monthly average coffee sales revenue
select Month,sum(price) As AvgSellingCoffee from coffeeshop group by Month order by AvgSellingCoffee desc;

-- Find total selling coffee diferent - different month and coffee name wise
select monthname(date) as Month,coffee_name,sum(price) as TotalSellingCoffee  from coffeeshop group by coffee_name,monthname(date),Month(date) order by Month(date);

-- 37. Find customers who have placed repeat orders
select card,count(card) as ReturnOrder from coffeeshop  group by card having count(card) > 1; 


-- 38. Count orders made in each month for each customer
SELECT 
    card,
    COUNT(DISTINCT CASE WHEN month = 'January' THEN datetime END) AS January,
    COUNT(DISTINCT CASE WHEN month = 'February' THEN datetime END) AS February,
    COUNT(DISTINCT CASE WHEN month = 'March' THEN datetime END) AS March,
    COUNT(DISTINCT CASE WHEN month = 'April' THEN datetime END) AS April,
    COUNT(DISTINCT CASE WHEN month = 'May' THEN datetime END) AS May,
    COUNT(DISTINCT CASE WHEN month = 'June' THEN datetime END) AS June,
    COUNT(DISTINCT CASE WHEN month = 'July' THEN datetime END) AS July,
    COUNT(DISTINCT CASE WHEN month = 'August' THEN datetime END) AS August,
    COUNT(DISTINCT CASE WHEN month = 'September' THEN datetime END) AS September,
    COUNT(DISTINCT CASE WHEN month = 'October' THEN datetime END) AS October,
    COUNT(DISTINCT CASE WHEN month = 'November' THEN datetime END) AS November,
    COUNT(DISTINCT CASE WHEN month = 'December' THEN datetime END) AS December
FROM coffeeshop
GROUP BY card;  -- Ensures only cardholders with multiple purchases appear


SELECT 
    card,
    COUNT(DISTINCT CASE WHEN month = 'January' THEN datetime END) AS January,
    COUNT(DISTINCT CASE WHEN month = 'February' THEN datetime END) AS February,
    COUNT(DISTINCT CASE WHEN month = 'March' THEN datetime END) AS March,
    COUNT(DISTINCT CASE WHEN month = 'April' THEN datetime END) AS April,
    COUNT(DISTINCT CASE WHEN month = 'May' THEN datetime END) AS May,
    COUNT(DISTINCT CASE WHEN month = 'June' THEN datetime END) AS June,
    COUNT(DISTINCT CASE WHEN month = 'July' THEN datetime END) AS July,
    COUNT(DISTINCT CASE WHEN month = 'August' THEN datetime END) AS August,
    COUNT(DISTINCT CASE WHEN month = 'September' THEN datetime END) AS September,
    COUNT(DISTINCT CASE WHEN month = 'October' THEN datetime END) AS October,
    COUNT(DISTINCT CASE WHEN month = 'November' THEN datetime END) AS November,
    COUNT(DISTINCT CASE WHEN month = 'December' THEN datetime END) AS December,
    SUM(price) AS TotalAmount
FROM coffeeshop
GROUP BY card
HAVING COUNT(DISTINCT month) > 1;  -- Ensures the cardholder has purchased in more than one month

-- 39. Calculate daily total revenue
select date,sum(price) as TotalAmtSellingCoffeeDayWise from coffeeshop group by date order by date asc;

-- 40. Calculate daily average sales
select date,sum(price) as AvgSellingCoffeeDayWise from coffeeshop group by date order by date asc; -- These query should check avg is not propar so verify all avg query.

-- 41. Count the total number of coffee sales per day
select date,count(price) as TotalSellingCoffee from coffeeshop group by date;

-- 42. Rank daily coffee sales
select date,count(price) as TotalSellingCoffe,dense_rank() over(order by count(price) desc) as CoffeeSellingRank from coffeeshop group by date;

-- 43. Rank daily and card wise coffee salling
select date,card,count(price) as TotalSellingCoffee,dense_rank() over(order by count(price) desc) as CoffeesellingRank from coffeeshop group by date,card;

select monthname(date) as Month,sum(price) as TotalPrice from coffeeshop group by monthname(date),month(date) order by month(date);

select monthname(date) as month,count(card) as TotalCoffee from coffeeshop group by monthname(date),month(date) order by month(date);

SELECT 
    DATE_FORMAT(date, '%Y-%m-01') + INTERVAL (FLOOR(DAY(date)/15) * 15) DAY AS period_start,
    SUM(price) AS total_sales
FROM coffeeshop  -- Replace with your actual table name
GROUP BY period_start
ORDER BY period_start;

SELECT 
    DATE_FORMAT(date, '%Y-%m-01') + INTERVAL (FLOOR(DAY(date)/15) * 15) DAY AS period_start,
    avg(price) AS avg_sales
FROM coffeeshop  -- Replace with your actual table name
GROUP BY period_start
ORDER BY period_start;

SELECT 
    DATE_FORMAT(date, '%Y-%m-01') + INTERVAL (FLOOR(DAY(date)/15) * 15) DAY AS period_start,
    count(price) AS Count_Coffee_Sale
FROM coffeeshop  -- Replace with your actual table name
GROUP BY period_start
ORDER BY period_start;

select count(card) as TotalCoffeeSelling from coffeeshop;


-- 43. Find the most popular time periods for coffee sales
SELECT 
    CASE 
        WHEN TIME(datetime) BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN TIME(datetime) BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN TIME(datetime) BETWEEN '17:00:00' AND '20:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_period,
    COUNT(*) AS total_sales,
    SUM(price) AS total_revenue
FROM coffeeshop
GROUP BY time_period
ORDER BY FIELD(time_period, 'Morning', 'Afternoon', 'Evening', 'Night');

SELECT 
    date,
    CASE 
        WHEN TIME(datetime) BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN TIME(datetime) BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN TIME(datetime) BETWEEN '17:00:00' AND '20:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_period,
    COUNT(price) AS CountSales,
    SUM(price) AS TotalRevenue
FROM coffeeshop
GROUP BY date, time_period
ORDER BY date, FIELD(time_peusersriod, 'Morning', 'Afternoon', 'Evening', 'Night');

select hour(datetime) as Hour_Of_Day,count(price) as Total_sales,avg(price) as Avg_Price from coffeeshop group by Hour_Of_Day order by Hour_Of_Day;

select hour(datetime) as Hour_Of_Day,count(price) as Total_sales,sum(price) as Total_Price from coffeeshop group by Hour_Of_Day order by Hour_Of_Day;
select * from coffeeshop;




