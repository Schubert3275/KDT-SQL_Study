"""
SQL 과제 #3
"""
import pymysql
import pandas as pd


def init_db(conn, cur, database, table1, table2):
    """
    데이터베이스와 테이블을 생성하고 각 테이블에 데이터 입력 실행

    conn: 연결 데이터베이스
    cur: 생성된 커서
    database: 생성할 데이터베이스 이름
    table: 생성할 테이블 이름 1, 2
    """
    # 데이터베이스 생성
    create_database(conn, cur, database)

    # 테이블 생성용 쿼리문
    sqlCreateTable = f"""-- sql
        CREATE TABLE {table1} (
            userID CHAR(8) NOT NULL,
            userName VARCHAR(10) NOT NULL,
            birthYear INT NOT NULL,
            addr CHAR(2) NOT NULL,
            mobile1 CHAR(3),
            mobile2 CHAR(8),
            height SMALLINT,
            mDate DATE,
            CONSTRAINT pk_userID PRIMARY KEY (userID)
        )"""
    # 테이블 생성
    create_table(conn, cur, database, table1, sqlCreateTable)

    # 데이터 입력용 쿼리문
    sqlInsertData = f"""-- sql
        INSERT INTO {table1} (userID, userName, birthYear, addr, mobile1, mobile2, height, mDate)
        VALUES ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
            ('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
            ('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
            ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
            ('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
            ('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
            ('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
            ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
            ('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
            ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08')"""
    # 데이터 입력
    insert_data(conn, cur, database, table1, sqlInsertData)

    # 테이블 생성용 쿼리문
    sqlCreateTable = f"""-- sql
        CREATE TABLE {table2} (
            num INT NOT NULL AUTO_INCREMENT,
            userID CHAR(8) NOT NULL,
            prodName CHAR(6) NOT NULL,
            groubName CHAR(4),
            price INT NOT NULL,
            amount SMALLINT NOT NULL,
            CONSTRAINT pk_num PRIMARY KEY (num),
            CONSTRAINT fk_num_userID FOREIGN KEY (userID) REFERENCES user_table (userID)
        )"""
    # 테이블 생성
    create_table(conn, cur, database, table2, sqlCreateTable)

    # 데이터 입력용 쿼리문
    sqlInsertData = f"""-- sql
        INSERT INTO {table2} (num, userID, prodName, groubName, price, amount)
        VALUES (1, 'KHD', '운동화', NULL, 30, 2),
            (2, 'KHD', '노트북', '전자', 1000, 1),
            (3, 'KYM', '모니터', '전자', 200, 1),
            (4, 'PSH', '모니터', '전자', 200, 5),
            (5, 'KHD', '청바지', '의류', 50, 3),
            (6, 'PSH', '메모리', '전자', 80, 10),
            (7, 'KJD', '책', '서적', 15, 5),
            (8, 'LHJ', '책', '서적', 15, 2),
            (9, 'LHJ', '청바지', '의류', 50, 1),
            (10, 'PSH', '운동화', NULL, 30, 2),
            (11, 'LHJ', '책', '서적', 15, 1),
            (12, 'PSH', '운동화', NULL, 30, 2)"""
    # 데이터 입력
    insert_data(conn, cur, database, table2, sqlInsertData)


def create_database(conn, cur, databaseName):
    """
    전달된 이름의 데이터베이스가 있으면 삭제하고 재생성

    conn: 연결 데이터베이스
    cur: 생성된 커서
    database: 생성할 데이터베이스 이름
    """
    try:
        sqlDrop = f"""-- sql
            DROP DATABASE IF EXISTS {databaseName}"""
        sqlCreate = f"""-- sql
            CREATE DATABASE {databaseName}"""

        cur.execute(sqlDrop)
        cur.execute(sqlCreate)
        conn.commit()
        print(f"{databaseName} Database 생성 완료")
    except Exception as e:
        print(e)  # 에러메세지 출력


def create_table(conn, cur, databaseName, tableName, sqlCreate):
    """
    전달된 이름의 테이블이 있으면 삭제하고 재생성

    conn: 연결 데이터베이스
    cur: 생성된 커서
    databaseName: 사용할 데이터베이스 이름
    tableName: 생성할 테이블 이름
    sqlCreate: 테이블 생성용 쿼리문
    """
    try:
        sqlUse = f"""-- sql
            USE {databaseName}"""
        sqlDrop = f"""-- sql
            DROP TABLE IF EXISTS {tableName}"""

        cur.execute(sqlUse)
        cur.execute(sqlDrop)
        cur.execute(sqlCreate)
        conn.commit()
        print(f"{tableName} Table 생성 완료")
    except Exception as e:
        print(e)  # 에러메세지 출력


def insert_data(conn, cur, databaseName, tableName, sqlInsert):
    """
    전달된 테이블에 데이터를 추가

    conn: 연결 데이터베이스
    cur: 생성된 커서
    databaseName: 사용할 데이터베이스 이름
    tableName: 데이터를 추가할 테이블 이름
    sqlInsert: 데이터 추가용 쿼리문
    """
    try:
        sqlUse = f"""-- sql
            USE {databaseName}"""

        cur.execute(sqlUse)
        cur.execute(sqlInsert)
        conn.commit()
        print(f"{tableName} Table 데이터 추가 완료")
    except Exception as e:
        print(e)  # 에러메세지 출력


