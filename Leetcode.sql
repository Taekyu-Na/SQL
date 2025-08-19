Q1. Recyclable and Low Fat Products

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

A1.
select product_id from products
where low_fats = 'Y' and recyclable = 'Y';

------------------------------------------------------------------------------------------------------------------------
Q2. Find Customer Referee

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
Q3. Big Countries

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
Q4. Article Views

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











