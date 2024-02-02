"""
    executemany()
    - 여러 개의 tuple 데이터를 처리
"""
import pymysql

conn = pymysql.connect(host='localhost', port=3306,
                       user='root', passwd='1234', db='sqlclass_db', charset='utf8')

cur = conn.cursor()
sql = """-- sql
insert into customer(name, category, region)
values (%s, %s, %s)"""

data = (
    ('홍진우', 1, '서울'),
    ('강지수', 2, '부산'),
    ('김청진', 1, '대구')
)

cur.executemany(sql, data)

conn.commit()
print("excutemany() 완료")

cur.close()
conn.close()
