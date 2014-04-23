## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Load Packages
library(reshape2)

## Load datasets
## Load metadatasets
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

## Load training datasets
x_train <- read.table("./train/x_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

## Load test datasets
x_test <- read.table("./test/x_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

## 4. Appropriately labels the data set with descriptive activity names based on features and activities
colnames(x_train) <- features$V2
colnames(x_test) <- features$V2
colnames(subject_train) <- c("subject")
colnames(subject_test) <- c("subject")
colnames(y_train) <- c("activity")
colnames(y_test) <- c("activity")

## 1. Merges the training and the test sets to create one data set.
data_train <- cbind(subject_train,y_train,x_train)
data_test <- cbind(subject_test,y_test,x_test)
dataset <- rbind(data_train,data_test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
dataset <- dataset[grep("(subject|activity|mean\\(\\)|std\\(\\))",colnames(dataset))]

## 3. Uses descriptive activity names to name the activities in the data set
dataset$activity <- factor(dataset$activity,labels=activities$V2)

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
ds <- melt(dataset,id=c("subject","activity"))
tidy_dataset <- dcast(ds,subject+activity ~ variable,mean)

## Write out the dataset to a file
write.table(tidy_dataset,file="tidy_dataset.txt")
