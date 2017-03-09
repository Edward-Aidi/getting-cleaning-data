#Run_Analysis.R script
**The R code for mungling the data provided by the UCI Machine Learning Database will be iluustrated as follows**

*You should create one R script called run_analysis.R that does the following.*

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```
library(data.table)
library(dplyr)
#read the column names of the X_test/train data set from "feature"
cname <- read.table("./getting & cleaning data project/UCI HAR Dataset/features.txt",
                    col.names = c("seq", "column.name"))
```
### `cname` represent all the variables in the X.txt and I will use that to name the columns of X_test or X_train data.
### Using `gsub` & `mutate` function, I am able to use descriptive names for the y_test and y_train.
```
#read X_test.txt and give it column names as te
te <- read.table("./getting & cleaning data project/UCI HAR Dataset/test/X_test.txt",
                 col.names = cname$column.name
                )

#read y_test.txt and use descriptive activity names as tel
tel <- read.table("./getting & cleaning data project/UCI HAR Dataset/test/y_test.txt",
               col.names = "label")
testlabel <- tel$label
testlabel <- gsub("1", "WALKING", testlabel)
testlabel <- gsub("2", "WALKING_UPSTAIRS", testlabel)
testlabel <- gsub("3", "WALKING_DOWNSTAIRS", testlabel)
testlabel <- gsub("4", "SITTING", testlabel)
testlabel <- gsub("5", "STANDING", testlabel)
testlabel <- gsub("6", "LAYING", testlabel)
tel <- mutate(tel, label = testlabel)
tel <- tbl_df(tel)

#read X_train.txt and give it column names as tr
tr <- read.table("./getting & cleaning data project/UCI HAR Dataset/train/X_train.txt",
                      col.names = cname$column.name
                     )

#read y_train.txt and use descriptive activity names as trl
trl <- read.table("./getting & cleaning data project/UCI HAR Dataset/train/y_train.txt",
                  col.names = "label")
testlabel <- trl$label
testlabel <- gsub("1", "WALKING", testlabel)
testlabel <- gsub("2", "WALKING_UPSTAIRS", testlabel)
testlabel <- gsub("3", "WALKING_DOWNSTAIRS", testlabel)
testlabel <- gsub("4", "SITTING", testlabel)
testlabel <- gsub("5", "STANDING", testlabel)
testlabel <- gsub("6", "LAYING", testlabel)
trl <- mutate(trl, label = testlabel)
trl <- tbl_df(trl)
```
### Then merge the two data frame using `bind` function and create one big ultimate data set.
```
#1.Merges the training and the test sets to create one data set.
X <- rbind(te, tr)
y <- rbind(tel, trl)
data_set <- cbind(y, X)
data_set <- tbl_df(data_set)
```
![data_set](https://github.com/Edward-Aidi/pic-for-week4-project/raw/master/data_set.png)
### After combining test and train data of X and y and creating the complete data set, several statistical computation could be applied.
```
#2.Extracts only the measurements on the mean and standard deviation for each measurement as m & sd
m <- sapply(data_set[, 2:(nrow(cname)+1)], mean)
sd <- sapply(data_set[, 2:(nrow(cname)+1)], sd)
summary(m)
summary(sd)
```
![m](https://github.com/Edward-Aidi/pic-for-week4-project/raw/master/m.png)
![sd](https://github.com/Edward-Aidi/pic-for-week4-project/raw/master/sd.png)
```
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject as g
g <- aggregate(data_set[, 2:(nrow(cname)+1)], by = data_set[, 1], mean)
```
![g](https://github.com/Edward-Aidi/pic-for-week4-project/raw/master/g.png)
