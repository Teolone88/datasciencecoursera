library(data.table)
library(dplyr)

## Downloaded and unzipped the file ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") 
## in the working directory due to slow laptop and convinience

## Load data sets
train <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/train/X_train.txt")
train_labels <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/train/y_train.txt")
test <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/test/X_test.txt")
test_labels <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/test/y_test.txt")
act_lab <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/activity_labels.txt")
features <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/features.txt")

## Merge descriptive name to numeric label for train set
x <- train_labels$V1
train_labels$activity <- case_when(
    x == 1 ~ "WALKING",
    x == 2 ~ "WALKING_UPSTAIRS",
    x == 3 ~ "WALKING_DOWNSTAIRS",
    x == 4 ~ "SITTING",
    x == 5 ~ "STANDING",
    x == 6 ~ "LAYING")
    
## Merge descriptive name to numeric label for test set    
y <- test_labels$V1
test_labels$activity <- case_when(
    y == 1 ~ "WALKING",
    y == 2 ~ "WALKING_UPSTAIRS",
    y == 3 ~ "WALKING_DOWNSTAIRS",
    y == 4 ~ "SITTING",
    y == 5 ~ "STANDING",
    y == 6 ~ "LAYING")
    
## Union train_labels and test_labels data sets    
MergeLabels <- bind_rows(train_labels,test_labels)

## Merge train and test data sets
MergedDT <- bind_rows(train,test)

## Exctract mean and sd for each variable
Extract.Mean <- sapply(MergedDT[1:50], mean)
Extract.Sd <- sapply(MergedDT[1:50],sd)

## Create matrix to fit previous vectors of mean and sd
Extract <- matrix(,nrow = 2,ncol = 50)
Extract <- rbind(Extract.Mean,Extract.Sd)

## Merge descriptive name to numeric label
MergedDT$activity <- MergeLabels$activity

## Aggregate mean for each variable by activity using aggregate function
FinalDT <- aggregate(MergedDT[,1:561], list(MergedDT$activity), mean)
