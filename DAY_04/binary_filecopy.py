filename1 = input("원본 파일 이름을 입력하시오: ")
filename2 = input("복사 파일 이름을 입력하시오: ")

infile = open(filename1, "rb")
outfile = open(filename2, "wb")

# 입력 파일에서 1024 바이트씩 읽어서 출력 파일에 쓴다.
# 파일의 마지막 부분에서는 읽어들인 바이트 수만큼 파일에 저장
while True:
    copy_buffer = infile.read(1024)
    print(len(copy_buffer))  # 실제 읽어온 바이트 수 출력
    if not copy_buffer:      # 파일의 끝인 경우, empty byte를 리턴
        break
    outfile.write(copy_buffer)

infile.close()
outfile.close()
print(filename1 + "를 " + filename2 + "로 복사하였습니다.")
