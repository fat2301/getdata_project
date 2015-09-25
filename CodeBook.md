
##run_analysis.R  
 Merges the training and the test sets to create one data set.
 
 Extracts only the measurements on the mean and standard deviation for each measurement. 
 
 Uses descriptive activity names to name the activities in the data set. 
 
 Appropriately labels the data set with descriptive variable names. 
 
 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
---
Steps to process the file: 

1) download the zip file

2) extract the files

3) Load features.txt to a table to get all variable names of dataset

4) Load activity_labels.txt file to a table for mapping of activity labels to names.

5) Load data sets for both train and set, together with their activity labels. Columns for data set are taken from features_txt labels. Column name for y_ label is set to "activity_id". Variable name for subject_ is set to "subject_id"

6) Combine the activty labels and subject labels to its respective data set using column bind. 

7) Combine all into one single data set using row bind. 

8) Merge activities table into data set to give a descriptive label of the activities done, using merge command. 

9) Get the columns for means and standard deviation. This also includes the weighted average of frequency components (also known as mean frequency). This is done by using grep command to search for pattern for "ean" to get column names with either mean or Mean, and look for pattern for "std" for standard deviation columns. 

10) Group the data by activity and subject, then apply the function mean to all the variables for each grouping. This summarizes the data, getting the mean of the measurements for each subject / activity combination. 

---
Quick description of all 88 columns in the final dataset:

Final dataset is grouped by activity_name and subject_id. For each activity / subject combination, it provides the mean of the different measures: eg. mean of the means of measurements, or mean of the standard deviations, or mean of the frequency means. 

"activity_name" : Actual names for the activities done. 6 possible text values: 
	WALKING
	WALKING_UPSTAIRS
	WALKING_DOWNSTAIRS
	SITTING
	STANDING
	LAYING

"subject_id" : Subject label, refers to any one of the 30 volunteers. Integer from 1:30. 

"tBodyAcc.mean...X" : mean of mean of tBodyAcc for X axis

"tBodyAcc.mean...Y"  : mean of mean of tBodyAcc for Y axis

"tBodyAcc.mean...Z"  : mean of mean of tBodyAcc for Z axis

"tBodyAcc.std...X"   : mean of standard deviation of tBodyAcc for X axis

"tBodyAcc.std...Y"   : mean of standard deviation of tBodyAcc for Y axis

"tBodyAcc.std...Z"   : mean of standard deviation of tBodyAcc for Z axis

"tGravityAcc.mean...X" : mean of mean of tGravityAcc for X axis

"tGravityAcc.mean...Y" : mean of mean of tGravityAcc for Y axis

"tGravityAcc.mean...Z" : mean of mean of tGravityAcc for Z axis

"tGravityAcc.std...X" : mean of standard deviation of  for X axis

"tGravityAcc.std...Y" : mean of standard deviation of  for Y axis

"tGravityAcc.std...Z" : mean of standard deviation of  for Z axis

"tBodyAccJerk.mean...X" : mean of mean of tBodyAccJerk for X axis

"tBodyAccJerk.mean...Y" : mean of mean of tBodyAccJerk for Y axis

"tBodyAccJerk.mean...Z" : mean of mean of tBodyAccJerk for Z axis

"tBodyAccJerk.std...X" : mean of standard deviation of tBodyAccJerk  for X axis

"tBodyAccJerk.std...Y" : mean of standard deviation of tBodyAccJerk for Y axis

"tBodyAccJerk.std...Z" : mean of standard deviation of tBodyAccJerk

"tBodyGyro.mean...X" : mean of mean of tBodyGyro for X axis

"tBodyGyro.mean...Y" : mean of mean of tBodyGyro for Y axis

"tBodyGyro.mean...Z" : mean of mean of tBodyGyro for Z axis

"tBodyGyro.std...X" : mean of standard deviation of tBodyGyro for X axis

"tBodyGyro.std...Y": mean of standard deviation of tBodyGyro for Y axis

"tBodyGyro.std...Z" : mean of standard deviation of tBodyGyro for Z axis

"tBodyGyroJerk.mean...X" : mean of mean of tBodyGyroJerk for X axis

"tBodyGyroJerk.mean...Y" : mean of mean of tBodyGyroJerk for Y axis

"tBodyGyroJerk.mean...Z" : mean of mean of tBodyGyroJerk for Z axis

"tBodyGyroJerk.std...X" : mean of standard deviation of tBodyGyroJerk for X axis

"tBodyGyroJerk.std...Y" : mean of standard deviation of tBodyGyroJerk for Y axis

"tBodyGyroJerk.std...Z" : mean of standard deviation of tBodyGyroJerk for Z axis

"tBodyAccMag.mean.." : mean of mean of tBodyAccMag

"tBodyAccMag.std.." : mean of standard deviation of tBodyAccMag

"tGravityAccMag.mean.." : mean of mean of tGravityAccMag

"tGravityAccMag.std.." : mean of standard deviation of tGravityAccMag

