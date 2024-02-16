-- Active: 1706666516440@@127.0.0.1@3306@sakila
USE sakila;

SELECT
    customer_id,
    COUNT(*)
FROM
    rental
GROUP BY
    customer_id;

-- 가장 많이 대여한 회원 찾기
SELECT
    customer_id,
    COUNT(*)
FROM
    rental
GROUP BY
    customer_id
ORDER BY
    2 DESC;

-- having절 사용
SELECT
    customer_id,
    COUNT(*)
FROM
    rental
GROUP BY
    customer_id
HAVING
    COUNT(*) >= 40;

-- 암시적 그룹 결과
-- - group by절을 사용하지 않음: 집계 함수에 의해 생성된 값
SELECT
    MAX(amount) AS max_amt,
    MIN(amount) AS min_amt,
    AVG(amount) AS avg_amt,
    SUM(amount) AS tot_amt,
    COUNT(*)    AS num_payments
FROM
    payment;

-- 명시적 그룹
-- - 집계 함수를 적용하기 위해 group by 절에 그룹화할 열의 이름 지정
SELECT
    customer_id,
    MAX(amount) AS max_amt,
    MIN(amount) AS min_amt,
    AVG(amount) AS avg_amt,
    SUM(amount) AS tot_amt,
    COUNT(*)    AS num_payments
FROM
    payment
GROUP BY
    customer_id;

-- 단일 열 그룹화
USE sakila;

SELECT
    actor_id,
    COUNT(*)
FROM
    film_actor
GROUP BY
    actor_id;

-- 다중 열 그룹화
SELECT
    fa.actor_id,
    f.rating,
    COUNT(*)
FROM
    film_actor AS fa
    INNER JOIN film AS f ON fa.film_id = f.film_id
GROUP BY
    fa.actor_id,
    f.rating
ORDER BY
    1,
    2;

SELECT
    EXTRACT(
        YEAR
        FROM
            rental_date
    ) AS years,
    COUNT(*) AS how_many
FROM
    rental
GROUP BY
    EXTRACT(
        YEAR
        FROM
            rental_date
    );

-- with rollup 옵션
-- - group by 결과로 출력된 항목들의 합계를 나타내는 방법
SELECT
    fa.actor_id,
    f.rating,
    COUNT(*)
FROM
    film_actor AS fa
    INNER JOIN film AS f ON fa.film_id = f.film_id
GROUP BY
    fa.actor_id,
    f.rating
WITH
    ROLLUP
ORDER BY
    1,
    2;

-- 두 가지 필터 조건 사용
SELECT fa.actor_id, f.rating, COUNT(*)
FROM
    film_actor AS fa
    INNER JOIN film AS f ON fa.film_id = f.film_id
WHERE f.rating IN ('G', 'PG')
GROUP BY fa.actor_id, f.rating
HAVING COUNT(*) > 9;
