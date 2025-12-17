/* 1. Date 관련 */
  '1.1 연/월/일 추출하기'
MySQL에서 date 타입 필드에서 특정 연/월/일를 가져올때는 아래처럼 가져올 수 있음.
SELECT DATE_FORMAT(TEST, '%Y-%m')

  '1.2 일자 더하기/빼기'
MySQL에서 일자 더하고 뺄 때,
DATE_ADD/SUB(기준 일자, INTERVAL 1 SECOND/MINUTE/HOUR/DAY/MONTH/YEAR)

/* 2. GROUP BY 관련 */
  '2.1 GROUP BY 이후 SELECT 절'
GROUP BY를 쓰면 SELECT 절에는 반드시 다음 둘 중 하나만 나올 수 있음
- GROUP BY에 포함된 컬럼
- 집계 함수(COUNT(), SUM(), MAX(), …)가 적용된 컬럼
(엔진이 어느 값을 가져와야 하는지 모르기 때문)
    '2.2 GROUP_CONCAT'
GROUP_CONCAT = 여러 행의 값을 콤마로 구분된 하나의 필드로 합치기
    EX) GROUP_CONCAT(distinct product order by product asc SEPARATOR ',') as products
이처럼 distinct, order by 사용 가능
SEPERATOR ','를 넣어서 구분자 사용 가능

/* 3. COUNT() 관련 */
  '3.1 COUNT() 실행 위치'
COUNT()는 GROUP BY 이후에 생기는 값인데
WHERE는 그 이전에 실행되므로 COUNT() 값이 아직 없음

/* 4. REGEXP \\b */
\b는 단어 경계로 사용됨
예를 들어, \bcat은 'cat'이나 'my cat'은 매칭하지만, 'educate'는 매칭되지 않음
cat\b는 'cat'이나 'cat food'은 매칭하지만, 'cater'는 매칭되지 않음
\를 두개 쓰는 이유는 슬래시 escape용

/* 5. IN/NOT IN (Subquery) */
IN (subquery)	일치값이 있으면 TRUE. 없으면 UNKNOWN (FALSE 취급). 정상적으로 동작함
NOT IN (subquery)	NULL이 하나라도 있으면 전체가 UNKNOWN으로 고정. 결과가 전부 FALSE 취급되어 아무 행도 반환되지 않음

/* 6. EXISTS / NOT EXISTS (Subquery) */
NOT EXISTS는 컬럼을 비교해서 필터링하는 것이 아니라,
외부 쿼리의 각 행에 대해 “조건을 만족하는 관련 행이 존재하는지”를 TRUE/FALSE로 평가하여 필터링한다.
    
/* 7. UPDATE */
UPDATE 테이블명 SET 필드명 = CASE 필드명 WHEN, ELSE, END로 다중행 업데이트 가능

/* 그 외 */
  'SQL은 다중 비교 연산을 한 번에 해석하지 못함. (A = B = C 등)'
  'SELECT 'TEXT' as Column처럼 Literal 값을 필드값으로 반환할 수 있음' 
