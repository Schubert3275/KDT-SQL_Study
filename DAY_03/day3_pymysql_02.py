"""
    복잡한 쿼리 실행
    - inner join 내용
"""
import pymysql

conn = pymysql.connect(host='localhost', port=3306,
                       user='root', passwd='1234', db='sakila', charset='utf8')

cur = conn.cursor()
query = """-- sql
SELECT c.email
FROM customer as c
    INNER JOIN rental as r
    on c.customer_id = r.customer_id
WHERE date(r.rental_date) = (%s)"""  # 실제 쿼리와 동일한 문자열 전달

cur.execute(query, ('2005-06-14'))
rows = cur.fetchall()  # 모든 데이터를 가져옴
for row in rows:
    print(row)

cur.close()
conn.close()
