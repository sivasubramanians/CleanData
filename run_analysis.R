## R script to merge two datasets - test & train and transform the data and create a 
## a new tidy dataset with average of each variable for each activity and each subject.

## reading test dataset
test_x_df <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "")
test_y_df <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject_df <- read.table("UCI HAR Dataset/test/subject_test.txt")

## reading training dataset
train_x_df <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y_df <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject_df <- read.table("UCI HAR Dataset/train/subject_train.txt")

## read the features.txt file to get the column names
features_df <- read.table("UCI HAR Dataset/features.txt")

## assign the column names for the data set
colnames(test_x_df) <- as.character(features_df[,2])
colnames(train_x_df) <- as.character(features_df[,2])

## combine individual data sets
test_combined_df <- cbind(test_subject_df,test_y_df,test_x_df)
colnames(test_combined_df)[1] <- "subject"
colnames(test_combined_df)[2] <- "activity"
train_combined_df <- cbind(train_subject_df,train_y_df,train_x_df)
colnames(train_combined_df)[1] <- "subject"
colnames(train_combined_df)[2] <- "activity"

## merge test & train data sets
merge_dataset_test <- rbind(train_combined_df, test_combined_df)

## identify columns with mean & standard deviation values
chararr <- colnames(merge_dataset_test)
meanindex <- grep("mean",chararr)
stdindex <- grep("std",chararr)
combindex <- sort(c(1:2,meanindex,stdindex))

## create a filtered dataset with only mean & std variables along with subject & activity values
filtered_df <- merge_dataset_test[,combindex]

## convert the activity in the list to descriptive activity names
activity_values <- read.table("UCI HAR Dataset/activity_labels.txt")
nrows <- nrow(activity_values)
for (rin in 1:nrows)
{
  filtered_df[filtered_df[,2] == as.integer(activity_values[rin,1]),2] <- as.character(activity_values[rin,2])
}

## calculate the mean of filtered variables grouped by Activity & Subject details. 
library(plyr)
newdataset <- ddply(filtered_df,.(activity,subject),colwise(mean))

## provide a descriptive column names for the new data set
chname <- colnames(newdataset)
tempcolname <- gsub("-",".",chname)
tempcolname <- gsub("\\(","",tempcolname)
tempcolname <- gsub("\\)","",tempcolname)
tempcolname <- gsub("tB","time.B",tempcolname)
tempcolname <- gsub("tG","time.G",tempcolname)
tempcolname <- gsub("fB","freq.B",tempcolname)
tempcolname <- gsub("time","ave.time",tempcolname)
tempcolname <- gsub("freq", "ave.freq",tempcolname)

colnames(newdataset) <- tempcolname

## write the new data set to a txt file
write.table(newdataset,file ="tidydataset_averagevalues.txt",row.names = FALSE)
