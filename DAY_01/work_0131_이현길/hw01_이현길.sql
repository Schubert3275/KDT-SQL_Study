-- Active: 1706666516440@@127.0.0.1@3306@sqlclass_db
/*
 * SQL 과제 #1
 */
 
SHOW DATABASES;

USE sqlclass_db;

# world 테이블이 존재하면 삭제 
drop table if exists world;

# 테이블 작성
CREATE Table world(
    country VARCHAR(30),
    continent VARCHAR(30),
    area INT,
    population INT,
    capital VARCHAR(30),
    top_level_domain VARCHAR(3)
);

# 데이터 추가
INSERT INTO world(country, continent, area, population, capital, top_level_domain)
VALUES ('Afghanistan', 'Asia', 652230, 25500100, 'Kabul', '.af'),
        ('Algeria', 'Africa', 2381741, 38700000, 'Algiers', '.dz'),
        ('New Zealand', 'Oceania', 270467, 4538520, 'Wellington', '.nz'),
        ('Australia', 'Oceania', 7692024, 23545500, 'Canberra', '.au'),
        ('Brazil', 'South America', 8515767, 202794000, 'Brasilia', '.br'),
        ('China', 'Asia', 9596961, 1365370000, 'Beijing', '.cn'),
        ('India', 'Asia', 3166414, 1246160000, 'New Delhi', '.in'),
        ('Russia', 'Eurasia', 17125242, 146000000, 'Moscow', '.ru'),
        ('France', 'Europe', 640679, 65906000, 'Paris', '.fr'),
        ('Germany', 'Europe', 357114, 80716000, 'Berlin', '.de'),
        ('Denmark', 'Europe', 43094, 5634437, 'Copenhagen', '.dk'),
        ('Norway', 'Europe', 323802, 5124383, 'Oslo', '.no'),
        ('Sweden', 'Europe', 450295, 9675885, 'Stockholm', '.se'),
        ('South Korea', 'Asia', 100210, 50423955, 'Seoul', '.kr'),
        ('Canada', 'North America', 9984670, 35427524, 'Ottawa', '.ca'),
        ('United States', 'North America', 9826675, 318320000, 'Washington, D.C.', '.us'),
        ('Armenia', 'Eurasia', 29743, 3017400, 'Yerevan', '.am');

# 2.1 전체 테이블 출력
SELECT * FROM world;

# 2.2 continent의 값이 Euripe인 country, capital, top_level_domain 출력
SELECT * FROM world
WHERE continent = 'Europe';

# 2.3 Asia 국가의 국가명, 인구, 수도명을 인구가 많은 순서로 출력
SELECT country, population FROM world
WHERE continent = 'Asia' ORDER BY population DESC;

# 2.4 전체 국가의 면적(area)를 내림차순으로 정렬하여 출력
SELECT country, continent, area FROM world
ORDER BY area DESC;

# 2.5 전체 국가의 국가명, top_level_domain을 오름차순으로 정렬하여 출력
SELECT country, top_level_domain FROM world
ORDER BY top_level_domain ASC;
