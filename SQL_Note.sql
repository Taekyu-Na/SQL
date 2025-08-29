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

/* 3. COUNT() 관련 */
  '3.1 COUNT() 실행 위치'
COUNT()는 GROUP BY 이후에 생기는 값인데
WHERE는 그 이전에 실행되므로 COUNT() 값이 아직 없음

/* 그 외 */
  'SQL은 다중 비교 연산을 한 번에 해석하지 못함. (A = B = C 등)'
