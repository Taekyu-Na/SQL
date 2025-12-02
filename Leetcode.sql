"
 52번

"
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

------------------------------------------------------------------------------------------------------------------------
 /* Q13. Managers with at Least 5 Direct Reports */
 /*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.
 */

 A13.
 **오답**
select A.name, count(A.id) from Employee A
left outer join Employee B
on A.id = B.id
where count(A.id) <= 5;
-> "Invalid use of group function" 에러 뜸. Group함수를 잘못 사용함. WHERE 절이 아닌 GROUP BY and Having을 써보자
-> "A.id = B.id"를 쓰면 항상 같은 사람끼리만 매칭됨.

 select A.name from Employee A
left outer join Employee B
on A.id = B.managerid
group by A.id
having count(B.managerid) >= 5;

------------------------------------------------------------------------------------------------------------------------
/* Q14. Confirmation Rate */
/*
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.

Return the result table in any order.
*/

A14.
**오답**
Select A.user_id,
       count(B.action = "confirmed") as conf_count,
       count(B.action) as act_count,
       round(, 2) as confirmation_rate
from Signups A left outer join Confirmations B
on A.user_id = B.user_id
group by B.user_id;
-> count 구문에 =를 쓰면 T/F가 되기 때문에 갯수를 셀 수 없음

Select A.user_id,
       round(AVG(CASE WHEN B.action = 'confirmed' then 1
       else 0
       end), 2) as confirmation_rate
from Signups A left outer join Confirmations B
on A.user_id = B.user_id
group by B.user_id;
(avg를 사용하면 1/0에 의해 'confirmed' 비율을 바로 구할 수 있음)
-> B 테이블로 그룹핑하면 B 테이블의 결과만 보여줌

select A.user_id,
       round(avg(case
       when B.action = 'confirmed' then 1
       else 0 end), 2) as confirmation_rate
    from signups A
    left outer join confirmations B
    on A.user_id = B.user_id
group by A.user_id;

------------------------------------------------------------------------------------------------------------------------
/* Q15. Not Boring Moves */
/*
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
 

Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.
*/

A15.
SELECT * from Cinema
where id % 2 = 1
and description not like 'boring'
order by rating desc;

SELECT * from Cinema
where MOD(id,2) = 1
and description not like 'boring'
order by rating desc;
(%, MOD 둘다 사용 가능)
(이번 경우 NOT LIKE를 써도 됐지만, 경우에 따라 위험할 수 있으므로 <>나 !=를 쓰는게 좋음)

------------------------------------------------------------------------------------------------------------------------
/* Q16. Average Selling Price */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
 

Table: UnitsSold

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold. 
 

Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.

Return the result table in any order.
*/

A16.
 **결과는 맞지만 로직이 틀림**
Select A.product_id,
       round(sum((A.price*B.units))/sum(B.units), 2) as average_price
from Prices A
left outer join UnitsSold b
on A.product_id = B.product_id
where B.purchase_date between A.start_date and A.end_date
group by A.product_id;
-> "left outer join에 위 where 절을 넣으면 "판매량이 없으면 평균가 = 0" 이라는 조건을 만족하지 못함. 즉, LEFT JOIN의 의미가 사라짐
 따라서 where 대신 on을 줘야함"

Select A.product_id,
       round(IFNULL((sum(A.price*B.units)/sum(B.units)), 0), 2) as average_price
from Prices A
left outer join UnitsSold b
on A.product_id = B.product_id
and B.purchase_date between A.start_date and A.end_date
group by A.product_id;

------------------------------------------------------------------------------------------------------------------------
/* Q17. Project Employees 1 */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
 

Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

Return the result table in any order.
*/

A17.
SELECT A.project_id,
       round(avg(B.experience_years), 2) as average_years
from Project A
left outer join Employee B
on A.employee_ID = B.employee_id
group by A.project_id;

------------------------------------------------------------------------------------------------------------------------
/* Q18. Percentage of Users Attended a Contest */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
 

Table: Register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.
 

Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
*/

A18.
SELECT contest_id,
       round(count(user_id)/(select count(user_id) from Users)*100, 2) as percentage
       from Register
       GROUP BY contest_id
       order by percentage desc, contest_id asc;
(SQL에서 정수 나눗셈과 실수 나눗셈이 다르게 동작할 수 있다 함. 예를 들어, 1/2 = 0 이 될 수도 있고, 0.5가 될 수도 있음.
 따라서 하나를 실수로 바꿔서 계산하는게 안전)

