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
if(!exists("subject_test")) subject_test <-read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)
if(!exists("subject_train"))subject_train<-read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
if(!exists("activity_labels"))activity_labels <- read.table("C:/Users/Charlietuna/datasciencecoursera/datacleaningAssignment/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)

## Obtain only the mean() or std measurements
meanStd<-features[grep("std|mean\\(\\)",features$V2),]
meanStd$V2<-gsub(pattern="-|\\(\\)",replacement="", x=meanStd$V2)
meanStd$V2<-gsub(pattern="BodyBody",replacement="Body", x=meanStd$V2)
meanStd$V2<-gsub(pattern="Acc",replacement="acceleration", x=meanStd$V2)
meanStd$V2<-gsub(pattern="Gyro",replacement="gyroscopic", x=meanStd$V2)
meanStd$V2<-gsub("(mean)","\\.\\1",meanStd$V2, perl = T)
meanStd$V2<-gsub("(std)","\\.\\1deviation",meanStd$V2, perl = T)
meanStd$V2<-gsub(pattern= "y$", replacement ="ofy",ignore.case =T, x =meanStd$V2)
meanStd$V2<-gsub(pattern= "x$",ignore.case =T,replacement = "ofx", x =meanStd$V2)
meanStd$V2<-gsub(pattern= "z$",ignore.case = T,replacement = "ofz", x =meanStd$V2)
meanStd$V2<-gsub(pattern= "^t",ignore.case = T,replacement = "time", x =meanStd$V2)
meanStd$V2<-gsub(pattern= "^f",ignore.case = T,replacement = "fastfourier", x =meanStd$V2)

meanStd$V2<-tolower(meanStd$V2)


#--------------------------------------------------------------------

#select columns needed only from X train and X test with meanStd df
columnsNeeded<- select(meanStd, V1)
xtrain<-select(X_train,columnsNeeded$V1)
xtest<-select(X_test,columnsNeeded$V1)

#add activity  and subject columns
names(y_test)[1]<- "activity"
xtest<- cbind(xtest,y_test["activity"])
names(subject_test)[1] <- "subject"
xtest<- cbind(xtest,subject_test["subject"])


names(y_train)[1] <- "activity"
xtrain<- cbind(xtrain, y_train["activity"])
names(subject_train)[1]<-"subject"
xtrain<- cbind(xtrain,subject_train["subject"])


# combine test and train data
combox<-rbind(xtest,xtrain)

# rename columns to lower case etc
names(combox)<- c(meanStd$V2, "activity","subject")

# join with activity name table
act<-rename(activity_labels,activity = V1, activities = V2)
join<-inner_join(combox, act, by = c("activity" = "activity"))


# group by and run functions mean, sd
by_subject_activity<-join %>% 
  group_by(subject,activities) %>%
  summarise_each(funs(mean,sd),-activity)

  



#dfColumns<- X_test %>%
 # select(meanStd)
#dfColumnsTrain <-X_train %>%
 # select(meanStd)

##print(head(dfColumns))
#nme<- c(mean$V2,std$V2)
#names(dfColumns)<-nme
#names(dfColumnsTrain)<-nme
#print(head(dfColumns))
