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
/* Q10. Average Time of Process per Machine */
/*
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.
It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.
 

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

Return the result table in any order.
*/

A10.
 **오답**
SELECT machine_id, S.timestamp
round(avg(????) over (partition by process_id,3) as processing_time
from 
 (select machine_id, process_id, 
 from activity
 group by process_id
 -> 노답

 select A.machine_id,
        round(avg(B.timestamp - A.timestamp), 3) as processing_time
 from activity A
 join activity B
 on A.machine_id = b.machine_id
 where A.activity_type = 'start' and B.activity_type = 'end'
 group by A.machine_id
 -> 먼저 Start와 end의 timestamp를 가진 2개의 테이블을 정의하고, machine_id 키값으로 self join하며 그룹핑.
 그 다음 end에서 start timestamp를 뺀 값을 평균하여 소수점 3째자리까지 반올림한다.

 ------------------------------------------------------------------------------------------------------------------------ 
 /* Q11. Employee Bonus */
 /*
 +-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 

Table: Bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
 

Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.

Return the result table in any order.
 */

 A11.
 **오답**
 select A.name,
 B.bonus
 from employee A
 left outer join Bonus B
 on A.empid = B.empid
 where B.bonus < 1000;
-> 모든 직원들 조회해야 함. 즉 조건에 부합하지 않으면 null로 표시 필요

 select A.name, B.bonus
 from employee A
 left outer join Bonus B
 on A.empid = B.empid
where B.bonus < 1000;
-> 보너스가 없는 애들은 조회되지 않음

  select A.name, B.bonus
 from employee A
 left outer join Bonus B
 on A.empid = B.empid
where B.bonus < 1000 or B.bonus is NULL;

 ------------------------------------------------------------------------------------------------------------------------ 
/* Q12. Students and Examinations */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
 

Table: Subjects

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
 

Table: Examinations

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
 

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by student_id and subject_name.
*/

A12.
SELECT A.student_id,
       A.student_name,
       B.subject_name,
       count(C.student_id) as attended_exams
from Students A
cross join Subjects B
left outer join examinations C
on A.student_id = C.student_id
and B.subject_name = C.subject_name
group by A.student_id, A.student_name, B.subject_name
order by A.student_id, B.subject_name;
-> 복습 필수



