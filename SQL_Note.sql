/* 1. Date 관련 */
  '1.1 연/월/일 추출하기'
MySQL에서 date 타입 필드에서 특정 연/월/일를 가져올때는 아래처럼 가져올 수 있음.
SELECT DATE_FORMAT(TEST, '%Y-%m')

  '1.2 일자 더하기/빼기'
MySQL에서 일자 더하고 뺄 때,
DATE_ADD/SUB(기준 일자, INTERVAL 1 SECOND/MINUTE/HOUR/DAY/MONTH/YEAR)
