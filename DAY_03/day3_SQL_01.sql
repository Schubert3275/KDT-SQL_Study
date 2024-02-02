-- Active: 1706666516440@@127.0.0.1@3306@sakila
/*
 데이터베이스와 SQL - 다중 테이블 쿼리
 */
USE sakila;

-- 교차 조인
-- - customer 및 address 테이블을 교차 조인
--   - 결합(join)의 조건 없이 모든 행을 결합
--     - 조인의 조건(on)이 없음
SELECT c.first_name,
    c.last_name,
    a.address
FROM customer AS c
    CROSS JOIN address AS a;

SELECT COUNT(*)
FROM customer AS c
    JOIN address AS a;

-- 내부 조인
-- - customer 테이블의 address_id와 address 테이블의 address_id가 같은 경우에만 JOIN
SELECT c.first_name,
    c.last_name,
    a.address
FROM customer AS c
    INNER JOIN address AS a ON c.address_id = a.address_id;

SELECT COUNT(*)
FROM customer AS c
    INNER JOIN address AS a ON c.address_id = a.address_id;

-- 세 개의 테이블 조인
-- - Join 과정에서 from절의 테이블의 순서는 중요하지 않음: 데이터베이스 내부에서 결정
SELECT c.first_name,
    c.last_name,
    ct.city,
    a.address,
    a.district,
    a.postal_code
FROM customer AS c
    INNER JOIN address AS a ON c.address_id = a.address_id
    INNER JOIN city AS ct ON a.city_id = ct.city_id;

-- 서브 쿼리 사용
-- - 서브 쿼리(addr) 결과를 customer 테이블과 inner join
SELECT c.first_name,
    c.last_name,
    addr.address,
    addr.city,
    addr.district
FROM customer AS c
    INNER JOIN (
        SELECT a.address_id,
            a.address,
            ct.city,
            a.district
        FROM address AS a
            INNER JOIN city AS ct ON a.city_id = ct.city_id
        WHERE a.district = 'California'
    ) AS addr ON c.address_id = addr.address_id;

-- - 서브 쿼리만 단독으로 실행
--   - address 테이블과 city 테이블을 내부 조인
--   - 필터링 조건: district의 이름이 'California'
SELECT a.address_id,
    a.address,
    ct.city,
    a.district
FROM address AS a
    INNER JOIN city AS ct ON a.city_id = ct.city_id
WHERE a.district = 'California';

-- 테이블 재사용
-- - 여러 테이블을 join할 경우, 같은 테이블을 두 번 이상 join할 수 있음
SELECT f.title
FROM film AS f
    INNER JOIN film_actor AS fa ON f.film_id = fa.film_id
    INNER JOIN actor AS a ON fa.actor_id = a.actor_id
WHERE (
        (
            a.first_name = 'CATE',
            AND a.last_name = 'MCQUEEN'
        )
        OR (
            a.first_name = 'CUBA'
            AND a.last_name = 'BIRCH'
        )
    ) -- 두 배우가 같이 출연한 영화면 검색
    -- - film 테이블에서 film_actor 테이블에 두 행(두 배우)가 있는 모든 행을 검색
    --   - 같은 테이블을 여러번 사용하기 때문에 테이블 별칭 사용
SELECT f.title
FROM film AS f
    INNER JOIN film_actor AS fa1 ON f.film_id = fa1.film_id
    INNER JOIN actor a1 ON fa1.actor_id = a1.actor_id -- film, film_actor, actor 내부 조인 #1
    INNER JOIN film_actor AS fa2 ON f.film_id = fa2.film_id
    INNER JOIN actor a2 ON fa2.actor_id = a2.actor_id -- film, film_actor, actor 내부 조인 #2
WHERE (
        (
            a1.first_name = 'CATE'
            AND a1.last_name = 'MCQUEEN'
        )
        AND (
            a2.first_name = 'CUBA'
            AND a2.last_name = 'BIRCH'
        )
    );

-- sqlclass_db 사용
USE sqlclass_db;

CREATE TABLE customer (
    customer_id SMALLINT UNSIGNED,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_date DATE,
    spouse_id SMALLINT UNSIGNED,
    CONSTRAINT PRIMARY KEY (customer_id)
);

-- sqlclass_db 데이터베이스에 생성된 customer 테이블 확인
DESC customer;

-- customer 테이블에 데이터 추가
INSERT INTO customer (
        customer_id,
        first_name,
        last_name,
        birth_date,
        spouse_id
    )
VALUES (1, 'John', 'Mayer', '1983-05-12', 2),
    (2, 'Mary', 'Mayer', '1990-07-30', 1),
    (3, 'Lisa', 'Ross', '1989-04-15', 5),
    (4, 'Anna', 'Timothy', '1988-12-26', 6),
    (5, 'Tim', 'Ross', '1957-08-15', 3),
    (6, 'Steve', 'Donell', '1967-07-09', 4);

INSERT INTO customer (
        customer_id,
        first_name,
        last_name,
        birth_date
    )
VALUES (7, 'Donna', 'Trapp', '1978-06-23');

SELECT *
FROM customer;

-- self-join 예제
SELECT cust.customer_id,
    cust.first_name,
    cust.last_name,
    cust.birth_date,
    cust.spouse_id,
    spouse.first_name AS spouse_first_name,
    spouse.last_name AS spouse_last_name
FROM customer AS cust
    JOIN customer AS spouse ON cust.spouse_id = spouse.customer_id;

-- 실습 5-2
-- - JOHN이라는 이름의 배우가 출연한 모든 영화의 제목을 출력
USE sakila;

SELECT f.title
FROM film AS f
    INNER JOIN film_actor AS fa ON f.film_id = fa.film_id
    INNER JOIN actor AS a ON fa.actor_id = a.actor_id
WHERE a.first_name = 'JOHN';

-- 같은 도시에 있는 모든 주소를 반환하는 쿼리 작성
-- - address 테이블을 self-join, 각 행에는 서로 다른 주소가 포함
SELECT a1.address AS addr1,
    a2.address AS addr2,
    a1.city_id,
    a1.district
FROM address AS a1
    INNER JOIN address AS a2
WHERE (a1.city_id = a2.city_id)
    AND (a1.address_id != a2.address_id);
