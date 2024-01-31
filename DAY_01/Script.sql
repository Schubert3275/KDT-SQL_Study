SHOW DATABASES;

USE sakila;

SELECT NOW();

CREATE DATABASE testdb;
USE TESTDB;

# person 테이블 생성
# CONSTRICT pk_person: 제약 조건의 이름 설정
DROP TABLE IF EXISTS person;
CREATE TABLE person(
    person_id SMALLINT UNSIGNED,
    fname VARCHAR(20),
    lname VARCHAR(20),
    eye_color ENUM('BR', 'BL', 'GR'),
    birth_date DATE,
    street VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(20),
    contry VARCHAR(20),
    postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id)
    );

DESC person;

DROP TABLE IF EXISTS favorite_food;
CREATE TABLE favorite_food(
    person_id SMALLINT UNSIGNED,
    food VARCHAR(20),
    CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
    CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id) REFERENCES person(person_id)
    );

DESC favorite_food;

set foreign_key_checks=0;
ALTER TABLE person MODIFY person_id smallint unsigned auto_increment;
set foreign_key_checks=1;

INSERT INTO person(
    person_id, fname, lname, eye_color, birth_date
    )
    VALUES (NULL, 'Willwam', 'Turner', 'BR', '1972-05-27');

SELECT * FROM person;

SELECT person_id, fname, lname, birth_date FROM person;

SELECT person_id, fname, lname, birth_date
FROM person WHERE lname = 'Turner';

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'pizza');

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'cookies');

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'nachos');

DELETE FROM favorite_food WHERE person_id=1;

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'pizza'),
       (1, 'cookies'),
       (1, 'nachos');

SELECT food FROM favorite_food
WHERE person_id=1 ORDER BY food;

INSERT INTO person(
    person_id, fname, lname, eye_color, birth_date,
    street, city, state, contry, postal_code
    )
    VALUES (
    NULL, 'Susan' ,'Smith', 'BL', '1975-11-02',
    '23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

SELECT person_id, fname, lname, birth_date FROM person;

UPDATE person
SET street = '1225 Tremon St.',
    city = 'Boston',
    state = 'MA',
    contry = 'USA',
    postal_code = '02138'
WHERE person_id = 1;

SELECT * FROM person;

# drop table person;

INSERT INTO person (person_id, fname, lname) VALUES (NULL, 'Kevin', 'Kern');

SELECT * FROM person;

INSERT INTO favorite_food (person_id, food) VALUES (3, 'lasagna');
SELECT * FROM favorite_food;

UPDATE person SET birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
WHERE person_id = 1;

DESC person;