SELECT contest_id,
       round(count(user_id)*100.0/(select count(user_id) from Users), 2) as percentage
       from Register
       GROUP BY contest_id
       order by percentage desc, contest_id asc;

------------------------------------------------------------------------------------------------------------------------
/* Q19. Queries Quality and Percentage */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.
*/

A19.
**오답**
 SELECT query_name,
       round((avg(rating/position)), 2) as quality,
       round((select count(distinct (rating)) from Queries
       where rating < 3)*100.0/count(distinct (rating)), 2) as poor_query_percentage
from Queries
group by query_name;
-> "Duplicate row"가 있다고 해서 항상 distinct를 써야하는게 아님. 전체 데이터에서 횟수를 구해야 하는 경우에는 distinct를 쓰면 안됨
-> "논리적 수행 순서에 따라서 서브쿼리 안에 WHERE RATING < 3을 해버리면 미리 WHERE 조건으로 데이터를 분류해버림"
"FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER BY"

SELECT query_name,
       round((avg(rating/position)), 2) as quality,
       round(sum(CASE WHEN rating <3 THEN 1
       else 0 end)*100.0/count(rating), 2) as poor_query_percentage
from Queries
group by query_name;

------------------------------------------------------------------------------------------------------------------------
/* Q20. Monthly Transactions 1 */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.
*/

A20.
**오답**
SELECT date_format(trans_date, '%Y-%m') as month,
       country,
       count(trans_date) as trans_count,
       (select count(month) from transactions where state = 'approved') as approved_count,
       sum(amount) as trans_total_amount,
       (select sum(amount) from transactions where state = 'approved') as approved_total_amount
from transactions
group by country, month;
-> select 절 안에서 where를 포함한 서브쿼리를 넣어버리니 group by가 먹히기 전에 데이터가 확정됨

SELECT date_format(trans_date, '%Y-%m') as month,
       country,
       count(trans_date) as trans_count,
       count(case when state = 'approved' then 1 else 0 end) as approved_count,
       sum(amount) as trans_total_amount,
       sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by country, month;
-> CASE 문으로 나눠서 COUNT와 sum을 구할 수 있음
-> 단, count에서 "else 0"을 써버리면 0도 카운드 되기 때문에 NULL을 사용해야함

SELECT date_format(trans_date, '%Y-%m') as month,
       country,
       count(trans_date) as trans_count,
       count(case when state = 'approved' then 1 else null end) as approved_count,
       sum(amount) as trans_total_amount,
       sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by country, month;

------------------------------------------------------------------------------------------------------------------------
/* Q21. Immediate Food Delivery 2 */
/*
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
*/

A21.
**오답**
SELECT (count(case when order_date = customer_pref_delivery_date then 1 else null end))*100.0/(count(delivery_id)) as immediate_percentage
from delivery
group by customer_id;
-> "customer_id로 group by하면 고객별인데 문제가 요구하는건 모든 고객의 전체 비율"
-> "첫 주문에 대한 조건 없음"

select round(count(case when order_date = customer_pref_delivery_date then 1 else null end)*100.0/count(delivery_id), 2) as immediate_percentage
from delivery
where (customer_id, order_date) IN
(select customer_id, min(order_date)
from delivery
group by customer_id);
(고객별 첫 주문에 대한 조건을 위해 where 절에 중첩 서브쿼리 넣음)
(count else null 보다 sum else 0이 더 가독성 좋음)

------------------------------------------------------------------------------------------------------------------------
/* Q22. Game Play Analysis */
/*
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.
In other words, you need to determine the number of players who logged in on the day immediately following their initial login,
and divide it by the number of total players.
*/

A22.
**오답**
SELECT round(sum(case when datediff(A.event_date, B.event_date) = 1 then 1 else 0 end)/count(DISTINCT A.player_id), 2) as fraction
FROM Activity A
left outer join Activity B
on A.player_id = B.player_id;
-> "첫 로그인 날짜 제약 조건 없음"

select round(count(player_id)/(select count(distinct player_id) from activity), 2) as fraction
FROM Activity
where (player_id, date_sub(event_date, INTERVAL 1 DAY)) IN
(select player_id, min(event_date)
from Activity
group by player_id)
(어떤 플레이어가 first_date + 1에 여러 번 로그인했다면, COUNT(player_id)에서 그 플레이어가 여러 번 카운트될 수 있음.
따라서 분자에도 DISTINCT 넣어주면 좋음. 단, 지문에서 player_id, event_date가 PK로 지정되었기 때문에 내 로직도 문제는 없음)

