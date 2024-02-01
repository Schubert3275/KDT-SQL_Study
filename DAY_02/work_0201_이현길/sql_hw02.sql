/*  
 * 과제 2. 노벨상 수상자
 */

use sqlclass_db;

select * from nobel;

#select year from nobel order by year asc;

# 1번. 1960년 Physics와 Peace 노벨 수상자 출력 
SELECT year, category, fullname
FROM nobel
WHERE year = 1960 AND (category = 'Physics' or  category='Peace');


# 2번. Albert Einstein이 수상한 연도와 제목 
SELECT year, category, prize_amount, birth_continent, birth_country
FROM nobel
WHERE fullname = 'Albert Einstein';

SELECT year, category, prize_amount, birth_continent, birth_country
FROM nobel
WHERE fullname = 'albert einstein';

# 3번. 1910~2010년까지노벨평화상 수상자 명단을 연도순으로 정렬 후 출력  
SELECT year, fullname, birth_country 
FROM nobel 
WHERE category='Peace' and year between 1910 and 2010 
ORDER BY year asc;

# 4번. 노벨상 수상자 중에서 'John'으로 시작하는 수상자 명단 
SELECT category, fullname FROM nobel
WHERE fullname LIKE 'John%';
 
# 5번. 1964년 수상자 중에서 노벨화학상과 의학상을 제외한 수상자 정보 출력 
# 이름을 기준으로 오름차순 정렬  

SELECT * FROM nobel
WHERE year = 1964
and category not in ('Chemistry','Physiology or Medicine')
ORDER BY fullname asc;

# 6번. 2000년부터 2019년까지 노벨 문학상 수상자 출력 
SELECT year, fullname, gender, birth_country FROM nobel
WHERE category = 'Literature' and (year between 2000 and 2019)
ORDER BY year;
 

 # 7번. 각 분야별 역대 수상자 수를 출력 
SELECT category, count(category) FROM nobel 
GROUP BY category 
ORDER BY count(category) desc;

# 8-1번. 노벨 의학상이 있었던 연도 출력 
SELECT DISTINCT year FROM nobel 
WHERE category = 'Physiology or Medicine';

# 8-2번. 노벨 의학상이 없었던 연도 출력 
SELECT distinct year
FROM nobel
WHERE year not in (SELECT year FROM nobel WHERE category = 'Physiology or Medicine');

# 9번. 노벨 의학상이 없었던 연도의 횟수 출력 
SELECT count(distinct year) as no_medicine_count FROM nobel
WHERE year not in (SELECT distinct year FROM nobel WHERE category = 'Physiology or Medicine');
 
# 10번. 여성 노벨 수상자의 명단을 출력 (연도, 분야, 이름, 출생국)
SELECT fullname,  category, birth_country 
FROM nobel 
WHERE gender='female';


# 11번. 출생 국가별로 그룹화 (출생 국가명, 수상빈도수) 출력 
SELECT birth_country, count(birth_country) FROM nobel
GROUP BY birth_country ORDER BY count(birth_country) DESC;

# 12번 수상자의 출생국가가 'Korea'인 정보 모두 출력  
SELECT * FROM nobel 
WHERE birth_country='Korea';

# 13번. 수상자의 대륙이 (Europe, North America, null)이 아닌 정보 출력 
SELECT * FROM nobel
WHERE birth_continent not in ('Europe', 'North America', '');

# 14번. 수상자의 국가별로 그룹화를 해서 수상횟수가 10회 이상인 국가만 출력 
# group by, having, order by 사용 

SELECT birth_country, count(*) as count
FROM nobel 
GROUP BY birth_country 
HAVING count(*) >=10 ORDER BY count desc;

# 15번. 2회 이상 수상자 중에서 fullname이 공백이 아닌 경우 출력  
SELECT fullname, count(*) as num 
FROM nobel 
GROUP BY fullname 
HAVING (count(*) >= 2) and (fullname <> '') 
ORDER BY fullname asc;
