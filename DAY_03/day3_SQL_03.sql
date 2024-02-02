-- Active: 1706666516440@@127.0.0.1@3306@sakila
/*
 데이터베이스와 SQL - 데이터 생성, 조작과 변환
 */
-- 테이블 생성
USE testdb;

CREATE TABLE string_tbl (
    char_fld CHAR(30),
    vchar_fld VARCHAR(30),
    text_fld TEXT
);

-- 문자열 데이터를 테이블에 추가
-- - 문자열의 길이가 해당 열의 최대 크기를 초과하면 예외 발생
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES (
        'This is char data',
        'This is varchar data',
        'This is text data'
    );

SELECT *
FROM string_tbl;

-- varchar 문자열 처리
-- - update문으로 vchar_fld열 (varchar(30))에 설정 길이보다 더 긴 문자열 저장
-- - MySQL 6.0 이후 기본 모드는 strict 모드로 예외 발생됨
-- - vchar_fld열의 크기를 100으로 늘린 후 실행하면 이상 없음
UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';

-- 작은 따옴표 포함
-- - escape 문자 추가 방법
--   - 작은 따옴표를 하나 더 추가
UPDATE string_tbl
SET text_fld = 'This string didn''t work, but it dose now';

--   - 백슬래시('\') 문자 추가  - 편집기 자동처리문제로 인해 주석처리
-- UPDATE string_tbl
-- SET text_fld = 'This string didn\'t work, but it dose now';
SELECT text_fld
FROM string_tbl;

-- - quote() 내장 함수
-- - 전체 문자열을 따옴표로 묶고, 문자열 내부의 작은 따옴표에 escape 문자를 추가
SELECT QUOTE(text_fld)
FROM string_tbl;

-- length() 함수: 문자열의 개수를 반환
DELETE FROM string_tbl;

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES (
        'This string is 28 characters',
        'This string is 28 characters',
        'This string is 28 characters'
    );

-- - char열의 길이: 빈 공간을 공백으로 채우지만, 조회할 때 char 데이터에서 공백 제거
SELECT LENGTH(char_fld) AS char_length,
    LENGTH(vchar_fld) AS vchar_length,
    LENGTH(text_fld) AS text_length
FROM string_tbl;

-- position() 함수
-- - 부분 문자열의 위치를 반환
-- - MySQL의 문자열 인덱스: 1부터 시작
-- - 부분 문자열을 찾을 수 없는 경우, 0을 반환함
SELECT POSITION('characters' IN vchar_fld)
FROM string_tbl;

-- locate('문자열', 열이름, 시작위치) 함수
-- - 시작위치부터 문자열 검색: 처음 발견되는 인덱스 리턴
SELECT LOCATE('is', vchar_fld, 5)
FROM string_tbl;

SELECT LOCATE('is', vchar_fld, 1)
FROM string_tbl;

-- strcmp('문자열1', '문자열2') 함수: 문자열 비교
-- - 대소문자 구분 안함
-- string_tbl 삭제 후 새로운 데이터 추가
DELETE FROM string_tbl;

INSERT INTO string_tbl(vchar_fld)
VALUES ('abcd'),
    ('xyz'),
    ('QRSTUV'),
    ('qrstuv'),
    ('12345');

-- vchar_fld의 값을 오름차순 정렬
SELECT vchar_fld
FROM string_tbl
ORDER BY vchar_fld;

-- strcmp() 예제
-- - 5개의 서로 다른 문자열 비교
SELECT STRCMP('12345', '12345') 12345_12345,
    STRCMP('abcd', 'xyz') abcd_xyz,
    STRCMP('abcd', 'QRSTUV') abcd_QRSTUV,
    STRCMP('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
    STRCMP('12345', 'xyz') 12345_xyz,
    STRCMP('xyz', 'qrstuw') xyz_qrstuw;

-- like 또는 regexp 연산자 사용
-- - select 절에 like 연산자나 regexp 연산자를 사용
--   - 0 또는 1의 값을 반환
USE sakila;

SELECT name,
    name LIKE '%y' ends_in_y
FROM category;

--   - 'y$': name 컬럼의 값이 'y'로 끝나면 1을 반환
SELECT name,
    name REGEXP 'y$' ends_in_y
FROM category;

-- string_tbl 리셋
USE testdb;

DELETE FROM string_tbl;

INSERT INTO string_tbl(text_fld)
VALUES ('This string was 29 characters');

-- concat(): 문자열 추가 함수
-- - concat() 함수를 사용하여 string_tbl의 text_fld열에 저장된 문자열 수정
--   - 기존 text_fld의 문자열에 ', but it is longer' 문자열 추가
UPDATE string_tbl
SET text_fld = CONCAT(text_fld, ', but it is longer');

SELECT text_fld
FROM string_tbl;

-- concat() 함수 활용
-- - 각 데이터 조각을 합쳐서 하나의 문자열 생성
--   - concat() 함수 내부에서 date(create_date)를 문자열로 변환
USE sakila;

SELECT CONCAT(
        first_name,
        ' ',
        last_name,
        ' has been a customer since ',
        DATE(create_date)
    ) AS cunt_narrative
FROM customer;

-- insert() 함수
-- - 4개의 인수로 구성
-- - insert(문자열, 시작위치, 길이, 새로운 문자열)
--   - 세 번째 인수값(길이) = 0: 새로운 문자열이 삽입
SELECT
INSERT('goodbye world', 9, 0, 'cruel ') AS STRING;

--   - 세 번째 인수값 > 0: 해당 문자열로 대치
SELECT
INSERT('goodbye world', 1, 7, 'hello') AS STRING;

-- replace() 함수
-- - replace(문자열, 기존문자열, 새로운 문자열)
-- - 기존 문자열을 찾아서 제거하고, 새로운 문자열을 삽입
SELECT REPLACE('goodbye world', 'goodbye', 'hello') AS replace_str;

-- substr() 또는 substring() 함수
-- - substr(문자열, 시작위치, 개수)
-- - 문자열에서 시작 위치에서 개수만큼 추출
SELECT SUBSTR('goodbye cruel world', 9, 5);
