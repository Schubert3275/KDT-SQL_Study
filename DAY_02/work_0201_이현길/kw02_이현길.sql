-- Active: 1706666516440@@127.0.0.1@3306@sqlclass_db
/*
SQL 과제 #2
*/

USE sqlclass_db;

SHOW TABLES;

SELECT * FROM nobel;

# 1) 1960년에 노벨상 물리학상 또는 노벨 평화상을 수상한 사람의 정보를 출력
# - 출력 컬럼: year, category, fullname
SELECT year, category, fullname
FROM nobel
WHERE year = 1960 and category in ('Physics', 'Peace');

# 2) Albert Einstein이 수상한 연도와 수상 분야(category), 출생대륙, 출생국가를 출력
# - 출력 컬럼: year, category, birth_continent, birth_country
SELECT year, category, birth_continent, birth_country
FROM nobel
WHERE fullname = 'Albert Einstein';

# 4) 전체 테이블에서 수상자 이름이 ‘John’으로 시작하는 수상자 모두 출력
# - 출력 컬럼: category, fullname
SELECT category, fullname
FROM nobel
WHERE fullname LIKE 'John%';


# 5) 1964년 수상자 중에서 노벨화학상과 의학상(‘Physiology or Medicine’)을 제외한
#    수상자의 모든 정보를 수상자 이름을 기준으로 오름차순으로 정렬 후 출력
SELECT *
FROM nobel
WHERE year = 1964 and category != 'Physiology or Medicine'
ORDER BY fullname;

# 6) 2000년부터 2019년까지 노벨 문학상 수상자 명단 출력
# - 출력 컬럼: year, fullname, gender, birth_country
SELECT year, fullname, gender, birth_country
FROM nobel
WHERE year BETWEEN 2000 and 2019 and category = 'Literature';

# 7) 각 분야별 역대 수상자의 수를 내림차순으로 정렬 후 출력(group by, order by)
SELECT category, count(*) prize_amount
FROM nobel
GROUP BY category
ORDER BY prize_amount DESC;

# 8) 노벨 의학상이 있었던 연도를 모두 출력 (distinct) 사용
CREATE VIEW year_medicine AS
    SELECT DISTINCT year
    FROM nobel
    WHERE category = 'Physiology or Medicine';

CREATE VIEW year_non_medicine AS
    SELECT DISTINCT year
    FROM nobel
    WHERE year NOT IN (SELECT * FROM year_medicine);

SELECT *
FROM year_medicine

# 9) 노벨 의학상이 없었던 연도의 총 회수를 출력
SELECT COUNT(year) as 횟수
FROM year_non_medicine;


# 10) 여성 노벨 수상자의 명단 출력
# - 출력 컬럼: fullname, category, birth_country
SELECT fullname, category, birth_country
FROM nobel
WHERE gender = 'Female';

# 11) 수상자들의 출생 국가별 횟수 출력
# - 출력 컬럼: birth_country, 횟수
SELECT birth_country, COUNT(*) 횟수
FROM nobel
GROUP BY birth_country;

# 12) 수상자의 출생 국가가 ‘Korea’인 정보 모두 출력
SELECT *
FROM nobel
WHERE birth_country = 'Korea';

# 13) 수상자의 출신 국가가 (‘Europe’, ‘North America’, 공백)이 아닌 모든 정보 출력
SELECT *
FROM nobel
WHERE birth_continent NOT IN ('Europe', 'North America', '');

# 14) 수상자의 출신 국가별로 그룹화를 해서 수상 횟수가 10회 이상인 국가의 모든 정보
#     출력하고 국가별 수상횟수의 역순으로 출력
SELECT birth_country, count(*) 횟수
FROM nobel
GROUP BY birth_country
HAVING 횟수 >= 10
ORDER BY 횟수 DESC;

# 15) 2회 이상 수상자 중에서 fullname이 공백이 아닌 경우를 출력하는데, fullname의
#     오름차순으로 출력
# - 출력 컬럼: fullname, 횟수
SELECT fullname, count(*) 횟수
FROM nobel
WHERE fullname NOT IN ('')
GROUP BY fullname
HAVING 횟수 >= 2
ORDER BY fullname;
