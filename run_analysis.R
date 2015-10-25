
####################  A C K N O W L E D G E M E N T S ###################################
#
#
#
#
#
#########################################################################################

#   INSTALL NECESSARY PACKAGES

  install.packages("plyr")
  install.packages("data.table")
  library(plyr)
  library(dplyr)
  library(data.table)


#   LOAD THE TRAINING DATA AND THE FEATURE VARIABLE LIST
#   ASSIGN THE FEATURE VARIABLE LIST AS COLUMN NAMES
  
        df_wearable <- read.table("../UCI HAR Dataset/train/X_train.txt")
        df_wearable_colnames <- read.table("../UCI HAR Dataset/features.txt")
        colnames(df_wearable) <- df_wearable_colnames$V2

#   KEEP ONLY THE FEATURES RELATED TO STANDARD DEVIATION OR MEAN  

        df_analysis <- df_wearable[,sort(c(grep("std()", df_wearable_colnames$V2, fixed = TRUE), 
                                           grep("mean()", df_wearable_colnames$V2, fixed = TRUE))) 
                                   ]
        remove(df_wearable)
        remove(df_wearable_colnames)

#   LOAD CORRESPONDING ACTIVITY FOR THE FEATURES AND MERGE IT AS A COLUMN
      
        df_activity <- read.table("../UCI HAR Dataset/train/y_train.txt", col.names = c("Activity_Code"))
        df_activity_desc <- read.table("../UCI HAR Dataset/activity_labels.txt", col.names = c("Activity_Code","Activity_Desc"))
        df_activity_final <- merge(df_activity, df_activity_desc, by = "Activity_Code")
        
        remove(df_activity)
        remove(df_activity_desc)
        
        df_analysis <- cbind(df_activity_final$Activity_Desc, df_analysis)
        
        remove(df_activity_final)

#   LOAD CORRESPONDING SUBJECT IDs FOR THE FEATURES AND MERGE IT AS A COLUMN
        
        df_subjects <- read.table("../UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject_ID"))
        df_analysis <- cbind(df_subjects$Subject_ID, df_analysis)
        df_subjects$Subject_ID <- factor(df_subjects$Subject_ID)
        df_analysis <- cbind(df_subjects$Subject_ID, df_analysis)
        remove(df_subjects)


#################### END LOADING OF TRAINING DATA, BEGIN LOAD OF TEST DATA ########################
        
        #   LOAD THE TEST DATA AND THE FEATURE VARIABLE LIST
        #   ASSIGN THE FEATURE VARIABLE LIST AS COLUMN NAMES
        
        df_wearable <- read.table("../UCI HAR Dataset/test/X_test.txt")
        df_wearable_colnames <- read.table("../UCI HAR Dataset/features.txt")
        colnames(df_wearable) <- df_wearable_colnames$V2
        
        #   KEEP ONLY THE FEATURES RELATED TO STANDARD DEVIATION OR MEAN  
        
        df_analysis_test <- df_wearable[,sort(c(grep("std()", df_wearable_colnames$V2, fixed = TRUE), 
                                           grep("mean()", df_wearable_colnames$V2, fixed = TRUE))) 
                                   ]
        remove(df_wearable)
        remove(df_wearable_colnames)
        
        #   LOAD CORRESPONDING ACTIVITY FOR THE FEATURES AND MERGE IT AS A COLUMN
        
        df_activity <- read.table("../UCI HAR Dataset/test/y_test.txt", col.names = c("Activity_Code"))
        df_activity_desc <- read.table("../UCI HAR Dataset/activity_labels.txt", col.names = c("Activity_Code","Activity_Desc"))
        df_activity_final <- merge(df_activity, df_activity_desc, by = "Activity_Code")
        
        remove(df_activity)
        remove(df_activity_desc)
        
        df_analysis_test <- cbind(df_activity_final$Activity_Desc, df_analysis_test)
        
        remove(df_activity_final)
        
        #   LOAD CORRESPONDING SUBJECT IDs FOR THE FEATURES AND MERGE IT AS A COLUMN
        
        df_subjects <- read.table("../UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject_ID"))
        df_analysis_test <- cbind(df_subjects$Subject_ID, df_analysis_test)
        df_subjects$Subject_ID <- factor(df_subjects$Subject_ID)
        df_analysis_test <- cbind(df_subjects$Subject_ID, df_analysis_test)
        remove(df_subjects)
        
    
        
  ########################### MERGE THE TEST AND TRAINING DATA SETS #########################
  
        df_analysis_final <- rbind(df_analysis, df_analysis_test)
        remove(df_analysis)
        remove(df_analysis_test)
        
        colnames(df_analysis_final)[1] <- "Subject_ID"
        colnames(df_analysis_final)[2] <- "Subject_ID_fact"
        colnames(df_analysis_final)[3] <- "Activity_Desc"
        
        
  ########
 

        tbl_analysis_final <- as.data.table(df_analysis_final)
        tbl_analysis_summary <- tbl_analysis_final[,lapply(.SD,mean),by=c("Subject_ID","Subject_ID_fact","Activity_Desc")]
        
        #View(tbl_analysis_summary)
        write.table(tbl_analysis_summary, "tbl_analysis_summary.txt")
        