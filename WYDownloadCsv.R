###############
#2014/1/1至12/31 Analysis HIGH FREQUENCY DATA OF IC/IF/IH （tick）
#This module is used as download data from datayes
#updated date:2015/9/16
#creator: You Wang   e-mail：power15@126.com
###############

#rm irrelevent variables
rm(list=ls())
#set working directory
setwd("E://Rtrial")
#Using the downloaded file as the trading day info
tradeDate <- read.csv("wanke.csv")


#initial Index Future's ID
IndexID <- '1503'

#Create a new directory to store the downloaded data

dirn <- paste("2015IF",IndexID,sep = "")
#create the new dirctory
dir.create(dirn)
#get present dir
fatherdir <- "E://Rtrial"
#combine dir
newdir <- paste(fatherdir,dirn,sep = "//")
# 
# # #set work dirctory to the new one
setwd(newdir)


#得到14年交易日的天数信息，保存到tradeD中
#Obtain 2014year trade day info, and save as tradeD
tradeD <- rev(as.array(tradeDate$X.))
#初始化临时变量（作为之后下载地址中的变量）
#initial temp variable IndexDa to store the Date
IndexDa <- array(1:length(tradeD))

#初始化临时存储网址的数组
#initial temp variable temp to store the Download link
temp <- array(1:length(tradeD))
#把这个值保存为txt格式,即得到14年的交易日数据
#store as txt format,i.e. obtain the trading info of 2014
#write.table(tradeD,file="E://Rtrial//2015IF1407//tradeD.txt",row.names = F,col.names = F,quote = F)



#逐行提取，并且将其与网址字符串相串联合成可以批量下载高频文件的地址
#Extract line by line,and combine the string to download automatically
for (i in 1:51){
#  for (i in 1:2){
  #对于每一个交易`日下载相应的数据（这个中间要涉及期货与日期的比较）
  #
  #比如，IF1506这个合约，最早应当是2014年11月第四个周一开始有一直到15年6月的三个周五
  #此处，首先不管细节，直接把14年所有的日期对应IF1506的数据全部导下来，如果没有对应的数据为空
  
  #将得到的日期数组转化为特定格式，即由yyyy-mm-dd转变为yyyy/mm/dd
  
  #测试
  #通过提取tradeD(交易日期)中的年、月、日，然后再将其拼成日期字符串
  IndexDa[i] = as.character(tradeD[i])
  Inyear = as.character(substr(IndexDa[i],1,4))
  Inmon = as.character(substr(IndexDa[i],6,7))
  Inmon = sprintf("%02d",as.integer(Inmon))
  Inday = as.character(substr(IndexDa[i],9,10))
  Inday = sprintf("%02d",as.integer(Inday))
  IndexDa[i] = paste(Inyear,Inmon,Inday,sep = "")
  
  #将生成的地址赋值给临时变量
  temp[i] <- paste('https://gw.wmcloud.com/dataquery//CsvData.csv?pretty=true&input=IF',IndexID,'%20%20',IndexDa[i],'%20%E9%AB%98%E9%A2%91&secNum=0',sep = "")
  #进一步生成每个下载文件名
  IndexDa[i] = paste(IndexDa[i],'.csv',sep = "")
  #下载相应文件
  download.file(temp[i],IndexDa[i])
  #temp[i] <- 'https://gw.wmcloud.com/dataquery//CsvData.csv?pretty=true&input=IF1506%20%2020150303%20%E9%AB%98%E9%A2%91&secNum=0'
  #Sys.sleep(1)
  }