def join_tables(conn, cur, databaseName, tableName1, tableName2, joinName):
    """
    2개의 테이블과 병합된 테이블 이름을 전달받아 inner join된 VIEW 생성

    conn: 연결 데이터베이스
    cur: 생성된 커서
    databaseName: 사용할 데이터베이스 이름
    tableName: 병합할 테이블 이름 1, 2
    joinName: 병합된 뷰 이름
    """
    try:
        sqlDrop = f"""-- sql
            DROP VIEW IF EXISTS {joinName}"""
        sqlUse = f"""-- sql
            USE {databaseName}"""
        # userID, userName, prodName, addr, 연락처 컬럼을 가지는 뷰 생성
        sqlJoin = f"""-- sql
            CREATE VIEW {joinName} as
            SELECT t1.userID, t1.userName, t2.prodName, t1.addr, concat(t1.mobile1, t1.mobile2) as 연락처
            FROM {tableName1} as t1
            INNER JOIN {tableName2} as t2
            ON t1.userID = t2.userID"""

        cur.execute(sqlDrop)
        cur.execute(sqlUse)
        cur.execute(sqlJoin)
        conn.commit()
    except Exception as e:
        print(e)  # 에러메세지 출력


def display_table(cur, databaseName, tableName, *columns, distinct=False, **clause):
    """
    전달된 테이블을 조건에 따라 편집하여 데이터프레임으로 변환. 화면에 출력

    conn: 연결 데이터베이스
    cur: 생성된 커서
    databaseName: 사용할 데이터베이스 이름
    tableName: 사용할 테이블 이름
    *columns: 테이블에서 SELECT 할 컬럼명. 생략시 전체 컬럼명 출력
    distinct: 중복 제거시 True 입력. 디폴트는 False
    **clause: 테이블 편집을 위해 사용되는 키워드 인자. where, group_by, having, order_by 순서로 입력
    """
    if not columns:
        columns = "*"  # 디폴트는 전체 컬럼
    else:
        columns = ', '.join(columns)  # 가변인수를 문자열로 변환
    if distinct:
        columns = 'DISTINCT ' + columns  # 중복 제거가 필요할 경우 적용
    try:
        sqlUse = f"""-- sql
            USE {databaseName}"""
        # 기본 출력 쿼리문
        sqlDisplay = f"""-- sql
            SELECT {columns} FROM {tableName}"""
        # 키워드 인자에 따라 조건 쿼리문 추가
        if clause:
            for k, v in clause.items():
                if k.lower() == 'where':
                    sqlDisplay += f" WHERE {v}"
                elif k.lower() == 'group_by':
                    sqlDisplay += f" GROUP BY {v}"
                elif k.lower() == 'having':
                    sqlDisplay += f" HAVING {v}"
                elif k.lower() == 'order_by':
                    sqlDisplay += f" ORDER BY {v}"
        # 쿼리문이 제대로 작성되었는지 확인
        # print(sqlDisplay)

        cur.execute(sqlUse)
        cur.execute(sqlDisplay)
        # 조회 결과를 데이터프레임으로 저장
        join_df = pd.DataFrame(cur.fetchall())
        # 컬럼 목록을 문자열로 변환
        text = '\t'.join(join_df.columns)
        print('-' * (len(text)+17))
        print(f'{text}')
        print('-' * (len(text)+17))
        # 데이터를 튜플 형태로 출력
        for i in join_df.index:
            print(f'{tuple(join_df.iloc[i].to_list())}')
    except Exception as e:
        print(e)  # 에러메세지 출력


def main():
    # 데이터베이스 접속
    conn = pymysql.connect(host='localhost', port=3306,
                           user='root', passwd='1234', charset='utf8')
    # 커서를 딕셔너리 형태로 생성
    cur = conn.cursor(pymysql.cursors.DictCursor)

    # 사용할 데이터베이스와 테이블 이름
    database = "shoppingmall"
    table1 = "user_table"
    table2 = "buy_table"

    try:
        # 데이터베이스와 테이블이 생성되어 있는지 체크용
        cur.execute(f"USE {database}")
        cur.execute(f"SELECT * FROM {table1}")
        cur.execute(f"SELECT * FROM {table2}")
    except:
        # 데이터베이스나 테이블이 누락되어 있으면 초기화 실행
        init_db(conn, cur, database)

    # 병합된 테이블 이름 지정
    joinTable = "joined_table"

    # 테이블 병합
    join_tables(conn, cur, database, table1, table2, joinTable)

    print("문제 1번")
    # 내부 조인한 결과에 '연락처' 컬럼 추가
    columns = "userName", "prodName", "addr", "연락처"
    display_table(cur, database, joinTable, *columns)
    print()

    print("문제 2번")
    # userID가 KYM인 사람이 구매한 물건과 회원 정보 출력
    display_table(cur, database, joinTable, where="userID = 'KYM'")
    print()

    print("문제 3번")
    # 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
    display_table(cur, database, joinTable, order_by="userID")
    print()

    print("문제 4번")
    # 쇼핑몰에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력
    columns = "userID", "userName", "addr"
    display_table(cur, database, joinTable, *columns,
                  distinct=True, group_by="userID")
    print()

    print("문제 5번")
    # 쇼핑몰 회원 중에서 주소가 경북과 경남인 회원 정보를 아이디 순으로 출력
    display_table(cur, database, joinTable,
                  where="addr in ('경북', '경남')", order_by="userID")

    # 접속 종료
    cur.close()
    conn.close()


if __name__ == '__main__':
    main()
