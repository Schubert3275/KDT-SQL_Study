-- Active: 1706666516440@@127.0.0.1@3306@sakila
/*
데이터베이스와 SQL - 필터링
*/
USE sakila;

# 범위 조건
# - 해당 식이 특정 범위 내에 있는지 확인
SELECT customer_id, rental_date
FROM rental
WHERE rental_date < '2005-05-25';

# - 해당 날짜만 검색: date(rental_date) = '2005-05-25'
SELECT customer_id, rental_date
FROM rental
WHERE rental_date <= '2005-06-16'     # rental_date 컬럼은 datetime 속성으로 날짜와 시간을 같이 포함
    and rental_date >= '2005-06-14';  # 2005-06-16은 포함되지 않음 (시간 정보 때문)

# - 2005년 6월 14일부터 6월 16일까지의 데이터를 출력하기 위해
# - date(rental_date)를 사용: 정확한 날짜만 추출
SELECT customer_id, rental_date
FROM rental
WHERE DATE(rental_date) <= '2005-06-16'
    and DATE(rental_date) >= '2005-06-14';

# BETWEEN 연산자
# - BETWEEN [범위의 하한값] and [범위의 상한값]
SELECT customer_id, rental_date
FROM rental
WHERE DATE(rental_date) BETWEEN '2005-06-14' and '2005-06-16';

# - 숫자 범위 사용
#   - 하한값과 상한값이 범위에 포함됨
SELECT customer_id, payment_date, amount
FROM payment
WHERE amount BETWEEN 10.0 AND 11.99;

# 문자열 범위
# - last_name이 'FA'와 'FRB'로 시작하는 데이터 리턴
SELECT last_name, first_name
from customer
WHERE last_name BETWEEN 'FA' AND 'FRB';

# OR 또는 IN() 연산
# - 유한한 값의 집합으로 제한
# - IN() 연산
#   - 컬럼명 IN (값1, 값2, ...)
#   - 지정한 컬럼의 값이 특정 값에 해당되는 조건을 만들 때 사용 (or 대신 사용)
SELECT title, rating
FROM film
WHERE rating = 'G' or rating = 'PG';

SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG');

# 서브 쿼리 사용
# - 값의 집합을 생성할 수 있음
SELECT title, rating
FROM film
WHERE rating IN (SELECT rating FROM film WHERE title LIKE '%PET%');

# - 서브 쿼리 내용
#   - 'PET'을 포함하는 영화 제목을 찾고, 그 영화 제목의 rating을 반환 ('P', 'PG')
#   -> 'PET%': PET로 시작하는 단어
#   -> '%PET': PET로 끝나는 단어
#   -> '%PET%': PET를 포함하는 단어
SELECT rating FROM film WHERE title LIKE '%PET%';

# not in 사용
# - 표현식 집합 내에 존재하지 않음
SELECT title, rating
FROM film
WHERE rating NOT IN ('PG-13', 'R', 'NC-17');

# 문자열 부분 가져오기
# - left(문자열, n)
#   - 문자열의 가장 왼쪽부터 n개 가져옴
SELECT left('abcdefg', 3);

# - mid(문자열, 시작 위치, n)
#   - substr(문자, 시작 위치, n)도 동일한 기능 수행: 시작 위치는 1부터 시작
SELECT mid('abcdefg', 2, 3);

# - right(문자열, n)
#   - 문자열의 가장 오른쪽부터 n개 가져옴
SELECT right('abcdefg', 2);

# 와일드 카드
# - '_': 정확히 한 문자 (underscore)
# - '%': 개수에 상관없이 모든 문자 포함

# 일치 조건(matching condition)
# - 와일드 카드 사용시 LIKE 연산자를 사용
#   - '_A_T%S': 두 번째 위치에 'A', 네 번째 위치에 'T'를 포함하며 마지막은 'S'로 끝나는 문자열
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';

# - last_name이 'Q'로 시작하거나 'Y'로 시작하는 고객 이름 검색
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'Q%' or last_name LIKE 'Y%';

# 정규 표현식 사용
# - '^[QY]': Q 또는 Y로 시작하는 단어 검색
SELECT last_name, first_name
FROM customer
WHERE last_name REGEXP '^[QY]';

# NULL 확인 방법
# - IS NULL 사용 (=NULL)
SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date IS NULL;

# - IS NOT NULL 열에 값이 할당되어 있는 경우 (NULL이 아닌 경우)
SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date IS NOT NULL;

# NULL과 조건 조합
# - 2005년 5월에서 8월 사이에 반납되지 않은 대여 정보 검색
#  - 반납이 되지 않은 경우, 반납 날짜의 값이 NULL
#  - 또는 반납 날짜가 2005년 5월 ~ 2005년 8월 사이가 아닌 경우
SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date IS NULL
    OR DATE(rental_date) NOT BETWEEN '2005-05-01' AND '2005-09-01';

# 실습 4-1 서브셋
SELECT payment_id, customer_id, amount, DATE(payment_date) AS payment_date
FROM payment
WHERE (payment_id BETWEEN 101 and 120);

# 실습 4-1
# - 아래의 필터조건에 따라 반환되는 payment_id는 무엇입니까?
#  - customer_id가 5가 아니고
#  - amount가 8보다 크거나 payment_date가 2005년 8월 23일인 경우
SELECT payment_id, customer_id, amount, DATE(payment_date) payment_date
FROM payment
WHERE (payment_id BETWEEN 101 and 120)
    and customer_id != 5 and (amount > 8 or DATE(payment_date) = '2005-08-23');

# 실습 4-2
# - 다음 필터조건에 따라 반환되는 payment_id는 무엇입니까?
#  - customer_id는 5이고
#  - amount가 6보다 크거나 payment_date가 2005년 6월 19일이 아닌 payment_id
SELECT payment_id, customer_id, amount, DATE(payment_date) payment_date
FROM payment
WHERE (payment_id BETWEEN 101 and 120)
    and customer_id = 5 and NOT (amount > 6 or DATE(payment_date) = '2005-06-19');

# 실습 4-3
# - payments 테이블에서 금액이 1.98, 7.98 또는 9.98인 모든 행을 검색하는 쿼리
SELECT amount
FROM payment
WHERE amount IN (1.98, 7.98, 9.98);
