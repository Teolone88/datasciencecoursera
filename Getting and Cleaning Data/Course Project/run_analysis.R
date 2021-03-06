library(data.table)
library(dplyr)

## Load data sets
train <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/train/X_train.txt")
train_labels <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/train/y_train.txt")
train_subject <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/train/subject_train.txt")
test <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/test/X_test.txt")
test_labels <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/test/y_test.txt")
test_subject <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/test/subject_test.txt")
act_lab <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/activity_labels.txt")
features <- fread("C:/Users/Teo/Documents/R/datasciencecoursera/UCI_HAR_Dataset/features.txt")

## Merge descriptive name to numeric label
x <- train_labels$V1
train_labels$activity <- case_when(
    x == 1 ~ "WALKING",
    x == 2 ~ "WALKING_UPSTAIRS",
    x == 3 ~ "WALKING_DOWNSTAIRS",
    x == 4 ~ "SITTING",
    x == 5 ~ "STANDING",
    x == 6 ~ "LAYING")
y <- test_labels$V1
test_labels$activity <- case_when(
    y == 1 ~ "WALKING",
    y == 2 ~ "WALKING_UPSTAIRS",
    y == 3 ~ "WALKING_DOWNSTAIRS",
    y == 4 ~ "SITTING",
    y == 5 ~ "STANDING",
    y == 6 ~ "LAYING")
## Merge subjects
MergeSubjects <- bind_rows(train_subject,test_subject)
## Merge labels
MergeLabels <- bind_rows(train_labels,test_labels)
## Remove redundant variable  no.1
MergeLabels <- select(MergeLabels,-1)
## Merge train and test data sets
MergedDT <- bind_rows(train,test)
## Assign vector of features to the colnames of data set
colnames(MergedDT) <- features$V2
## Merge all
MergeAll <- cbind(MergeSubjects,MergeLabels,MergedDT)
## Rename variables
colnames(MergeAll)[1] <- "Subject no."
## Exctract mean and sd for each variable
Extract.Mean <- sapply(MergeAll[,!c("Subject no.","activity")], mean)
Extract.Sd <- sapply(MergeAll[,!c("Subject no.","activity")],sd)
Extract <- matrix(,nrow = 2,ncol = 50)
Extract <- rbind(Extract.Mean,Extract.Sd)
## Aggregate mean for each variable by activity
FinalDT <- aggregate(MergeAll[,!c("Subject no.","activity")], list(MergeAll$activity,MergeAll$`Subject no.`), mean)
## Rename first variable
colnames(FinalDT)[c(1,2)] <- c("Activity","Subject no.")
write.csv(FinalDT, "Getting_and_Cleaning_Data_Course_Project.csv")
write.table(FinalDT, "Getting_and_Cleaning_Data_Course_Project.txt",row.names = F)
FTest <- read.table("Getting_and_Cleaning_Data_Course_Project.txt")
