# suppose I save data in this work direcotry
#setwd("~/Desktop/UCI HAR Dataset/")

# step 1

# a)
# read features names and check its structure
features_name <- read.table("features.txt")
# head(features_name)
# V1                V2
# 1  1 tBodyAcc-mean()-X
# 2  2 tBodyAcc-mean()-Y

# b)
# read train/test data 
X_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")
y_train <- read.table("train/y_train.txt")
X_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")
y_test <- read.table("test/y_test.txt")

# c)
# combine them
X <- rbind(cbind(subject_train,y_train,X_train),
           cbind(subject_test, y_test, X_test))

# d)
# # and assign sutible name to its column
names(X) <- c("subject","label",as.character(features_name[,2]))

# step 2
# regular expression to find names which contains "mean" or "std"
# Note: match "mean(" to exclude some names like "fBodyBodyGyroJerkMag-meanFreq()"
idx <- grep("std|mean\\(",names(X),ignore.case=T)
X_mean_std <- X[,c(1,2,idx)]

# step 3
# first read activity label pair and replace the activity number 
# with descriptive activity label name 
activity_labels <- read.table("activity_labels.txt")
X_mean_std$label <- activity_labels[X_mean_std$label,""]

# step 4
# # I think the column names are descriptive enough!

# step 5
# a) extract "mean" in colnames only
library(dplyr)
idx <- grep("mean\\(",names(X_mean_std),ignore.case=T)
X1 <- X_mean_std[,c(1,2,idx)]

# b) group by subject and label, then calculate variable mean 
X1 %>%
        group_by(subject,label) %>%
                summarise_each(funs(mean))  -> res
# another way, with data.table
# data.table(X1)[,lapply(.SD, mean),by=("subject","y")] -> res great!