------------------------------------------------------------------------------------------------------------------------
/* Q23. Number of Unique Subjects Taught by Each Teacher */
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
(subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.
 

Write a solution to calculate the number of unique subjects each teacher teaches in the university.

Return the result table in any order.
*/

A23.
**오답**
SELECT teacher_id,
       count(distinct subject_id, dept_id) as cnt
    from Teacher
group by teacher_id;
-> 고유 과목 수만 고르면 됨
-> MySQL은 COUNT(DISTINCT col1, col2)를 지원하지만, 대부분의 SQL (PostgreSQL, Oracle, SQL Server)은 이 문법을 지원하지 않음.

SELECT teacher_id,
       count(distinct subject_id) as cnt
    from Teacher
group by teacher_id;

------------------------------------------------------------------------------------------------------------------------
/* Q24. User Activity for the Past 30 Days 1 */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
 

Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.

Return the result table in any order.
*/

A24.
SELECT activity_date as day,
       count(distinct user_id) as active_users
    from Activity
where activity_date between '2019-06-28' and '2019-07-27'
group by activity_date;
(일자에는 따옴표 필요)
(WHERE 절에 BETWEEN AND 도 가능하고 >,< 도 가능)

------------------------------------------------------------------------------------------------------------------------
/* Q25. Product Sales Analysis 3 */
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
Each row records a sale of a product in a given year.
A product may have multiple sales entries in the same year.
Note that the per-unit price.

Write a solution to find all sales that occurred in the first year each product was sold.

For each product_id, identify the earliest year it appears in the Sales table.

Return all sales entries for that product in that year.

Return a table with the following columns: product_id, first_year, quantity, and price.
Return the result in any order.
*/

A25.
**오답**
SELECT product_id,
       year as first_year,
       quantity as quantity,
       price as price
    from Sales
where year in (select min(year))
group by product_id;
-> WHERE로 인해서 가장 빠른 연도 하나만 구해오게됨
-> select from이 없음

SELECT product_id,
       year as first_year,
       quantity as quantity,
       price as price
    from Sales
where (product_id, year) in
(select product_id, min(year)
FROM Sales
group by product_id);

------------------------------------------------------------------------------------------------------------------------
/* Q26. Classes With at Least 5 Students */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 

Write a solution to find all the classes that have at least five students.

Return the result table in any order.
*/

A26.
SELECT class
from Courses
group by class
having count(student) >= 5;

------------------------------------------------------------------------------------------------------------------------
/* Q27. Find Followers Count */
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.
 

Write a solution that will, for each user, return the number of followers.

Return the result table ordered by user_id in ascending order.
*/

A27.
SELECT user_id,
       count(follower_id) as followers_count
    from Followers
group by user_id
order by user_id;

------------------------------------------------------------------------------------------------------------------------
/* Q28. Biggest Single Number */
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.
*/

A28.
**오답**
SELECT MAX(num) AS num
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1;
-> 실행 순서 상 max(num)이 group 안에서 돌기 때문에 여러행을 반환하는 쿼리가 됨

SELECT (case when num = A.num THEN max(a.num) else null end) as num
from
(SELECT num
    from MyNumbers
    group by num
    HAVING count(num) = 1) as A;
(맞지만 몇가지 문제점 있음. 첫째, num 컬럼 불명확함. from 절에 A라는 서브쿼리만 존재함. 다라서 num은 a.numm으로만 참조 가능)
(case문 불필요함. single number가 없으면 "MAX()"는 자동으로 null 반환함)

SELECT max(A.num) as num
from
(SELECT num
    from MyNumbers
    group by num
    HAVING count(num) = 1) as A;

------------------------------------------------------------------------------------------------------------------------
/* Q29. Customers Who Bought All Products */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.
*/

A29.
**오답**
select a.customer_id
FROM Customer A
inner join Product B
on A.product_key = B.product_key
group by A.customer_id, A.product_key
having count(distinct(a.customer_id, a.product_key)) = 2;
-> 고객/상품별이 아니라 고객별로 산 상품 개수를 구하는거니까 GROUP BY a.customer_id만 있어야 함
-> count(distinct)에서 col1, col2를 지원안함. 고객별로 다른 상품을 산 것을 구해야 하니까 a.product_key를 고유로 잡아야 함)
-> "2"로 하드코딩이 되어있음. 모든 제품을 구매한 고객을 찾는건데 2개로 하드코딩하면 안됨.

