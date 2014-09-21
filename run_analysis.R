#1)Merges the training and the test sets to create one data set.
#2)Extracts only the measurements on the mean and standard deviation for each measurement. 
#3)Uses descriptive activity names to name the activities in the data set
#4)Appropriately labels the data set with descriptive variable names. 
#5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd('C:/data_science/')

#######################################################
#reading common label information and table information
#######################################################
#read from file
activity_labels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

#generate a list that contains index of matched features
features_index_matched <- grep("mean|std", features[,2])


#######################################################
#reading test set 
#######################################################
#read from file
x_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
#Extracts only the measurements on the mean and standard deviation for each measurement.
x_test <- x_test[,features_index_matched]
#read from file
y_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
#read from file
subject_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
#combine the columns
test_combined <- cbind(subject_test,y_test,x_test)


#######################################################
#reading training set
#######################################################
#read from file
x_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
#Extracts only the measurements on the mean and standard deviation for each measurement.
x_train <- x_train[,features_index_matched]
#read from file
y_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
#read from file
subject_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
#combine the columns
train_combined <- cbind(subject_train,y_train,x_train)


#######################################################
# Merges the training and the test sets to create one data set
#######################################################
#combine measurements from 2 tables
data_combined <- rbind(test_combined,train_combined)
#create id columns
id_col_names <- c("subject", "activity")
#create data columns from std and mean features
var_col_names <- as.character(features[,2][features_index_matched])
#generate colume names
col_names <- c(id_col_names, var_col_names)
#assign the colume names to table
colnames(data_combined) <- col_names


#######################################################
# process mean data
#######################################################
#melting data frame based on id columes, setting the data columes as measurement variables as we want to calculate them later
melt_data <- melt(data = data_combined, id.vars = id_col_names, measure.vars = var_col_names)
#casting data and calculate the mean of the variables
tidy_data <- dcast(melt_data, subject + activity ~ variable, mean)
#convert the activity id to meaningful label
tidy_data$activity<-activity_labels[,2][tidy_data$activity]
#write out the data to file
write.table(tidy_data,file = 'tidy_data.txt', row.names=FALSE)
