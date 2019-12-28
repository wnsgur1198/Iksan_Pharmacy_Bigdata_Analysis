# �౹��� ���� ����

# �������� �о����
chk <- read_xlsx("C:/my_R/iksan_pharmacy.xlsx", sheet=1)
chk

# ���ڿ� ���� - ���̸��� �� ���� �̻��� ��� ����
addr <- substr(chk$��������ü�ּ�, 9, 13)
addr

# ���ڿ� ���� �и�
addr <- gsub("[0-9]", "", addr)
addr <- gsub(" ", "", addr)
addr

# ������ �౹ �߰�
addr <- c(addr, "�Ⱥ���", "��ȭ��")
  
# ����ǥ ���
table(addr)

# ������ �౹ ����
chk_df <- as.data.frame(table(addr))

# ���̸� ����
colnames(chk_df)[2] <- "freq"
chk_df

# ����׷��� ���
# x�� ũ�� ������ ����, ������ �߰�, ��Ʈ ���� ���, ���ڽ�Ÿ�� ����
ggplot(chk_df, aes(x=reorder(addr,freq), y=freq)) + geom_col() + coord_flip() + xlab("������") + ylab("�౹ ��") + ggtitle("2019 ���� �ͻ�� �౹ ����") + theme(plot.title = element_text(hjust=0.5))

# Ʈ���� ���
treemap(chk_df, index="addr", vSize="freq", title="2019 ���� �ͻ�� �౹ ����")

# ����Ŭ���� ���
wordcloud(chk_df$addr, freq = chk_df$freq, colors = rainbow(11))
wordcloud2(chk_df, size=1)


# ������ �α���
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

# �α� ��� �౹ ���� 
chk_df$freq2 <- chk_df$popul / chk_df$freq
chk_df

ggplot(chk_df, aes(x=reorder(addr,freq2), y=freq2)) + geom_col() + coord_flip() + xlab("������") + ylab("�౹ ��") + ggtitle("2019 ���� �ͻ�� �౹�� �α��� ����") + theme(plot.title = element_text(hjust=0.5))

treemap(chk_df, index="addr", vSize="freq2", title="2019 ���� �ͻ�� �౹�� �α��� ����")
# -> ������ �߰��ϸ� ����� �޶���