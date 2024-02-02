import pymysql
import pandas as pd

conn = pymysql.connect(host='localhost', port=3306,
                       user='root', passwd='1234', db='sakila', charset='utf8')

cur = conn.cursor()
cur.execute('SELECT * FROM language')
rows = cur.fetchall()
print(rows)
language_df = pd.DataFrame(rows)
print(language_df)

cur.close()
conn.close()
