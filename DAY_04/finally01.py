def calc(values):
    sum = None
    try:
        sum = values[0] + values[1] + values[2]
    except IndexError as err:
        print("인덱스 에러: ", err)
    except Exception as err:
        print(err)
    else:
        print("에러 없음:", values)
    finally:
        print(f"sum = {sum}")


calc([1, 2, 3])
calc([1, 2])
