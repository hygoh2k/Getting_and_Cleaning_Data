#Getting and Cleaning Data
=========================

##"run_analysis.R" performs the following steps to process data source
----------------------------------------------------------------------
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity      and each subject.

##Steps to run the script
--------------
 1. Download the data source and unzip it to working folder 
 2. In R, run "setwd" to set the current working directory
 3. run "source('run_analysis.R')". The script will process data source file and produce
    tidy_data.txt as output
