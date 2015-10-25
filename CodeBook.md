#Code Book for the Johns Hopkins Coursera Getting and Cleaning Data Project#

##Variable/Feature Information

As discussed in the project instructions, the source data for this project was from a UCI machine learning repository.  The data itself is from experiments performed on 30 subject groups (ages between 18 and 48) and measured 3-dimensional movement of subjects while performing 6 motion related activities.  A number of 3-dimensional measurements were taken. In this data the letters X, Y, and Z are used to denote the 3 dimensions.


From the source data's feature info file:

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. 

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag


For each of these features the standard deviation and mean were calculated.  Although my understanding of the subject is limited, from the original notes I know the variables beginning with **t** are motion related and variables beginning with **f** are some type of frequency measurement. So in total there are about 66 features and 2 categorical variables.

The two categorical variables are:

1. Subject (listed twice as a factor and as text): values range from 1 to 30
2. Activity Description, which is one of the following:
  + WALKING
  + WALKING_UPSTAIRS
  + WALKING_DOWNSTAIRS
  + SITTING
  + STANDING
  + LAYING
  
## SUMMARY TABLE

The summary table that results from this analysis is a summary of the summary variables.  In essence, it is the mean value of the mean and standard deviation features for each subject group by activity performed.

## EXPERIMENTAL DESIGN

The project for this course is simply a data summarization exercise, with no experimental design.  From the original source data here is the design of the experiment:

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 