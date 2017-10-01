setwd("/Users/ai/Desktop/UCI HAR Dataset")
library(reshape2)
# Read the data
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
X_trsubject <- read.table("./train/subject_train.txt")
X_tesubject <- read.table("./test/subject_test.txt")
X_subject <- rbind(X_tesubject, X_trsubject)
colnames(X_subject) <- "Subject"

# Load features for the column names
features <- read.table("./features.txt")
colnames(X_test) <- features[, 2]
colnames(Y_test) <- "Activity"
colnames(X_train) <- features[, 2]
colnames(Y_train) <- "Activity"

# Merge training and test to create one data set
X_data <- rbind(X_train, X_test)
Y_data <- rbind(Y_train, Y_test)
data <- cbind(X_data, Y_data)

# Extracts only the measurements on the mean and standard deviation for each measurement
featureWanted <- grep(".*mean.*|.*std.*", features[, 2])
featuresWanted.names <- features[featureWanted, 2]
Xdata_Wanted <- X_data[, featureWanted]
data_Wanted <- cbind(X_subject, Xdata_Wanted, Y_data)

# Uses descriptive activity names to name the activities in the data set
activity <- read.table("./activity_labels.txt")
colnames(activity) <- c("Number", "Activity")
data_Wanted$Activity <- factor(data_Wanted$Activity, levels = activity[, 1], labels = activity[, 2])

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
Average <- aggregate(. ~ Activity + Subject, data_Wanted, mean)
write.table(Average, file = "./tidydata.txt", row.name = TRUE)