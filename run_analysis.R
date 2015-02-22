
#########1. Merges the training and the test sets to create one data set


##read train and test data

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")


##merge data

datasetx <- rbind(x_train, x_test)
datasety <- rbind(y_train, y_test)
datasets <- rbind(subject_train, subject_test)


##head(datasetx)
##head(datasety)
##head(datasets)



#########2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("UCI HAR Dataset/features.txt")
msf <- grep("-(mean|std)\\(\\)", features[, 2])
datasetx <- datasetx[, msf]


##head(datasetx)


#########3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
datasety[, 1] <- activities[datasety[, 1], 2]


##head(datasety)


#########4. Appropriately labels the data set with descriptive variable names

##set the column name for datasets
names(datasetx) <- features[msf, 2]
names(datasety) <- "activity"
names(datasets) <- "subject"

##Combine datasets and create table for merged dataset
dataset1 <- cbind(datasetx, datasety, datasets)
write.table(dataset1, "dataset1.txt")

#########5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##head(datasetfinal)
library(plyr)

##build average of each variable for each activity and each subject
dataset2<-aggregate(. ~subject + activity, dataset1, mean)
dataset2<-dataset2[order(dataset2$subject,dataset2$activity),]


write.table(dataset2, file = "dataset2.txt",row.name=FALSE)
