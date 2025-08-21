/* Q1. Recyclable and Low Fat Products */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
 

Write a solution to find the ids of products that are both low fat and recyclable.
Return the result table in any order.
*/

A1.
select product_id from products
where low_fats = 'Y' and recyclable = 'Y';

------------------------------------------------------------------------------------------------------------------------
/* Q2. Find Customer Referee */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 

Find the names of the customer that are either:

referred by any customer with id != 2.
not referred by any customer.
Return the result table in any order.
*/

A2.
**오답**
SELECT name
from customer
where id <> '2' or referee_id is NULL;
-> referee_id를 검증해야 하는데 본인의 id를 검증해버림. 문제를 잘 읽자.

SELECT name
from customer
where referee_id <> '2' or referee_id is NULL;

------------------------------------------------------------------------------------------------------------------------
/* Q3. Big Countries */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key (column with unique values) for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
 

A country is big if:

it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write a solution to find the name, population, and area of the big countries.

Return the result table in any order.
*/

A3.
**오답**
select name, population, area from world
where
area >= 3000000 or
population >= 2500000;
-> 지문은 2500만인데 250만을 써버림. 문제를 제발 잘 읽자.
-> 테이블명 Case-sensitive

select name, population, area from World
where
area >= 3000000 or
population >= 25000000;

------------------------------------------------------------------------------------------------------------------------
/* Q4. Article Views */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
 

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by id in ascending order.
*/

A4.
**오답**
select author_id from Views
where author_id = viewer_id
order by author_id;
-> 중복 검증 안됨
-> 컬럼명 확인

select author_id as id from Views
where author_id = viewer_id
group by author_id
order by author_id;
-> group by 대신 select distinct가 더 나은 듯
-> order by 절에 alias로 id를 넣어도 가능

------------------------------------------------------------------------------------------------------------------------
/* Q5. Invalid Tweets */
/*
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
content consists of alphanumeric characters, '!', or ' ' and no other special characters.
This table contains all the tweets in a social media app.
 

Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.

Return the result table in any order.
*/

A5.
SELECT tweet_id from Tweets
where length(content) > 15;
-> LENGTH() 는 Byte 수 기준으로 저장 공간 기준, CHAR_LENGTH() 는 글자 수 기준

------------------------------------------------------------------------------------------------------------------------
/* Q6. Replace Employee ID With The Unique Identifier */
 /*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in a company.
 

Table: EmployeeUNI

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.
 

Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

Return the result table in any order.
*/

A6.
 **오답**
SELECT unique_id from EmployeeUNI right outer join Employees
on id = id;
-> left outer join이 맞음. right outer는 UNI를 기준으로 함
-> ID = ID하면 자기 자신끼리 비교하게 되므로 항상 TRUE가 나옴. 테이블의 컬럼 명시 필요.

 SELECT unique_id from EmployeeUNI left outer join Employees
on Employees.id = EmployeeUNI.id;
-> Employees 테이블이 기준이어야 함.

 SELECT unique_id from Employees left outer join EmployeeUNI
on Employees.id = EmployeeUNI.id;

 SELEct EmployeeUNI.unique_id, employees.name from Employees left outer join EmployeeUNI
on Employees.id = EmployeeUNI.id;

SELECT
 B.unique_id,
 A.name
 from Employees A
 left outer join EmployeeUNI B
 on A.id = B.id;

------------------------------------------------------------------------------------------------------------------------
/* Q7. Product Sales Analysis 1 */
/*
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
 

Write a solution to report the product_name, year, and price for each sale_id in the Sales table.

Return the resulting table in any order.
*/

A7.
 SELECT
Product.product_name,
Sales.year,
Sales.price
from Sales  inner join Product
on Product.product_id = Sales.product_id;
(ALIAS 사용하면 Runtime이 느려짐?)
------------------------------------------------------------------------------------------------------------------------
/* Q8. Customer Who Visited but Did Not Make Any Transactions */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.
 

Table: Transactions

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.
 

Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.
*/

A8.
**오답**
 SELECT A.customer_id, count(*)
 from Visits A inner join Transactions B
where not A.visit_id = B.visit_id;
-> inner join을 해버리면 이미 거래가 있는 방문만 남음

 SELECT A.customer_id, count(*)
 from Visits A left outer join Transactions B
 on A.visit_id = B.visit_id
where B.visit_id is null;
-> 일부 DBMS에서는 임의의 customer_id만 나올 수 있음

 SELECT A.customer_id, count(*) as count_no_trans
 from Visits A left outer join Transactions B
 on A.visit_id = B.visit_id
where B.visit_id is null
group by customer_id;

 SELECT A.customer_id, count(*) as count_no_trans
 from Visits A  
where not exists (select visit_id from Transactions B where A.visit_id = B.visit_id)
group by customer_id;

select A.customer_id, count(*) as count_no_trans
from Visits A
where A.visit_id not in (select visit_id from Transactions B where A.visit_id = B.visit_id)
group by customer_id;

------------------------------------------------------------------------------------------------------------------------
/* Q9. Rising Temperature */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.
*/

A9.
 **오답**
 SELECT id
 from
 ( select recorddate, temperature, LAG(temperature) over (ORDER BY recorddate) as lag_temp
 from Weather)
where temperature > lag_temp;
-> 가져온 테이블은 alias 필요

 SELECT id
 from
 ( select recorddate, temperature, LAG(temperature) over (ORDER BY recorddate) as lag_temp
 from Weather) L
where temperature > lag_temp;
-> id 필드 명시하지 않음

 SELECT id
 from
 ( select id, recorddate, temperature, LAG(temperature) over (ORDER BY recorddate) as lag_temp
 from Weather) L
where temperature > lag_temp;

select A.id
from weather A
cross join weather B
where A.recorddate - B.recorddate = 1
and a.temperature > b.temperature;
(CROSS JOIN도 사용 가능함. 조건을 잘 줘야함)

select A.Id
from weather A
cross join weather B
where DATEDIFF(A.recorddate, b.recorddate) = 1
and a.temperature > b.temperature;
(DATEDIFF 구문도 사용 가능)

------------------------------------------------------------------------------------------------------------------------ 
/* Q10. 








