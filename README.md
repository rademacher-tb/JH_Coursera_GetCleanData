# Couse Project Notes for Johns Hopkins Coursera Course *Getting and Cleaning Data*

The source of this data is from UCI's machine learning datasets.  From the data providers:

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


## Data Transformations and Manipulations performed on the source data

###Filtering for only mean and standard deviation features

As indicated in the project instructions, the only features of interest for this project are mean and standard deviation features.  I chose to use the R search method **_grep_** to search for features that had standard deviation or mean.  Here are the code blocks for the searches:

```{r}
        df_analysis_test <- df_wearable[,sort(c(grep("std()", df_wearable_colnames$V2, fixed = TRUE), 
                                           grep("mean()", df_wearable_colnames$V2, fixed = TRUE))) 

```

###Merging Activity Descriptions and Subject IDs with the Feature Vector

Once the features were filtered for ones relevant to the project, the next step was to merge *activity* and *subject* attributes to the feature vector.  To add the *subjects* and and * *activity* codes I simply used a cbind function.  To add the descriptions however, a merge function was needed.  Here is the code block:

```{r}
df_activity_final <- merge(df_activity, df_activity_desc, by = "Activity_Code")

```
## Creation of the Summary Table

I chose to use the data table as it provides a simpler method for summarized data compared to other split-apply-combine methods when you have a lot of features in your dataset.  Particularly useful is the .SD component for j variables while applying the mean using lapply.  Here is the code block to calculate the averages:
```{r}
tbl_analysis_final <- as.data.table(df_analysis_final)
        tbl_analysis_summary <- tbl_analysis_final[,lapply(.SD,mean),by=c("Subject_ID","Subject_ID_fact","Activity_Desc")]
```
All numeric variables are means of previous calculated means or standard deviations.  All that was left was to write the summary table out.
