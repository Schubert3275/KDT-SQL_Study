# 파일 안의 각 문자들이 몇 번이나 나타나는지를 세는 프로그램
while True:
    try:
        filename = input("파일명을 입력하세요: ").strip()
        break
    except Exception as e:
        print("파일명이 잘못되었습니다", e)
infile = open(filename, "r")

freqs = {}  # 딕셔너리 생성

# 파일의 각 줄에서 문자를 추출한 다음 각 문자를 dict에 추가
for line in infile:
    for chr in line.strip():
        if chr in freqs:
            freqs[chr] += 1  # 딕셔너리에 key(char)가 있으면 증가
        else:
            freqs[chr] = 1  # 딕셔너리에 key(char)가 없으면 추가

print(freqs)
infile.close()
