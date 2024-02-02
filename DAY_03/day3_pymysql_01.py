"""
    pymysql.connect() 함수
    - host: DB가 존재하는 서버의 주소(localhost 또는 IP주소)
    - user: 사용자 ID, db: 연결할 데이터베이스 이름
    - 리턴: Connection 객체
"""
import pymysql
import pandas as pd

conn = pymysql.connect(host='localhost', port=3306,
                       user='root', passwd='1234', db='sakila', charset='utf8')

cur = conn.cursor()
cur.execute('SELECT * FROM language')
rows = cur.fetchall()  # 모든 데이터를 가져옴
print(rows)
language_df = pd.DataFrame(rows)
print(language_df)

cur.close()
conn.close()  # 데이터베이스 연결 종료
