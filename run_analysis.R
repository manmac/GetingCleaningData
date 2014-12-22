#Part 0: Getting and Staging Data onto local Drives
#--------------------------------------------------------------------
#Download dataset if already not download
if (!file.exists("dataset.zip")){
#  URL of Dataset
   fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#  downloads the zipped file and renames it to something simple(dataset.zip)
   download.file(fileURL,destfile="dataset.zip",method="curl")
#  Date stamp the data downloaded
   dateDownloaded<-date()
}

#Unzip Dataset if already not unzipped
if (!file.exists("./UCI HAR Dataset")){
   #unzip the zipped file thats downloaded currently
   unzip("~/dataset.zip")
}

#Finally setwd if already not set to directory "UCI Har Dataset" that was
#extracted from dataset.zip in above stage
wd<-getwd()

if (!wd=="./UCI HAR Dataset"){
  #After unzipping all datasets are obtainer under a directory called 
  #"UCI HAR Dataset". Lets make this the current working directory to make
  #all extracts easier
  setwd("./UCI HAR Dataset")
}

#Part I Merges the training and the test sets to create one data set.
#--------------------------------------------------------------------
test_subj<-read.table("./test/subject_test.txt",col.names=c("subject"))
train_subj<-read.table("./train/subject_train.txt",col.names=c("subject"))
subj<-rbind(train_subj,test_subj)
#Reference:
#> str(subj)
#'data.frame':        10299 obs. of  1 variable:
#        $ subject: int  1 1 1 1 1 1 1 1 1 1 ...

#similarly merge all test set (X_test.txt), labels (y_test.txt)
test_X<-read.table("./test/X_test.txt")
train_X<-read.table("./train/X_train.txt")
test_y<-read.table("./test/y_test.txt",col.names=c("activityid"))
train_y<-read.table("./train/y_train.txt",col.names=c("activityid"))
X<-rbind(test_X,train_X)
y<-rbind(test_y,train_y)

#Part II Extracts measurements on the mean and stdev for each measurement. 
#----------------------------------------------------------------------------------
feature<-read.table("features.txt", col.names=c("featureid", "featurename"))
idx<-grep("-mean\\(\\)|-std\\(\\)", feature$featurename)
names(X)<-feature[,2]
msd<-X[,idx]
#str(msd)
#> str(msd)
#'data.frame':        10299 obs. of  66 variables:
#        $ tBodyAcc-mean()-X          : num  0.257 0.286 0.275 0.27 0.275 ...
#$ tBodyAcc-mean()-Y          : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
#$ tBodyAcc-mean()-Z          : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...


#Part III Uses descriptive activity names to name the activities in the data set. 
#----------------------------------------------------------------------------------
act <- read.table("activity_labels.txt",col.names=c("activityid","activity"))
act[, 2] = gsub("_", "", as.character(act[, 2]))
y [,1] = act[y[,1], 2]
names(y) <- "activity"

#Part IV Appropriately labels the data set with descriptive activity names. 
#----------------------------------------------------------------------------------
tidyData<-cbind(subj,y,msd)
#str(tidyData)
names(tidyData)[2]<-paste("activity")
names(tidyData)<-gsub("\\(|\\)", "", names(tidyData))
#write.table(tidyData,"tidyData.txt")

#Part V Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#----------------------------------------------------------------------------------
library(reshape2)
mtidyData<-melt(tidyData,id=c("subject","activity"))
subjactmean<-dcast(mtidyData,subject+activity ~ variable,mean)
View(subjactmean)
write.csv(subjactmean, file= "tidyData.txt", row.names=FALSE)

# Program is done. Reset the c.w.d. to a directory above to point to original location
#----------------------------------------------------------------------------------
setwd("..")



