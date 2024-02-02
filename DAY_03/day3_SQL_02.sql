-- Active: 1706666516440@@127.0.0.1@3306@sakila
/*
 데이터베이스와 SQL - 집합 연산자
 */
USE sakila;

-- 집합 연산 규칙
-- - 두 데이터셋 모두 같은 수의 열(column)을 가져야 됨
-- - 두 데이터셋의 각 열의 자료형은 서로 동일해야 됨
SELECT 1 AS num,
    'abc' AS str
UNION
SELECT 9 AS num,
    'xyz' AS str;

-- customer 테이블과 actor 테이블 union all 연산 수행
SELECT 'CUST' type1,
    c.first_name,
    c.last_name
FROM customer c
UNION ALL
SELECT 'ACTR' type1,
    a.first_name,
    a.last_name
FROM actor a;

-- actor 테이블에 union all 연산 수행
-- - 중복 항목 제거 안함 (actor 테이블의 총 개수: 200개)
-- - 총 데이터수가 400개로 늘어남
SELECT 'ACTR1' AS TYPE,
    a.first_name,
    a.last_name
FROM actor a
UNION ALL
SELECT 'ACTR2' AS TYPE,
    a.first_name,
    a.last_name
FROM actor a;

-- customer 테이블과 actor 테이블에서
-- - 이름이 'J'로 시작하고 성은 'D'로 시작하는 사람들의 합집합: union all (중복)
SELECT c.first_name,
    c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
UNION ALL
SELECT a.first_name,
    a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%';

-- union
-- - 중복 데이터 제거
SELECT c.first_name,
    c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
UNION
SELECT a.first_name,
    a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%';

-- INTERSECT 연산자
-- - MySQL 8.0.31 버전에서 지원
-- - inner join으로 동일한 결과를 얻을 수 있음
SELECT c.first_name,
    c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
INTERSECT
SELECT a.first_name,
    a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%';

SELECT c.first_name,
    c.last_name
FROM customer c
    INNER JOIN actor a ON (c.first_name = a.first_name)
    AND (c.last_name = a.last_name)
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%';

-- EXCEPT 연산자
-- - MySQL 8.0.31 버전에서 지원
--   - A EXCEPT B: A의 결과에 포함된 B의 내용 제거
SELECT a.first_name,
    a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%';

SELECT c.first_name,
    c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%';

SELECT a.first_name,
    a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%'
EXCEPT
SELECT c.first_name,
    c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%';

-- 복합 쿼리의 결과 정렬
-- - order by 절을 쿼리 마지막에 추가
--   - 열 이름 정의는 복합 쿼리의 첫 번째 쿼리에 있는 열의 이름을 사용해야 됨
SELECT a.first_name AS fname,
    a.last_name AS lname
FROM actor a
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%'
UNION ALL
SELECT c.first_name AS fname,
    c.last_name AS lname
FROM customer c
WHERE c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
ORDER BY lname,
    fname;

-- 집합 연산의 순서
-- - 복합 쿼리는 위에서 아래의 순서대로 실행
-- - 예외: intersect 연산자가 다른 집합 연산자보다 우선 순위가 높음
SELECT a.first_name,
    a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%'
UNION ALL
SELECT a.first_name,
    a.last_name
FROM actor a
WHERE a.first_name LIKE 'M%'
    AND a.last_name LIKE 'T%'
UNION
SELECT c.first_name,
    c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%';

-- 실습 6-2
-- - actor와 customer 테이블에서 성이 L로 시작하는 사람의 이름과 성을 찾는 복합 쿼리 작성
SELECT first_name,
    last_name
FROM actor
WHERE last_name LIKE 'L%'
UNION
SELECT first_name,
    last_name
FROM customer
WHERE last_name LIKE 'L%';

-- 실습 6-3
-- - last_name 열을 기준으로 실습 6-2의 결과를 오름차순 정렬하시오.
SELECT first_name,
    last_name
FROM actor
WHERE last_name LIKE 'L%'
UNION
SELECT first_name,
    last_name
FROM customer
WHERE last_name LIKE 'L%'
ORDER BY last_name;
