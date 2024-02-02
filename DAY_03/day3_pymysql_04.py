"""
    execute() 예제
"""
import pymysql

conn = pymysql.connect(host='localhost', port=3306,
                       user='root', passwd='1234', db='sqlclass_db', charset='utf8')

cur = conn.cursor()
sql = """-- sql
insert into customer(name, category, region)
values (%s, %s, %s)"""

cur.execute(sql, ('홍길동', 1, '서울'))
cur.execute(sql, ('홍길동', 2, '서울'))

conn.commit()
print("INSERT 완료")

cur.close()
conn.close()