select a.customer_id
FROM Customer A
inner join Product B
on A.product_key = B.product_key
group by A.customer_id
having count(distinct(a.product_key)) = count(b.product_key);
-> 맨 뒤에 "count(b.product_key)"가 GROUP BY A.customer_id 기준으로 세어지기 때문에 고객이 구매한 행의 수를 세는 것으로 로직이 이상해짐

select a.customer_id
FROM Customer A
inner join Product B
on A.product_key = B.product_key
group by A.customer_id
having count(distinct(a.product_key)) = (SELECT count(product_key) from Product);

select customer_id
    from Customer
group by customer_id
having count(distinct product_key) = (select count(*) from product);
(꼭 Join을 사용하지 않더라도 더 간단하게 풀 수 있음)

------------------------------------------------------------------------------------------------------------------------
/* Q30. The Number of Employees Which Report to Each Employee */
/*
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.
*/

A30.
SELECT a.employee_id,
       a.name,
       count(a.employee_id) as reports_count,
       round(avg(b.age), 0) as average_age
    from Employees A
    inner join Employees B
    on A.employee_id = b.reports_to
    group by a.employee_id
    ORDER BY A.employee_id;
(답은 맞는데 한가지 오류가 있다면, a.employee_id를 세고 있음. 직원의 수를 구해야 함.
(부하가 최소 1명인 직원만 관리자로 본다는 조건은 inner join으로 충족하여 having 절을 줄 필요가 없음)

SELECT a.employee_id,
       a.name,
       count(b.employee_id) as reports_count,
       round(avg(b.age), 0) as average_age
    from Employees A
    inner join Employees B
    on A.employee_id = b.reports_to
    group by a.employee_id
    ORDER BY A.employee_id;

------------------------------------------------------------------------------------------------------------------------
/* Q31. Primary Department for Each Employee */
/*
+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
 

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in any order.
*/

A31.
**오답**
SELECT employee_id,
       (case
       when count(distinct department_id) > 1 and primary_flag = 'Y' then department_id
       when count(distinct department_id) = 1 then department_id
       else null end) as department_id
    from Employee
group by employee_id;
-> GROUP BY employee_id를 했기 때문에 employee_id 별로 1행만 나오는데, 이때 department_id와, primary_flag가 집계함수 없이 select/case 안에 들어있기 때문에,
엔진이 어떤 department_id와 어떤 primary_flag를 써야 하는지 알 수 없음
-> count(distinct department_id)는 집계값이고, primary_flag는 개별 row 값이기 때문에 같은 case 안에서 비교 불가

SELECT employee_id,
       department_id
    from Employee
where primary_flag = 'Y'
or count(department_id) = 1
group by employee_id;
-> COUNT()는 WHERE 절에 나올 수 없음. GROUP BY 이후 수행됨
-> group by 이후 SQL 엔진이 어떤 department_id 값을 가져와야 하는지 모름

SELECT employee_id,
       department_id
    from Employee
where primary_flag = 'Y'
or employee_id IN (
    Select employee_id from employee
    group by employee_id
    having count(department_id) = 1
);

------------------------------------------------------------------------------------------------------------------------
/* Q32. Triangle Judgement */
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 

Report for every three line segments whether they can form a triangle.

Return the result table in any order.
*/

A32.
**삼각형 부등식: 세 변 중 어떤 두 변의 합이 나머지 한 변보다 엄격히 커야 함
SELECT x,
       y,
       z,
       (case
       when (x+y > z) and (x+z > y) and (y+z >x) then 'Yes'
       else 'No' end
       ) as triangle
    from Triangle;

------------------------------------------------------------------------------------------------------------------------
/* Q33. Consecutive Numbers */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.
*/

A33.
**아예 못 풀었음**
SELECT DISTINCT a.num AS ConsecutiveNums
FROM Logs A, Logs B, Logs C
where a.id = b.id - 1
and b.id = c.id -1
and a.num = b.num
and b.num = c.num;
(3개의 테이블을 조인해도 됨)

SELECT distinct a.num as ConsecutiveNums
from Logs A
Inner join Logs B
on A.id = b.id - 1
inner join Logs C
on b.id = c.id - 1
WHERE a.num = b.num = c.num;
-> 마지막 where 절에서 SQL은 다중 비교 연산을 한 번에 해석하지 못함

SELECT distinct a.num as ConsecutiveNums
from Logs A
Inner join Logs B
on A.id = b.id - 1
inner join Logs C
on b.id = c.id - 1
WHERE a.num = b.num and b.num = c.num;

------------------------------------------------------------------------------------------------------------------------
/* Q34. Product Price at a Given Date */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
Initially, all products have price 10.

Write a solution to find the prices of all products on the date 2019-08-16.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
*/

A34.
**오답**
SELECT product_id,
       case when min(change_date) > '2019-08-16' then '10'
       when change_date <= '2019-08-16' then ???
       else null end as price
from Products
group by product_id;
-> min(change_date) 애매한 사용법

SELECT product_id,
       10 as price
    from Products
group by product_id
having min(change_date) > '2019-08-16'
union
SELECT product_id,
       new_price as price
    from Products
where (product_id, change_date) in (select product_id, max(change_date)
                                    from Products
                                    where change_date <= '2019-08-16'
                                    group by product_id);

------------------------------------------------------------------------------------------------------------------------
/* Q35. Last Person to Fit in the Bus */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |
+-------------+---------+
person_id column contains unique values.
This table has the information about all people waiting for a bus.
The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
weight is the weight of the person in kilograms.
 

There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

Note that only one person can board the bus at any given turn.
*/

A35.
**아예 못품**
SELECT 
    a.person_name
FROM Queue a JOIN Queue b ON a.turn >= b.turn
GROUP BY a.turn
HAVING SUM(b.weight) <= 1000
ORDER BY SUM(b.weight) DESC
limit 1;
(JOIN ON에서 a.turn >= b.turn의 뜻은 턴이 오면 그 사람의 이전까지 쭉 조합을 만들어냄)
(그 사이에서 weight 합계를 구해서 1000 이하로 가지고 옴)

SELECT person_name
from (SELECT person_name,
             weight,
             turn,
             sum(weight) over (order by turn) as total_weight
            from Queue) as Subquery
        where total_weight <= 1000
order by turn desc
limit 1;
(sum(weight) over (order by turn) 이 구문으로 weight 합계를 차례대로 구함)
(누적 무게가 1000 이하인 라인으로 한정)

'SELECT person_name,
             weight,
             turn,
             sum(weight) over (order by turn) as total_weight
            from Queue
        where total_weight <= 1000;'
가 에러나는 이유는 실행 순서에 따라 FROM > WHERE 이기 때문에 WHERE에서 total_weight를 찾을 수 없음

------------------------------------------------------------------------------------------------------------------------
/* Q36. Count Salary Categories */
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.
*/

A36.
**아예 못품**
SELECT 'Low Salary' as category,
       sum(case when income < 20000 then 1
       else 0 end) as accounts_count
    from Accounts
UNION
SELECT 'Average Salary' as category,
       sum(case when income between 20000 and 50000 then 1
       else 0 end) as accounts_count
    from Accounts
UNION
SELECT 'High Salary' as category,
       sum(case when income > 50000 then 1
       else 0 end) as accounts_count
    from Accounts;
(각 SELECT는 1개의 행(SALARY 범위 개수)만 반환하도록 되어있음)
(UNION은 중복 제거하기 때문에 UNION ALL 대비 성능상 불리할 수 있음. 그리고 의미상 UNION ALL도 맞음)

SELECT 'Low Salary' as category,
       sum(case when income < 20000 then 1
       else 0 end) as accounts_count
    from Accounts
UNION ALL
SELECT 'Average Salary' as category,
       sum(case when income between 20000 and 50000 then 1
       else 0 end) as accounts_count
    from Accounts
UNION ALL
SELECT 'High Salary' as category,
       sum(case when income > 50000 then 1
       else 0 end) as accounts_count
    from Accounts;

------------------------------------------------------------------------------------------------------------------------
/* Q37. Employees Whose Manager Left the Company */
/*
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+
In SQL, employee_id is the primary key for this table.
This table contains information about the employees, their salary, and the ID of their manager. Some employees do not have a manager (manager_id is null). 
 

Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.

Return the result table ordered by employee_id.
*/

A37.
**오답**
SELECT employee_id
       from (SELECT employee_id
               from Employees
              where salary < 30000 and manager_id is not null and (manager_id) not in (employee_id)) as Subquery
order by employee_id;
-> manager_id not in (employee_id)는 결국 manager_id != employee_id와 같아버림
-> NOT IN은 서브쿼리에 NULL 값이 포함되면 결과가 비정상적일 수 있음

SELECT employee_id
from Employees
where salary < 30000
  and manager_id not in (select employee_id from Employees)
order by employee_id;

------------------------------------------------------------------------------------------------------------------------
/* Q38. Exchange Seats */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.
*/

A38.
**아예 못품**
SELECT
    CASE
        WHEN
            id = (select max(id) from Seat) and mod(id, 2) = 1
            then id
        WHEN
            mod(id, 2) = 1
            then id + 1
        ELSE
            id - 1
        end as id, student
    from Seat
order by id;
(첫번째 WHEN은 마지막이 홀수 일때 그대로 ID 가져오고, 두번째는 홀수일때 다음 번호, 나머지는 직전 번호 가져옴)
'
| id | student |
| -- | ------- |
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  | 여기서 1 Abbot이 2 Abbot이 되고, 2 Doris가 1 Doris가 되서 순서가 바뀌는 개념이 되는 것'

------------------------------------------------------------------------------------------------------------------------
/* Q39. Movie Rating */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/

A39.
**아예 못품**
(
    SELECT min(A.name) as results
        from Users A
        inner join 
            (SELECT user_id
            from MovieRating
            group by user_id
            having count(rating) = (SELECT max(rate_cnt) from
                            (SELECT count(rating) as rate_cnt
                            from MovieRating
                            group by user_id) as Subquery_A)) B
        on a.user_id = b.user_id
)
UNION ALL
(
    SELECT title as results
    from MovieRating C
    inner join Movies D
    on c.movie_id = d.movie_id
    where c.created_at between '2020-02-01' and '2020-02-29'
    group by d.movie_id, title
    order by avg(c.rating) desc, title asc
    limit 1
)
(위 문단은 먼저 user_id별 rating 카운트를 가져오고 감싸서 max(rate_cnt)로 그 중 최대치를 가져옴)
(그 다음 MovieRating에서 rating 카운트가 위 최대치와 같은 user_id를 구하고)
(Users와 join하여 name이 알파벳 최소값min으로 1개만 가져옴)
(아래 문단은 2020-02에 생성된 데이터 중 movie_id별로 rating 평균이 가장 높은 것 1개의 title을 한번에 구함)

------------------------------------------------------------------------------------------------------------------------
/* Q40. Restaurant Growth */
/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.
*/

A40.
**오답**
SELECT distinct visited_on,
        sum(amount) over (order by visited_on asc
        range between interval 6 day preceding and current row) as amount,
        round(sum(amount) over (order by visited_on asc
        range between interval 6 day preceding and current row)/7, 2) as average_amount
    from Customer A
    group by visited_on
    having count(visited_on) over (order by visited_on asc
        range unbounded preceding) >= 7
    order by visited_on asc;
-> visited_on으로 group by 했으므로 select distinct 불필요
-> range between 구문은 일부 DBMS에서 날짜 타입 컬럼에 직접 못 쓸 수 있음. rows beteween 6 preceding and current row를 쓰거나
서브쿼리에서 날짜 조건을 직접 걸어야 함
-> 이 지문에서 매출이 없는 날짜는 없으니 /7도 되긴 하지만, 여러 고객이 방문할 수 있으니까 sum(amount)를 날짜 단위로 집계한 뒤
평균을 내야함
-> having 안에서 window function 이용 불가


SELECT visited_on,
       amount,
       average_amount
    from
        (SELECT distinct visited_on,
                         sum(amount) over (order by visited_on
                         range between interval 6 day preceding and current row) as amount,
                         round((sum(amount) over (order by visited_on
                         range between interval 6 day preceding and current row))/7, 2) as average_amount
            from Customer) as Subquery
    where visited_on >= (SELECT date_add(min(visited_on), interval 6 day)
                            from Customer)
(인라인 뷰에서 전체 데이터에 대한 누적 합계와 그 평균을 구함. 단, GROUP BY는 못하고 distinct로 가져와야 함
왜냐하면 group by하면 각 날짜별로 한 줄만 남은 상태에서 sum을 구하게 되기 때문)
(해당 전체 데이터 중에서 이평선 7일이 시작하는 데이터부터 가져와야 하므로 where 절을 줌)

------------------------------------------------------------------------------------------------------------------------
/* Q41. Friend Requests 2: Who Has the Most Friends */
/*
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.
*/

A41.
SELECT id, sum(num) as num
    from
        (SELECT requester_id as id, count(requester_id) as num
            from (
                    SELECT requester_id, count(requester_id)
                        from RequestAccepted
                        group by requester_id, accepter_id
                ) as Subquery
            group by requester_id
        UNION ALL
        SELECT accepter_id, count(accepter_id)
            from (
                    SELECT accepter_id, count(accepter_id)
                        from RequestAccepted
                        group by requester_id, accepter_id
                ) as Subquery
            group by accepter_id) as Subquery
    group by id
    order by num desc
    limit 1
(풀긴 했으나 복잡한 중첩 그룹핑을 가지고 있어 불필요한 로직이 너무 많음)

SELECT id, count(*) as num
    from
        (SELECT requester_id as id
            from RequestAccepted
        UNION ALL
        SELECT accepter_id as id
            from RequestAccepted) as Subquery
    group by id
    order by num desc
    limit 1

------------------------------------------------------------------------------------------------------------------------
/* Q42. Investments in 2016 */
/*
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
 

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.
*/

A42.
**오답**
SELECT round(sum(tiv_2016), 2) as tiv_2016
    from Insurance
    where pid IN
        (SELECT pid
            FROM Insurance
            group by tiv_2015
            having count(tiv_2015) > 1
        UNION
        SELECT pid
            FROM Insurance
            GROUP BY lat, lon
            having count(*) = 1)
-> GROUP BY tiv_2015에서 pid를 select 할 수 없음
-> UNION은 OR 조건이 됨

SELECT round(sum(tiv_2016), 2) as tiv_2016
    from Insurance
    where tiv_2015 IN
        (SELECT tiv_2015
            FROM Insurance
            group by tiv_2015
            having count(tiv_2015) > 1)
        AND
        (lat, lon) in
        (SELECT lat, lon
            FROM Insurance
            GROUP BY lat, lon
            having count(*) = 1);

------------------------------------------------------------------------------------------------------------------------
/* Q43. Department Top Three Salaries */
/*
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.
*/

A43.
**아예 못품**
SELECT b.name as Department,
       a.name as Employee,
       a.salary as Salary
    from Employee A 
    LEFT JOIN Department B
    on a.departmentid = b.id
    WHERE (SELECT count(distinct c.salary)
            from Employee C
            where C.departmentid = a.departmentid and c.salary >= a.salary) <= 3
(서브쿼리: 부서가 같으면서 더 높은 급여 값의 개수를 세기)
(상위 3 번째 distinct 급여인지 계산)

------------------------------------------------------------------------------------------------------------------------
/* Q44. Fix Names in a Table */
/*
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.
*/

A44.
SELECT user_id,
       concat(UPPER(substring(name, 1, 1)), lower(substring(name, 2))) as name
    from Users
    order by user_id

------------------------------------------------------------------------------------------------------------------------
/* Q45. Patients With a Condition */
/*
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key (column with unique values) for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.

Return the result table in any order.

The result format is in the following example.
*/

A45.
**오답**
SELECT * from Patients
    where REGEXP_LIKE(conditions, '.DIAB1+')
    OR REGEXP_LIKE(conditions, '^DIAB1')

SELECT * FROM Patients
    where conditions like 'DIAB1%' or
          conditions like '% DIAB1%'

(SELECT * FROM patients WHERE conditions REGEXP '\\bDIAB1')

------------------------------------------------------------------------------------------------------------------------
/* Q46. Delete Duplicate Emails */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

For Pandas users, please note that you are supposed to modify Person in place.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

The result format is in the following example.
*/

A46.
**오답**
DELETE FROM Person
    where (id) not in (SELECT min(id) from Person)

DELETE A
    from Person A
    inner join Person B
    on a.email = b.email
    and a.id > b.id
;

------------------------------------------------------------------------------------------------------------------------
/* Q47. Second Highest Salary */
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.
*/

A47.
**오답**
SELECT (CASE WHEN sal_rank = 2 then salary else null end) as SecondHighestSalary
from (SELECT id,
             salary,
             rank() over (order by salary desc) as sal_rank
    from Employee) Subq1
'null
200
null'로 나오게 됨

SELECT max(salary) as SecondHighestSalary from Employee
    where salary <> (SELECT max(salary) from Employee)

SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
(SELECT로 한번 더 감싸주는 이유는 행이 없는 경우 NULL 값을 반환하기 위함)
(SELECT로 감싸주지 않으면 아무 행도 반환되지 않음)

------------------------------------------------------------------------------------------------------------------------
/* Q48. Group Sold Products By The Date */
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sell_date   | date    |
| product     | varchar |
+-------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each row of this table contains the product name and the date it was sold in a market.
 

Write a solution to find for each date the number of different products sold and their names.

The sold products names for each date should be sorted lexicographically.

Return the result table ordered by sell_date.

The result format is in the following example.
*/

A48.
SELECT sell_date,
       count(distinct product) as num_sold,
       GROUP_CONCAT(distinct product order by product asc SEPARATOR ',') as products
    from Activities
    group by sell_date
    order by sell_date asc

------------------------------------------------------------------------------------------------------------------------
/* Q49. List the Products Ordered in a Period */
/*
Table: Products

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+
product_id is the primary key (column with unique values) for this table.
This table contains data about the company's products.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+
This table may have duplicate rows.
product_id is a foreign key (reference column) to the Products table.
unit is the number of products ordered in order_date.
 

Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

Return the result table in any order.

The result format is in the following example.
*/

A49.
SELECT a.product_name,
       sum(b.unit) as unit
    from Products a
    join Orders b
    on a.product_id = b.product_id
        where b.order_date between '2020-02-01' and '2020-02-29'
            group by a.product_id, a.product_name
            having sum(b.unit) >= 100
EXTRACT(YEAR_MONTH FROM b.order_date) 보다 between and 쓰는게 Leap year, 가독성 등 고려 시 더 명확

------------------------------------------------------------------------------------------------------------------------
/* Q50. Find Users With Valid E-Mails */
/*
Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains information of the users signed up in a website. Some e-mails are invalid.
 

Write a solution to find the users who have valid emails.

A valid e-mail has a prefix name and a domain where:

The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
The domain is '@leetcode.com'.
Return the result table in any order.

The result format is in the following example.
*/

A50.
SELECT * FROM Users
 where REGEXP_LIKE(mail, '^[:alpha:][:alnum:}_.-]+@leetcode.com}')

SELECT *
FROM Users
WHERE 
REGEXP_LIKE(mail, '^[A-Za-z][A-Za-z0-9._-]*@leetcode\\.com$', 'c');
  ^[A-Za-z] : 첫 글자는 반드시 영어 문자
  [A-Za-z0-9._-]* : 그 뒤에는 영문, 숫자, _, ., -가 0회 이상
  @leetcode\.com$ : 문자열의 끝에 정확히 @leetcode.com이 옴 (백슬래시로 . escape)
  'c' : 대소문자 구분

------------------------------------------------------------------------------------------------------------------------
/* Q51. Combine Two Tables */
/*
Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+
personId is the primary key (column with unique values) for this table.
This table contains information about the ID of some persons and their first and last names.
 

Table: Address

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
addressId is the primary key (column with unique values) for this table.
Each row of this table contains information about the city and state of one person with ID = PersonId.
 

Write a solution to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.

Return the result table in any order.

The result format is in the following example.
*/

A51.
SELECT A.firstName,
       A.lastName,
       B.city,
       B.state
    from Person A
        left outer join Address B
        on A.personId = B.personId

------------------------------------------------------------------------------------------------------------------------
/* Q52. Nth Highest Salary */
/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.

The result format is in the following example.
*/

A52.
**아예 못품**
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N = N-1;
  RETURN  (
      SELECT DISTINCT salary
      FROM Employee
      ORDER BY salary DESC
      LIMIT 1 OFFSET N
  );
END
-> OFFSET은 0부터 시작함. 따라서 N을 0-based로 맞추고 시작

------------------------------------------------------------------------------------------------------------------------
/* Q53. Employees Earaning More Than Their Managers */
/*
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

Write a solution to find the employees who earn more than their managers.

Return the result table in any order.

The result format is in the following example.
*/

A53.
SELECT A.name AS Employee
    FROM Employee A
    INNER JOIN Employee B
    ON A.managerId = B.id
        WHERE A.salary > B.salary
;












