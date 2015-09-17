###############
#2014/1/1÷¡12/31 Analysis HIGH FREQUENCY DATA OF IC/IF/IH £®tick£©
#This module is used as download data from datayes
#updated date:2015/9/17
#creator: You Wang   e-mail£∫power15@126.com
###############


#rm irrelevent variables
rm(list=ls())
#set working directory
setwd("E://Rtrial")
#read SZ50 list
tradeid <- read.csv("SZ50.csv",header = F)
tradeDate <- read.csv("wanke.csv")
#initial date variables
tradeD <- rev(as.array(tradeDate$X.))
IndexDa <- array(1:length(tradeD))

id <- as.character(array(1:50))
temp <- as.character(array(1:50))
  
#transform into string
for (i in 1:50){
  id[i] <- as.character(tradeid[i,1])
  #get the numeric ID of SZ50
  id[i] <- substr(id[i],7,12)
  #paste a fraction of the address
  #https://gw.wmcloud.com/dataquery//CsvData.csv?pretty=true&input=600000%2020150601%20%E9%AB%98%E9%A2%91&secNum=0
  temp[i] <- paste('https://gw.wmcloud.com/dataquery//CsvData.csv?pretty=true&input=',id[i],sep = "")  
}

for (j in 1:2){
  #generate the dir for the stock
  dirn <- paste("2015Y",id[j],sep = "")
  dir.create(dirn)
  fatherdir <- "E://Rtrial"
  #combine dir
  newdir <- paste(fatherdir,dirn,sep = "//")
  # set work dirctory to the new one
  setwd(newdir)
#for (i in 1:length(tradeD)){
  for (i in 1:2){
  #convert yyyy-mm-dd Date format into yyyymmdd format
  IndexDa[i] = as.character(tradeD[i])
  Inyear = as.character(substr(IndexDa[i],1,4))
  Inmon = as.character(substr(IndexDa[i],6,7))
  Inmon = sprintf("%02d",as.integer(Inmon))
  Inday = as.character(substr(IndexDa[i],9,10))
  Inday = sprintf("%02d",as.integer(Inday))
  IndexDa[i] = paste(Inyear,Inmon,Inday,sep = "")
  #paset a whole download address
  temp[i] <- paste(temp[i],'%20',IndexDa[i],'%20%E9%AB%98%E9%A2%91&secNum=0',sep="")
  #generate the file name
  IndexDa[i] = paste(IndexDa[i],'.csv',sep = "")
  #download the file
  download.file(temp[j],IndexDa[i])
  }
  #set working directory
  setwd("E://Rtrial")
}
