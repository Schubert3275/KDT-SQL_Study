"""
    2. 딕셔너리 생성 및 정렬 프로그램
    아래에 주어진 총 6개 나라의 수도에 대한 국가명, 대륙, 인구수를 표시한 테이블을 이용하여
    딕셔너리를 작성하고, 아래 실행 화면과 같이 출력을 하는 프로그램을 작성하시오.
"""


def display_menu() -> int:
    """
    메뉴 출력 및 번호 입력
    :return: 1~6 사이의 숫자
    """
    print('-' * 50)
    print(f' 1. 전체 데이터 출력')
    print(f' 2. 수도 이름 오름차순 출력')
    print(f' 3. 모든 도시의 인구수 내림차순 출력')
    print(f' 4. 특정 도시의 정보 출력')
    print(f' 5. 대륙별 인구수 계산 및 출력')
    print(f' 6. 프로그램 종료')
    print('-' * 50)
    while True:
        num = input('메뉴를 입력하세요: ')
        if num.isdecimal() and 1 <= int(num) <= 6:
            num = int(num)
            break
        else:
            print("1-6 사이의 정수를 입력하세요.")
    return num


def display_all(country_dict: dict):
    """
    전체 데이터 출력
    :param country_dict: key: 수도 이름, value: 국가명, 대륙, 인구수
    """
    for idx, (k, v) in enumerate(country_dict.items(), 1):
        print(f'[{idx}] {k}: {v}')


def display_city_name(country_dict: dict):
    """
    수도 이름 오름차순 출력
    :param country_dict: key: 수도 이름, value: 국가명, 대륙, 인구수
    """
    formatting_nums = len_check(country_dict)
    sort_country = dict(sorted(country_dict.items()))
    for idx, (k, v) in enumerate(sort_country.items(), 1):
        print(f'[{idx}] {k:<{formatting_nums[0]}} : {v[0]:<{formatting_nums[1]}}  '
              f'{v[1]:<{formatting_nums[2]}}  {v[2]:>{formatting_nums[3]+((formatting_nums[3]-1)//3)},}')


def display_population(country_dict: dict):
    """
    모든 도시의 인구수 내림차순 출력
    :param country_dict: key: 수도 이름, value: 국가명, 대륙, 인구수
    """
    formatting_nums = len_check(country_dict)
    sort_country = dict(sorted(country_dict.items(), key=lambda x: x[1][2], reverse=True))
    for idx, (k, v) in enumerate(sort_country.items(), 1):
        print(f'[{idx}] {k:<{formatting_nums[0]}} :   {v[2]:>{formatting_nums[3]+((formatting_nums[3]-1)//3)},}')


def display_city_info(country_dict: dict):
    """
    특정 도시의 정보 출력
    :param country_dict: key: 수도 이름, value: 국가명, 대륙, 인구수
    """
    city_name = input('출력할 도시 이름을 입력하세요: ')
    if city_name in country_dict.keys():
        print(f'도시:{city_name}')
        print(f'국가:{country_dict[city_name][0]}, '
              f'대륙:{country_dict[city_name][1]}, '
              f'인구수:{country_dict[city_name][2]:,}')
    else:
        print('\033[31m' + f'도시이름: {city_name}은 key에 없습니다.' + '\033[0m')


def display_continent_population(country_dict: dict):
    """
    대륙별 인구수 계산 및 출력
    :param country_dict: key: 수도 이름, value: 국가명, 대륙, 인구수
    """
    continent_list = []
    for continent in country_dict.values():
        if continent[1] not in continent_list:
            continent_list.append(continent[1])
    continent_name = input(f'대륙 이름을 입력하세요({", ".join(continent_list)}): ')
    if continent_name in continent_list:
        population_sum = 0
        for k, v in country_dict.items():
            if v[1] == continent_name:
                print(f'{k} : {v[2]:,}')
                population_sum += v[2]
        print(f'{continent_name} 전체 인구수: {population_sum:,}')
    else:
        print('\033[31m' + f'대륙: {continent_name}은 목록에 없습니다.' + '\033[0m')


def len_check(country_dict: dict):
    """
    수도 이름, 국가명, 대륙, 인구수 각각의 최대 길이 측정
    :param country_dict: key: 수도 이름, value: 국가명, 대륙, 인구수
    :return: 각각의 최대 길이를 반환
    """
    max_city_len = len(max(country_dict.keys(), key=len))
    max_country_len = 0
    max_continent_len = 0
    max_population_len = 0
    for data in country_dict.values():
        if len(data[0]) > max_country_len:
            max_country_len = len(data[0])
        if len(data[1]) > max_continent_len:
            max_continent_len = len(data[1])
        if len(str(data[2])) > max_population_len:
            max_population_len = len(str(data[2]))
    print(max_population_len)
    return max_city_len, max_country_len, max_continent_len, max_population_len


def main():
    country_dict = {
        'Seoul': ['South Korea', 'Asia', 9655000],
        'Tokyo': ['Japan', 'Asia', 14110000],
        'Beijing': ['China', 'Asia', 21540000],
        'London': ['United Kingdom', 'Europe', 14800000],
        'Berlin': ['Germany', 'Europe', 3426000],
        'Mexico City': ['Mexico', 'America', 21200000]
    }
    while True:
        num = display_menu()
        if num == 1:
            display_all(country_dict)
        elif num == 2:
            display_city_name(country_dict)
        elif num == 3:
            display_population(country_dict)
        elif num == 4:
            display_city_info(country_dict)
        elif num == 5:
            display_continent_population(country_dict)
        else:
            print('프로그램을 종료합니다.')
            break


if __name__ == "__main__":
    main()
