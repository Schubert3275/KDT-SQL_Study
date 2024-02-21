## SQL

<details>
<summary>사용 교재</summary>

![](./images/러닝%20SQL.png)

</details>

### DAY_01

---

<details>
<summary>데이터베이스와 SQL: MySQL 설치 및 설정</summary>

> -   MySQL

</details>
<details>
<summary>데이터베이스와 SQL: 데이베이스 소개</summary>

> -   데이터베이스 소개
> -   SQL
> -   MySQL

</details>
<details>
<summary>데이터베이스와 SQL: 데이터베이스 생성과 데이터 추가</summary>

> -   mysql 명령행 도구 사용 방법
> -   MySQL 자료형
> -   테이블 생성
> -   테이블 수정

</details>

---

| 파일명                   | 내용                            |
| ------------------------ | ------------------------------- |
| `DAY_01\day1_SQL_01.sql` | 데이터베이스 생성과 데이터 추가 |

#### 실습과제 DAY_01

---

    1. 과제용 데이터베이스를 생성하고, 테이블을 입력, 각 조건에 따라 출력
    2. 주어진 테이블로 딕셔너리를 생성하고, 각 조건에 따라 출력하는 프로그램 작성

### DAY_02

---

<details>
<summary>데이터베이스와 SQL: 쿼리 입문</summary>

> -   쿼리 절
> -   Select 절
> -   From 절
> -   Where 절
> -   Group By 절과 having 절
> -   Order By 절

</details>
<details>
<summary>데이터베이스와 SQL: 필터링</summary>

> -   조건 평가
> -   조건 작성
> -   조건 유형
> -   Null

</details>

---

| 파일명                   | 내용      |
| ------------------------ | --------- |
| `DAY_02\day2_SQL_01.sql` | 쿼리 입문 |
| `DAY_02\day2_SQL_02.sql` | 필터링    |

#### 실습과제 DAY_02

---

    1. sqlclass_db 데이터베이스에 제공된 nobel_v2.csv파일을 import하여 각각 nobel 테이블을 생성하고 아래 내용에 대해 쿼리를 작성하시오.

### DAY_03

---

<details>
<summary>데이터베이스와 SQL: 다중 테이블 쿼리</summary>

> -   조인(join): 내부 조인
> -   세 개 이상 테이블 조인
> -   셀프 조인

</details>
<details>
<summary>데이터베이스와 SQL: 집합 연산자</summary>

> -   집합 이론
> -   집합 이론 실습
> -   집합 연산자
> -   집합 연산 규칙

</details>
<details>
<summary>데이터베이스와 SQL: 데이터 생성, 조작과 변환</summary>

> -   문자열 데이터 처리
> -   숫자 데이터 처리
> -   시간 데이터 처리
> -   변환 함수

</details>
<details>
<summary>데이터베이스와 SQL: Python과 MySQL 연동</summary>

> -   라이브러리 설치
> -   MySQL 연동

</details>

---

| 파일명                      | 내용                     |
| --------------------------- | ------------------------ |
| `DAY_03\day3_SQL_01.sql`    | 다중 테이블 쿼리         |
| `DAY_03\day3_SQL_02.sql`    | 집합 연산자              |
| `DAY_03\day3_SQL_03.sql`    | 데이터 생성, 조작과 변환 |
| `DAY_03\day3_pymysql_01.py` | pymysql.connect() 함수   |
| `DAY_03\day3_pymysql_02.py` | 복잡한 쿼리 실행         |
| `DAY_03\day3_pymysql_03.py` | 테이블 생성              |
| `DAY_03\day3_pymysql_04.py` | execute() 예제           |
| `DAY_03\day3_pymysql_05.py` | executemany()            |
| `DAY_03\day3_pymysql_06.py` | UPDATE, DELETE           |

#### 실습과제 DAY_03

---

    1. 2개의 테이블을 생성하고 주어진 문제에 대한 sql문장을 작성하시오.

### DAY_04

---

<details>
<summary>파이썬 프로그래밍: 파일과 예외처리</summary>

> -   파일 읽고 쓰기
> -   예외처리

</details>
<details>
<summary>데이터베이스와 SQL: 그룹화와 집계</summary>

> -   그룹화의 개념
> -   집계 함수
> -   그룹 생성
> -   그룹 필터조건

</details>

---

| 파일명                      | 내용                        |
| --------------------------- | --------------------------- |
| `DAY_04\binary_filecopy.py` | 이미지 파일 복사            |
| `DAY_04\pickle_object.py`   | 객체 저장                   |
| `DAY_04\exception01.py`     | 예외 처리 ZeroDivisionError |
| `DAY_04\exception02.py`     | 예외 처리 ValueError        |
| `DAY_04\finally01.py`       | 예외 처리 finally           |
| `DAY_04\count_letter.py`    | 각 문자 횟수 세기           |
| `DAY_04\day4_SQL_01.sql`    | 타입 캐스팅                 |
| `DAY_04\day4_SQL_02.sql`    | 그룹화와 집계               |
