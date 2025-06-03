create database blinkitdb;
use blinkitdb;
select * from blinkit_data;

------#  DATA CLEANING  #-------

update blinkit_data
set Item_Fat_Content=
case
when Item_Fat_Content in('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content 
end;

select distinct (Item_Fat_Content ) from blinkit_data;

-------# KPI's Requirements #-----

----# a)TOTAL SALES (the overall revenue generated from all item sold) -----

select sum(Sales) as Total_Sales from blinkit_data;

----# To show the sum in millions and convert result into a decimal number with total number of digits= 10(precision) and number of decimal place= 2(scale) -------
select cast(sum(Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions from blinkit_data;

----# By using concat function ----
select concat(cast(sum(Sales)/1000000 as decimal(10,2)),'Millions') as Total_Sales_Millions
from blinkit_data;

----# b)AVERAGE SALES --------
select avg(Sales) from blinkit_data;
select cast(avg(Sales) as decimal(10,0)) from blinkit_data;

------#c)Number of items -------
select count(*)as No_of_items from blinkit_data;

------#d)AVERAGE RATINGS ----
select cast( avg(rating) as decimal (10,2)) as average_rating from blinkit_data;


------# GRANUAL REQUIREMENT ------

---#a)TOTAL SALES BY FAT CONTENT ----

select Item_Fat_Content,
concat(cast(sum(Sales)/1000000 as decimal (10,2)),'M') as Total_Sales_Millions,
cast(avg(Sales) as decimal (10,0)) as Average_Sales,
cast(avg(Rating) as decimal (10,2)) as Average_Rating,
count(*) as No_of_items
from blinkit_data
group by Item_Fat_Content
order by Total_Sales_Millions desc;


----#b)TOTAL SALES BY ITEM TYPE -----

select  Item_type,
concat(cast(sum(Sales)/1000000 as decimal (10,2)),'M') as Total_Sales_Millions,
cast(avg(Sales) as decimal (10,0)) as Average_Sales,
cast(avg(Rating) as decimal (10,2)) as Average_Rating,
count(*) as No_of_items
from blinkit_data
group by Item_Type
order by Total_Sales_Millions 
Limit 5;


----#c)FAT CONTENT  BY OUTLET FOR TOTAL SALES -----

select Outlet_Location_Type,
IFNULL(sum(case when Item_Fat_Content='Low Fat' then Sales else 0 end),0)
as Low_Fat_Sales,
IFNULL(sum(case when Item_Fat_Content='Regular' then Sales else 0 end),0)
as Regular_Sales        
from
blinkit_data
group by Outlet_Location_Type;


----#d)TOTAL SALES BY OUTLET ESTABLISHMENT --------

select Outlet_Establishment_Year,
concat(cast(sum(Sales)/1000000 as decimal(10,2)),"M") as total_sales,
cast(avg(Sales) as decimal (10,0)) as Average_Sales,
cast(avg(Rating) as decimal (10,2)) as Average_Rating,
count(*) as No_of_items
 from blinkit_data
 group by Outlet_Establishment_Year
 order by Outlet_Establishment_Year;
 
 
 select Outlet_Establishment_Year,
 ifnull(sum(case when Item_Fat_Content ="Low Fat" then Sales else 0 end),0) as Low_Fat_Sales,
 ifnull(sum(case when Item_Fat_Content="Regular" then Sales else 0 end),0)as Regular_Sales
 from blinkit_data
 group by Outlet_Establishment_Year
 order by Outlet_Establishment_Year;
 

 ----#e)PERCENTAGE OF SALES BY OUTLET SIZE -------
 select Outlet_Size,
 concat(cast(sum(Sales)/100000 as decimal(10,2)),'M') as total_sales,
 concat(cast((sum(Sales)*100.0/sum(sum(Sales))  over()) as decimal(10,2)),'%') as Sales_Percentage
 from blinkit_data
 group by Outlet_Size
 order by total_sales;
 
 ----- #f)SALES BY OUTLET LOCATION --------
 
 select Outlet_Location_Type,
 concat(cast(sum(Sales)/1000000 as decimal(10,2)),'M') as Total_Sales
 from blinkit_data
 group by Outlet_Location_Type
 order by Total_Sales ;
 
 select * from blinkit_data;
 ------#g)ALL MATRICS(total sales,average sales,number of items,average rating) BY OUTLET TYPE --------
 
 select Outlet_Type,
 concat(cast(sum(Sales)/1000000 as decimal(10,2)),'M') Total_Sales,
 cast(avg(Sales) as decimal(10,2))as Avg_Sales,
 count(*) as No_Of_Items,
 cast(avg(rating) as decimal(10,2)) Avg_Rating
 from blinkit_data
 group by Outlet_Type
 order by Total_Sales asc;
 
 
 
 
 
 
 
 
 