###
#Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# run_analysis.R  does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#download the zip file
if(!file.exists("data")){dir.create("data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/getdata_project.zip",method="auto")
dateDownloaded <- date()

#extract the files
unzip("./data/getdata_project.zip", exdir='./data')

### Load features.txt to a table to get all variable names of dataset
features_txt<- read.table('./data/UCI HAR Dataset/features.txt',col.names=c('variable_no','variable_name'))

### Load activity_labels.txt file to a table for mapping of activity labels to names.
activities <- read.table('./data/UCI HAR Dataset/activity_labels.txt',col.names=c('activity_id','activity_name'))

### Load data sets for both train and set, together with their activity labels. 
### columns for data set are taken from features_txt labels
### Column name for y_ label is set to "activity_id"
### Variable name for subject_ is set to "subject_id"
x_train<- read.table('./data/UCI HAR Dataset/train/X_train.txt', col.names=features_txt$variable_name)
y_train<- read.table('./data/UCI HAR Dataset/train/Y_train.txt',col.names='activity_id')
x_test<- read.table('./data/UCI HAR Dataset/test/X_test.txt', col.names=features_txt$variable_name)
y_test<- read.table('./data/UCI HAR Dataset/test/Y_test.txt',col.names='activity_id')
subject_train <- read.table('./data/UCI HAR Dataset/train/subject_train.txt', col.names='subject_id')
subject_test <- read.table('./data/UCI HAR Dataset/test/subject_test.txt', col.names='subject_id')

#combine the activty labels and subject labels to its respective data set. 
train_data <- cbind(y_train, subject_train, x_train)
test_data <- cbind(y_test, subject_test, x_test)

#combine all into one single data set
train_and_test_data <- rbind(train_data, test_data)

#Merge activities table into data set to give a descriptive label of the activities done. 
train_and_test_data <- merge(activities, train_and_test_data)
?merge
### Get the columns for means and standard deviation. 
### This also includes the weighted average of frequency components (also known as mean frequency).

# generate string pattern. 
ptn_mean = '*ean*'
ptn_std = '*std*'

#create a vector that contains 1st 2 columns of dataset for activity and subject, and then
# use grep to look for column names matching the patterns to get mean / Mean and std
variable_vector_for_required_columns<- sort(c(2,3,grep(ptn_mean,names(train_and_test_data)),grep(ptn_std,names(train_and_test_data))))

#Select only the variables with mean and std, including mean frequency. 
data_means_and_std <- select(train_and_test_data,variable_vector_for_required_columns)

# Group the data by activity and subject, then apply the function mean to all the variables for each grouping. 
data_summarized_by_activity_and_subject <- group_by(data_means_and_std,activity_name,subject_id) %>% summarize_each(funs(mean))

#Write dataset to file
write.table(data_summarized_by_activity_and_subject,file="./data/final_dataset.txt",row.name=FALSE)




