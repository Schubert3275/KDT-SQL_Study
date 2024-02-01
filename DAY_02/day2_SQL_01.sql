-- Active: 1706666516440@@127.0.0.1@3306@sakila

# sakila 데이터베이스 선택
# - language 테이블의 전체 목록 보기
USE sakila;
SELECT * FROM language;

# 일부 열(column)만 검색
SELECT language_id, name, last_update FROM language;

SELECT name FROM language;

# 열의 별칭(column alias)
# - 열의 레이블을 지정할 수 있음
# - 출력을 이해하기 쉽게 함
# - AS(as) 키워드 사용: 가독성 향상
SELECT language_id,
    'COMMON' language_usage,
    language_id * 3.14 lang_pi_value,
    upper(name) language_name
FROM language;

# 중복 제거
# - 동일한 배우가 여러 영화에 출연: 중복된 actor_id 발생
#  - all 키워드: 기본값, 명시적으로 지정할 필요가 없음
SELECT actor_id FROM film_actor ORDER BY actor_id;

#  - DISTINCT 키워드 사용: 중복 제거
SELECT DISTINCT actor_id FROM film_actor ORDER BY actor_id;

# 파생 테이블
# - subqurrey(서브 쿼리)
#  - from 절에 위치한 select문(서브 쿼리)은 실행 결과로 테이블을 생성: 파생 테이블
#  - 즉, 다른 테이블과의 상호작용을 할 수 있는 파생 테이블을 생성
SELECT CONCAT(cust.last_name, ', ', cust.first_name) full_name
FROM (
    SELECT first_name, last_name, email
    FROM customer
    WHERE first_name = 'JESSIE'
) as cust;

# 임시 테이블
# - 휘발성의 테이블: 데이터베이스 세션이 닫힐 때 사라짐
CREATE TEMPORARY TABLE actors_j (
    actor_id SMALLINT(5),
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);
DESC actors_j;

INSERT INTO actors_j
    SELECT actor_id, first_name, last_name
    FROM actor
    WHERE last_name LIKE 'J%';

SELECT * FROM actors_j;

# 가상 테이블(View)
# - SQL 쿼리의 결과 셋을 기반으로 만들어진 가상 테이블
# - 실제 데이터가 저장되는 것이 아닌, view를 통해 데이터를 관리
# - 복잡한 쿼리문을 매번 사용하지 않고 가상 테이블로 만들어서 쉽게 접근함
CREATE VIEW cust_vw AS
    select customer_id, first_name, last_name, ACTIVE
    from customer;

SELECT * FROM cust_vw;

SELECT first_name, last_name from cust_vw
WHERE active = 0;

# 테이블 연결
# - JOIN(INNER JOIN): 두 개 이상의 테이블을 묶어서 하나의 결과 집합을 만들어 내는 것
SELECT customer.first_name, customer.last_name,
    TIME(rental.rental_date) as rental_time
FROM customer INNER JOIN rental
    ON customer.customer_id = rental.customer_id
WHERE DATE(rental.rental_date) = '2005-06-14';

# DATETIME 데이터
# - date() 함수 : datetime 데이터에서 date 정보(YYYY-MM-DD)만 추출
SELECT date('2021-07-29 09:02:03');

# - time() 함수 : time 정보(HH:MI:SS)만 추출
select TIME('2021-07-29 09:02:03')

# 테이블 연결 (INNER JOIN) 결과
SELECT customer.first_name, customer.last_name,
    TIME(rental.rental_date) as rental_date
FROM customer INNER JOIN rental
    ON customer.customer_id = rental.customer_id
WHERE DATE(rental.rental_date) = '2005-06-14';

# 테이블 별칭 정의
# - 여러 테이블을 join할 경우, 테이블 및 열 참조 방법
#  - 테이블 이름 및 열 이름 사용
#  - 각 테이블의 별칭을 할당하고 쿼리 전체에서 해당 별칭을 사용: AS 키워드 사용
SELECT c.first_name, c.last_name,
    time(r.rental_date) rental_date
FROM customer c INNER JOIN rental r
    ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14';

SELECT c.first_name, c.last_name,
    TIME(r.rental_date) as rental_date
FROM customer as c INNER JOIN rental as r
    ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14';

# where 절
# - 필터 조건: 조건에 맞는 행의 데이터만 가져옴
# - and, or, not 연산자 사용
SELECT title
FROM film
WHERE rating = 'G' and rental_duration >= 7;

SELECT title, rating, rental_duration
FROM film
where (rating = 'G' and rental_duration >= 7)
    or (rating = 'PG-13' and rental_duration < 4);

# GROUP BY: 열의 데이터를 그룹화
# HAVING
# - 특정 열을 그룹화한 결과에 필터링 조건을 설정: 그룹화 이후에 수행되는 조건 설정
# - WHERE: 그룹화를 하기 전 필터링 조건
SELECT c.first_name, c.last_name, count(*) as 대여횟수
FROM customer as c
    INNER JOIN rental as r
    ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(*) >= 40
ORDER BY COUNT(*) DESC;

# ORDER BY 절
# - 지정된 컬럼(열)을 기준으로 결과를 정렬 (다중 컬럼인 경우, 왼쪽부터 정렬)
# - 오름차순(ACS): 기본 정렬 값, 내림차순(DESC)
SELECT c.first_name, c.last_name,
    TIME(r.rental_date) as rental_time
FROM customer as c INNER JOIN rental as r
    ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY c.last_name, c.first_name ASC;

# 내림차순 정렬: DESC
SELECT c.first_name, c.last_name,
    TIME(r.rental_date) as rental_time
FROM customer as c INNER JOIN rental as r
    ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY TIME(r.rental_date) DESC;  # 대여시간(rental_time)을 기준으로 내림차순 정렬

# 순서를 통한 정렬
# - ORDER BY 다음에 정렬 기준이 되는 컬럼의 순서(index)를 사용
SELECT c.first_name, c.last_name,
    TIME(r.rental_date) as rental_time
FROM customer as c INNER JOIN rental as r
    ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY 1 DESC;  # first_name 컬럼의 index(1)를 기준으로 내림차순 정렬

# 실습 3-1
# - actor 테이블에서 모든 배우의 actor_id, first_name, last_name을 검색하고 last_name, first_name을 기준으로 오름차순 정렬
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name, first_name;  # last_name이 동일한 경우, first_name 순으로 정렬

# 실습 3-2
# - 성이 'WILLIAMS' 또는 'DAVIS'인 모든 배우의 actor_id, first_name, last_name을 검색
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'WILLIAMS' OR last_name = 'DAVIS';

# 실습 3-3
# - rental 테이블에서 2005년 7월 5일 영화를 대여한 고객 ID를 반환하는 쿼리를 작성하고, date()함수로 시간 요소를 무시
SELECT DISTINCT customer_id
FROM rental
WHERE DATE(rental_date) = '2005-07-05';

# 실습 3-4
# - 다음 결과를 참고하여 다중 테이블의 쿼리를 채우세요.
SELECT c.store_id, c.email, r.rental_date, r.return_date
FROM customer as c INNER JOIN rental as r
    ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY return_date DESC;
