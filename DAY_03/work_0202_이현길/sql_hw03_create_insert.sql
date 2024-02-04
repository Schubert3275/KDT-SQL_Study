/*
 * 쇼핑몰 데이터베이스 활용 
 * 
 */ 

create database shoppingmall;
use shoppingmall;

drop table if exists user_table;

CREATE TABLE user_table # 회원 테이블
( userID    CHAR(8) NOT NULL PRIMARY KEY, # 사용자 아이디(PK)
  userName      VARCHAR(10) NOT NULL, # 이름
  birthYear   INT NOT NULL,  # 출생년도
  addr      CHAR(2) NOT NULL, # 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1 CHAR(3), # 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2 CHAR(8), # 휴대폰의 나머지 전화번호(하이픈제외)
  height      SMALLINT,  # 키
  mDate     DATE  # 회원 가입일
);

INSERT INTO user_table (userID, userName, birthYear, addr, mobile1, mobile2, height, mDate)
VALUES
  ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8'),
  ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7'),
  ('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9'),
  ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5'),
  ('KJD', '김제동', 1974, '경남', '' , ''      , 173, '2013-3-3'),
  ('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4'),
  ('SDY', '신동엽', 1971, '경기', NULL , NULL      , 176, '2008-10-10'),
  ('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4'),
  ('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
  ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

#
# buy_table 생성 및 데이터 입력
# 회원 구매 테이블 
#
drop table if exists buy_table;

CREATE TABLE buy_table 
(  num    INT AUTO_INCREMENT NOT NULL PRIMARY KEY, # 순번(PK)
   userID   CHAR(8) NOT NULL, # 아이디(FK)
   prodName   CHAR(6) NOT NULL, #  물품명
   groupName  CHAR(4)  , # 분류
   price      INT  NOT NULL, # 단가
   amount     SMALLINT  NOT NULL, # 수량
   FOREIGN KEY (userID) REFERENCES user_table(userID)
);

INSERT INTO buy_table (num, userID, prodName, groupName, price, amount) 
VALUES
  (NULL, 'KHD', '운동화', NULL   , 30,   2),
  (NULL, 'KHD', '노트북', '전자', 1000, 1),
  (NULL, 'KYM', '모니터', '전자', 200,  1),
  (NULL, 'PSH', '모니터', '전자', 200,  5),
  (NULL, 'KHD', '청바지', '의류', 50,   3),
  (NULL, 'PSH', '메모리', '전자', 80,  10),
  (NULL, 'KJD', '책'    , '서적', 15,   5),
  (NULL, 'LHJ', '책'    , '서적', 15,   2),
  (NULL, 'LHJ', '청바지', '의류', 50,   1),
  (NULL, 'PSH', '운동화', NULL   , 30,   2),
  (NULL, 'LHJ', '책'    , '서적', 15,   1),
  (NULL, 'PSH', '운동화', NULL   , 30,   2);


select * from user_table;
select * from buy_table;