
#�Ƴ��޹ر���
rm(list=ls())
#�趨����Ŀ¼
setwd("E://Rtrial")
#�Ѿ����غõ����14����������
tradeDate <- read.csv("wanke.csv")


#��ʼ���ڻ�Ʒ��
IndexID <- '1406'

#�õ�14�꽻���յ�������Ϣ�����浽tradeD��
tradeD <- rev(as.array(tradeDate$X.))
#��ʼ����ʱ��������Ϊ֮�����ص�ַ�еı�����
IndexDa <- array(1:length(tradeD))

#��ʼ����ʱ�洢��ַ������
temp <- array(1:length(tradeD))
#�����ֵ����Ϊtxt��ʽ,���õ�14��Ľ���������
write.table(tradeD,file="E://Rtrial//tradeD.txt",row.names = F,col.names = F,quote = F)



#������ȡ�����ҽ�������ַ�ַ����മ���ϳɿ����������ظ�Ƶ�ļ��ĵ�ַ
#for (i in 1:length(tradeD)){
  for (i in 1:2){
  #����ÿһ��������������Ӧ�����ݣ�����м�Ҫ�漰�ڻ������ڵıȽϣ�
  #���磬IF1506�����Լ������Ӧ����2014��11�µ��ĸ���һ��ʼ��һֱ��15��6�µ���������
  #�˴������Ȳ���ϸ�ڣ�ֱ�Ӱ�14�����е����ڶ�ӦIF1506������ȫ�������������û�ж�Ӧ������Ϊ��
  
  #���õ�����������ת��Ϊ�ض���ʽ������yyyy-mm-ddת��Ϊyyyy/mm/dd
  
  #����
  #ͨ����ȡtradeD(��������)�е��ꡢ�¡��գ�Ȼ���ٽ���ƴ�������ַ���
  IndexDa[i] = as.character(tradeD[i])
  Inyear = as.character(substr(IndexDa[i],1,4))
  Inmon = as.character(substr(IndexDa[i],6,7))
  Inmon = sprintf("%02d",as.integer(Inmon))
  Inday = as.character(substr(IndexDa[i],9,10))
  Inday = sprintf("%02d",as.integer(Inday))
  IndexDa[i] = paste(Inyear,Inmon,Inday,sep = "")
  
  #�����ɵĵ�ַ��ֵ����ʱ����
  temp[i] <- paste('https://gw.wmcloud.com/dataquery//CsvData.csv?pretty=true&input=IF',IndexID,'%20%20',IndexDa[i],'%20%E9%AB%98%E9%A2%91&secNum=0',sep = "")
  #��һ������ÿ�������ļ���
  IndexDa[i] = paste(IndexDa[i],'.csv',sep = "")
  #������Ӧ�ļ�
  download.file(temp[i],IndexDa[i])
  #temp[i] <- 'https://gw.wmcloud.com/dataquery//CsvData.csv?pretty=true&input=IF1506%20%2020150303%20%E9%AB%98%E9%A2%91&secNum=0'
}