library(dplyr)
if(!exists("features")) features<- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/features.txt", quote="\"", stringsAsFactors=FALSE)
##View(features)
nrow(features)
if(!exists("X_test")) X_test <- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
##View(X_test)
##ncol(X_test)
if(!exists(X_train)) X_train <-X_train <- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)


std<-features[grep("std",features$V2),]
mean<-features[grep("mean\\(\\)",features$V2),]
meanStd <- c(mean$V1, std$V1)


##print(meanStd)

dfColumns<- X_test %>%
  select(meanStd)
dfColumnsTrain <-X_train %>%
  select(meanStd)

##print(head(dfColumns))
nme<- c(mean$V2,std$V2)
names(dfColumns)<-nme
names(dfColumnsTrain)<-nme
print(head(dfColumns))
