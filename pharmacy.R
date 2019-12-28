# 약국사업 조사 과제

# 엑셀파일 읽어오기
chk <- read_xlsx("C:/my_R/iksan_pharmacy.xlsx", sheet=1)
chk

# 문자열 추출 - 동이름이 네 글자 이상일 경우 가정
addr <- substr(chk$소재지전체주소, 9, 13)
addr

# 숫자와 공백 분리
addr <- gsub("[0-9]", "", addr)
addr <- gsub(" ", "", addr)
addr

# 누락된 약국 추가
addr <- c(addr, "팔봉동", "평화동")
  
# 분포표 출력
table(addr)

# 지역별 약국 개수
chk_df <- as.data.frame(table(addr))

# 열이름 수정
colnames(chk_df)[2] <- "freq"
chk_df

# 막대그래프 출력
# x축 크기 순으로 정렬, 축제목 추가, 차트 제목 출력, 글자스타일 지정
ggplot(chk_df, aes(x=reorder(addr,freq), y=freq)) + geom_col() + coord_flip() + xlab("지역명") + ylab("약국 수") + ggtitle("2019 전북 익산시 약국 분포") + theme(plot.title = element_text(hjust=0.5))

# 트리맵 출력
treemap(chk_df, index="addr", vSize="freq", title="2019 전북 익산시 약국 분포")

# 워드클라우드 출력
wordcloud(chk_df$addr, freq = chk_df$freq, colors = rainbow(11))
wordcloud2(chk_df, size=1)


# 지역별 인구수
chk_df$popul <- c(12782,
                  23018, 
                  10018, 
                  49680, 
                  32485, 
                  17632, 
                  26248, 
                  40540, 
                  7651, 
                  3729, 
                  7312, 
                  5096)

chk_df

# 인구 대비 약국 개수 
chk_df$freq2 <- chk_df$popul / chk_df$freq
chk_df

ggplot(chk_df, aes(x=reorder(addr,freq2), y=freq2)) + geom_col() + coord_flip() + xlab("지역명") + ylab("약국 수") + ggtitle("2019 전북 익산시 약국별 인구수 분포") + theme(plot.title = element_text(hjust=0.5))

treemap(chk_df, index="addr", vSize="freq2", title="2019 전북 익산시 약국별 인구수 분포")
# -> 변수를 추가하면 결과가 달라짐
