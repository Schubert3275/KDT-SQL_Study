"""
    테이블 생성
"""
import pymysql


def create_table(conn, cur):
    try:
        query1 = """-- sql
            drop table if exists customer"""
        query2 = """-- sql
            create table customer (
            name varchar(10),
            category smallint,
            region varchar(10)
            )"""

        cur.execute(query1)
        cur.execute(query2)
        conn.commit()
        print("Table 생성 완료")
    except Exception as e:
        print(e)


def main():
    # 데이터베이스(sqlclass_db) 연결
    conn = pymysql.connect(host='localhost', port=3306,
                           user='root', passwd='1234', db='sqlclass_db', charset='utf8')

    # cursor 객체 생성
    cur = conn.cursor()

    # 테이블 생성 함수 호출
    create_table(conn, cur)

    # 연결 종료
    cur.close()
    conn.close()
    print("Database 연결 종료")


if __name__ == "__main__":
    main()
