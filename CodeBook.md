### The script run_analysis.R performs the following steps to create a tidy data set as specified
### in the project instructions.

The data is in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### The script should be run in the working directory with the following directory structure:
* features.txt
* activity_labels.txt
* ./train/x_train.txt
* ./train/y_train.txt
* ./train/subject_train.txt
* ./test/x_test.txt
* ./test/y_test.txt
* ./test/subject_test.txt

### Load datasets
### Load metadatasets
* Load features forlabeling the x_ datasets
* Load activities to later use as factors

### Load training datasets
### Load test datasets

### 1. Appropriately labels the data set with descriptive activity names based on features and activities
* USe the column names in the features dataset to rename the colume names for the x_ tables
* Also give descriptive names to the subject datasets and y_ datasets

### 2. Merges the training and the test sets to create one data set.
* Merge the subject dataset and y_ datasets onto x_ datasets using cbind() function
* Merge the train dataset and test dataset using rbind() function

### 3. Extracts only the measurements on the mean and standard deviation for each measurement. 
* Use the grep function to extract the measurements with colum names ends with mean() or std(). 
* Also preserve subject and activity colume
* dataset <- dataset[grep("(subject|activity|mean\\(\\)|std\\(\\))",colnames(dataset))]

### 4. Uses descriptive activity names to name the activities in the data set
* Use factor() function to transfer the numerical coded activity into descriptive names
* dataset$activity <- factor(dataset$activity,labels=activities$V2)

### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
* use melt() and dcast() functions (in reshape2 package) to create mean for each aubject, activity and valiables. 
* ds <- melt(dataset,id=c("subject","activity"))
* tidy_dataset <- dcast(ds,subject+activity ~ variable,mean)

### 6. Write out the dataset to a file tidy_dataset.txt
