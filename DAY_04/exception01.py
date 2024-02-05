# 예외처리 #1
(x, y) = (2, 0)
try:
    z = x / y
except ZeroDivisionError:
    print("0으로 나누는 예외")  # 사용자 예외 메시지 출력

try:
    z = x / y
except ZeroDivisionError as e:
    print(e)                    # 파이썬이 제공하는 예외 메세지 출력

try:
    z = x / y
except Exception as e:  # 어떤 에러가 발생할지 모르므로 일반적으로 사용되는 최상위 케이스
    print(e)
