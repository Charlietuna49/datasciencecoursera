library(dplyr)
if(!exists("features")) features<- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/features.txt", quote="\"", stringsAsFactors=FALSE)
##View(features)
nrow(features)
if(!exists("X_test")) X_test <- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
##View(X_test)
##ncol(X_test)
if(!exists("X_train")) X_train <- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
if(!exists("y_test")) y_test <- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/test/y_test.txt", quote="\"", stringsAsFactors=FALSE)
if(!exists("y_train"))y_train <-read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)

## Obtain only the mean() or std measurements
meanStd<-features[grep("std|mean\\(\\)",features$V2),]
meanStd$V2<-gsub(pattern="-|\\(\\)",replacement="", x=meanStd$V2)
meanStd$V2<-gsub(pattern="BodyBody",replacement="Body", x=meanStd$V2)
#--------------------------------------------------------------------

#select columns needed only from X train and X test with meanStd df
columnsNeeded<- select(meanStd, V1)
xtrain<-select(X_train,columnsNeeded$V1)
xtest<-select(X_test,columnsNeeded$V1)

#add activity column
names(y_test)[1]<- "activity"
xtest<- cbind(xtest,y_test["activity"])

names(y_train)[1] <- "activity"
xtrain<- cbind(xtrain, y_train["activity"])

# combine test and train data
combox<-rbind(xtest,xtrain)


#dfColumns<- X_test %>%
 # select(meanStd)
#dfColumnsTrain <-X_train %>%
 # select(meanStd)

##print(head(dfColumns))
#nme<- c(mean$V2,std$V2)
#names(dfColumns)<-nme
#names(dfColumnsTrain)<-nme
#print(head(dfColumns))
