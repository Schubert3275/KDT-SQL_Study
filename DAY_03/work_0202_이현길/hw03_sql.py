'''
SQL 과제 #3
- MySQL과 Python 연동 과제

'''
import pymysql

def insert_user_table(conn, cur):
    '''
    사용자 정보 테이블 (user_table)에 데이터 추가
    '''

    user_data = (
        ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8'),
        ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7'),
        ('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9'),
        ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5'),
        ('KJD', '김제동', 1974, '경남', None, None, 173, '2013-3-3'),
        ('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4'),
        ('SDY', '신동엽', 1971, '경기', None, None, 176, '2008-10-10'),
        ('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4'),
        ('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
        ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5'),
    )

    try:
        sql = """insert into user_table (userID, userName, birthYear, addr, mobile1, mobile2, height, mDate)
                    values (%s, %s, %s, %s, %s, %s, %s, %s)"""

        cur.executemany(sql, user_data)
        conn.commit()
    except Exception as e:
        print(e)

def insert_buy_table(conn, cur):
    '''
    buy_table에 데이터 추가
    '''
    buy_data = (
        ('KHD', '운동화', None, 30, 2),
        ('KHD', '노트북', '전자', 1000, 1),
        ('KYM', '모니터', '전자', 200, 1),
        ('PSH', '모니터', '전자', 200, 5),
        ('KHD', '청바지', '의류', 50, 3),
        ('PSH', '메모리', '전자', 80, 10),
        ('KJD', '책', '서적', 15, 5),
        ('LHJ', '책', '서적', 15, 2),
        ('LHJ', '청바지', '의류', 50, 1),
        ('PSH', '운동화', None, 30, 2),
        ('LHJ', '책', '서적', 15, 1),
        ('PSH', '운동화', None, 30, 2),
    )
    try :
        sql = """insert into buy_table (userID, prodName, groupName, price, amount)
                values (%s, %s, %s, %s, %s)"""
        cur.executemany(sql, buy_data)
        conn.commit()
    except Exception as e:
        print(e)


def execute_query_1(cur):
    '''
    문제 1. buy_table과 user_table을 내부 조인 후 '연락처' 컬럼 추가
    '''
    sql = """   
        select user_table.userName, buy_table.prodName, user_table.addr,
	    concat(user_table.mobile1, user_table.mobile2) as %s
        from buy_table inner join user_table 
        on buy_table.userID = user_table.userID; 
    """
    try:
        cur.execute(sql, ('연락처'))
        results = cur.fetchall()
        # 헤더 정보 가져오기 (tuple형식으로 [0]번째 인덱스에 헤더 정보 포함)
        desc = cur.description
        print('\n문제 1번')
        print('-------------------------------------------')
        print(f'{desc[0][0]:<10} {desc[1][0]:<10} {desc[2][0]:<4} {desc[3][0]:^12}')
        print('-------------------------------------------')
        for result in results:
            print(result)
    except Exception as e:
        print(e)



def execute_query_2(cur):
    '''
    문제 2. userID가 KYM인 사람이 구매한 물건과 회원 정보 검색
    '''

    sql = """
        select b.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as '연락처'
        from buy_table as b 
            inner join user_table as u
            on b.userID = u.userID 
        where b.userID = %s;
    """
    try:
        cur.execute(sql, 'KYM')
        results = cur.fetchall()
        desc = cur.description
        print('\n문제 2번')
        print('-------------------------------------------------')
        print(f'{desc[0][0]:<8} {desc[1][0]:<8} {desc[2][0]:<8} {desc[3][0]:^8} {desc[4][0]:^12}')
        print('-------------------------------------------------')

        for result in results:
            print(result)

    except Exception as e:
        print(e)

def execute_query_3(cur):
    '''
    문제 3. 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
    '''

    sql = """
        select u.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as '연락처' 
        from user_table as u 
            inner join buy_table as b 
            on u.userID = b.userID 
        order by u.userID;
    """
    try:
        cur.execute(sql)
        results = cur.fetchall()
        desc = cur.description

        print('\n문제 3번')
        print('-------------------------------------------------')
        print(f'{desc[0][0]:<8} {desc[1][0]:<8} {desc[2][0]:<8} {desc[3][0]:^8} {desc[4][0]:^12}')
        print('-------------------------------------------------')

        for result in results:
            print(result)

    except Exception as e:
        print(e)


def execute_query_4(cur):
    '''
    문제 4.
    '''
    sql = """
        select distinct u.userID, u.userName, u.addr 
        from user_table as u 
            inner join buy_table as b 
            on u.userID = b.userID 
        order by u.userID;
    """
    try:
        cur.execute(sql)
        results = cur.fetchall()
        desc = cur.description
        print('\n문제 4번')
        print('-------------------------------------------------')
        print(f'{desc[0][0]:<8} {desc[1][0]:<8} {desc[2][0]:<10}')
        print('-------------------------------------------------')
        for result in results:
            print(result)

    except Exception as e:
        print(e)


def execute_query_5(cur):
    '''
    문제 5.
    '''
    sql = """
        select u.userID, u.userName, u.addr, concat(u.mobile1, u.mobile2) as 연락처
        from user_table as u 
            inner join buy_table as b 
            on u.userID = b.userID 
        where u.addr = %s or u.addr = %s
        order by u.userID;
    """
    try:
        cur.execute(sql, ('경북', '경남'));
        results = cur.fetchall()

        desc = cur.description
        print('\n문제 5번')
        print('-------------------------------------------------')
        print(f'{desc[0][0]:<8} {desc[1][0]:<8} {desc[2][0]:<8} {desc[3][0]:^8}')
        print('-------------------------------------------------')
        for result in results:
            print(result)
    except Exception as e:
        print(e)

def main():
    conn = pymysql.connect(host='localhost', user='root', password='',
                           db = 'shoppingmall', charset='utf8')

    cur = conn.cursor()
    # 사용자 정보 입력 (user_table)
    row = cur.execute('select * from user_table')
    if cur.rowcount == 0:
        insert_user_table(conn, cur)
    else:
        print('user_table 데이터:{} 개'.format(row))

    # buy_table 정보 입력 (buy_table)
    row = cur.execute('select * from buy_table')
    if cur.rowcount == 0:
        insert_buy_table(conn, cur)
    else:
        print('buy_table 데이터:{} 개'.format(row))

    execute_query_1(cur)
    execute_query_2(cur)
    execute_query_3(cur)
    execute_query_4(cur)
    execute_query_5(cur)

    # 연결 종료
    cur.close()
    conn.close()

main()