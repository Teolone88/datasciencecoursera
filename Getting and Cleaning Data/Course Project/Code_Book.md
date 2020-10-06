# Code Book
### The following tasks below are the contents of run_analysis.R script: 

### 1. Download the dataset

- Dataset downloaded and extracted under the folder called UCI HAR Dataset

### 2. Assign each data to variables

- `features` <- features.txt : 561 rows, 2 columns

  - The features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

- `activities` <- activity_labels.txt : 6 rows, 2 columns

  - List of activities was done when the corresponding assessment were taken and its coded labels

- `subject_test` <- test/subject_test.txt : 2947 rows, 1 column

  - contains test data of 9/30 volunteer test subjects that were observed

- `x_test` <- test/X_test.txt : 2947 rows, 561 columns

  - contains the noted features test data

- `y_test` <- test/y_test.txt : 2947 rows, 1 columns

  - contains test data of activities’ coded labels

- `subject_train` <- test/subject_train.txt : 7352 rows, 1 column

  - contains train data of 21/30 volunteer subjects that were observed

- `x_train` <- test/X_train.txt : 7352 rows, 561 columns

  - contains note features train data

- `y_train` <- test/y_train.txt : 7352 rows, 1 columns

  - contains train data of activities’code labels

### 3. Merges the training and the test sets to create one data set
- `MergedDT` is created by merging (`x_train` and `x_test`) & (`y_train` and `y_test`) using `bind_rows()` function
- `MergeSubjects` is created by merging `subject_train` and `subject_test` using `bind_rows()` function
- `MergeAll` is created by merging `subject_set`, `y_set` and `x_set` using `cbind()` function

### 4. Extracts only the measurements on the mean and standard deviation for each measurement
- `Extract`(mean & Sd) is created by Sapplying the `data_set`; selecting the columns of subject, code, the mean and the standard deviation for each data

### 5. Uses descriptive activity names to name the activities in the data set
- The whole data in code column of `tidy_data` is replaced with the corresponding `activity` that taken from the second column of `activities` variable using `case_when` function.

### 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- `FinalDT` is created by summarizing `tidy_data` through taking the mean for each variable, for each activity and for each subject, then they were group by subject and activity.
- The export `FinalDT` was made and named `Getting_and_Cleaning_Data_Course_Project.txt`.
