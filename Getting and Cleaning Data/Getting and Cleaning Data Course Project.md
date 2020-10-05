The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

#### Review criteria
 
1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.

The work submitted for this project is the work of the student who submitted it.
Getting and Cleaning Data Course Project
less 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Good luck!

```{R}
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
```