"tBodyAccJerkMag.mean.." : mean of mean of tBodyAccJerkMag

"tBodyAccJerkMag.std.." : mean of standard deviation of tBodyAccJerkMag

"tBodyGyroMag.mean.." : mean of mean of tBodyGyroMag

"tBodyGyroMag.std.." : mean of standard deviation of tBodyGyroMag

"tBodyGyroJerkMag.mean.." : mean of mean of tBodyGyroJerkMag

"tBodyGyroJerkMag.std.." : mean of standard deviation of tBodyGyroJerkMag

"fBodyAcc.mean...X" : mean of mean of fBodyAcc for X axis

"fBodyAcc.mean...Y" : mean of mean of fBodyAcc for Y axis

"fBodyAcc.mean...Z" : mean of mean of fBodyAcc for Z axis

"fBodyAcc.std...X" : mean of standard deviation of fBodyAcc for X axis

"fBodyAcc.std...Y" : mean of standard deviation of fBodyAcc for Y axis

"fBodyAcc.std...Z" : mean of standard deviation of fBodyAcc

"fBodyAcc.meanFreq...X" : mean of frequency mean of fBodyAcc for X axis

"fBodyAcc.meanFreq...Y" : mean of frequency mean of fBodyAcc for Y axis

"fBodyAcc.meanFreq...Z" : mean of frequency mean of fBodyAcc

"fBodyAccJerk.mean...X" : mean of mean of fBodyAccJerk for X axis

"fBodyAccJerk.mean...Y" : mean of mean of fBodyAccJerk for Y axis

"fBodyAccJerk.mean...Z" : mean of mean of fBodyAccJerk for Z axis

"fBodyAccJerk.std...X" : mean of standard deviation of fBodyAccJerk  for X axis

"fBodyAccJerk.std...Y" : mean of standard deviation of fBodyAccJerk for Y axis

"fBodyAccJerk.std...Z" : mean of standard deviation of fBodyAccJerk

"fBodyAccJerk.meanFreq...X" : mean of frequency mean of fBodyAccJerk for X axis

"fBodyAccJerk.meanFreq...Y" : mean of frequency mean of fBodyAccJerk for Y axis

"fBodyAccJerk.meanFreq...Z" : mean of frequency mean of fBodyAccJerk

"fBodyGyro.mean...X" : mean of mean of fBodyGyro for X axis

"fBodyGyro.mean...Y" : mean of mean of fBodyGyro for Y axis

"fBodyGyro.mean...Z" : mean of mean of fBodyGyro for Z axis

"fBodyGyro.std...X" : mean of standard deviation of fBodyGyro for X axis

"fBodyGyro.std...Y" : mean of standard deviation of fBodyGyro for Y axis

"fBodyGyro.std...Z" : mean of standard deviation of fBodyGyro for Z axis

"fBodyGyro.meanFreq...X" : mean of frequency mean of fBodyGyro for X axis

"fBodyGyro.meanFreq...Y" : mean of frequency mean of fBodyGyro for Y axis

"fBodyGyro.meanFreq...Z" : mean of frequency mean of fBodyGyro for Z axis

fBodyAccMag.mean.." : mean of mean of fBodyAccMag

"fBodyAccMag.std.." : mean of standard deviation of fBodyAccMag

"fBodyAccMag.meanFreq.." : mean of frequency mean of fBodyAccMag

"fBodyBodyAccJerkMag.mean.." : mean of mean of fBodyAccJerkMag

"fBodyBodyAccJerkMag.std.." : mean of standard deviation of fBodyAccJerkMag

"fBodyBodyAccJerkMag.meanFreq.." : mean of frequency mean of fBodyAccJerkMag

"fBodyBodyGyroMag.mean.." : mean of mean of fBodyGyroMag

"fBodyBodyGyroMag.std.." : mean of standard deviation of fBodyGyroMag

"fBodyBodyGyroMag.meanFreq.." : mean of frequency mean of fBodyGyroMag

"fBodyBodyGyroJerkMag.mean.." : mean of mean of fBodyGyroJerkMag

"fBodyBodyGyroJerkMag.std.." : mean of standard deviation of fBodyGyroJerkMag

"fBodyBodyGyroJerkMag.meanFreq.." : mean of frequency mean of fBodyGyroJerkMag

"angle.tBodyAccMean.gravity." : mean of mean of angle tBodyAcc gravity 

"angle.tBodyAccJerkMean..gravityMean." : mean of mean of angle tBodyAccJerk gravity 

"angle.tBodyGyroMean.gravityMean." : mean of mean of angle tBodyGyro gravity 

"angle.tBodyGyroJerkMean.gravityMean." : mean of mean of angle tBodyGyroJerk gravity 

"angle.X.gravityMean." : mean of mean of angle X gravity 

"angle.Y.gravityMean." : mean of mean of angle Y gravity 

"angle.Z.gravityMean.": mean of mean of angle Z gravity 
