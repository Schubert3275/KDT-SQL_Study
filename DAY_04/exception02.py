while True:
    try:
        n = input("숫자를 입력하시오: ")
        n = int(n)
        break
    except ValueError:
        print("정수가 아닙니다. 다시 입력하시오.")  # 입력된 숫자가 정수가 아닌 경우 수행
print("정수 입력이 성공하였습니다!")
