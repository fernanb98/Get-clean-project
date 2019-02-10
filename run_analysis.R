############################################################################
#
#                        INITIALIZATION SECTION
#
# run_analysis.R script
# Usage: run_analysis.R <Dataset directory> <output results file (optional)>
# If output results file is not found, out.txt used as default
############################################################################

args=commandArgs(trailingOnly=TRUE)

if((length(args)==0)||(length(args)>2)){
  stop("You must supply dataset directory and optionally output filename")
}else if  (length(args)==2){
  rootdir<-args[1]
  output<-args[2]
}else {
  rootdir<-args[1]
  output<-"out.txt"
}
setwd(rootdir)

#Define directory name where test and train sets will be merged
condensed<-"condensed"

#Remove directories created in a previous run of this program 
unlink(condensed,recursive=TRUE)

#Load helper functions
result<-source("get_all_files.R")
result<-source("condense.R")
result<-source("extract.R")

library(dplyr)

############################################################################
#
#                       END OF INITIALIZATION SECTION
#
############################################################################


############################################################################
#
#                        FUNCTION DEFINITION SECTION
#
############################################################################


describe_activities<-function(y,desc_file,y_desc){
  ############################################################################# 
  # describe_activities(y,desc_file,y_desc)                                   #               *
  # This function creates an output file that contains activities represented #
  # by activity name                                                          #
  # Input: y is the labels file                                               #
  #        desc_file is the file of descriptions for each activity number     #
  #        y_desc is the output file name                                     #
  # Output: file with labels represented by activity name                     #
  #############################################################################
  
  #Read activity name for each activity number
  activities<-read.csv(desc_file,sep="",header=FALSE)
  
  #Read merged activities dataset (y) 
  labels<-read.csv(y,sep="",header=FALSE)
  
  #For each activity number in the dataset get activity name
  #and generate a new dataframe 
  descriptive_labels<-apply(labels,1, function(x) activities[x,2] )
  
  #New dataframe headers
  names(descriptive_labels)<-c("","Activity")
  
  #Writes output file with activities represented by activity name
  result<-write.table(descriptive_labels, file=y_desc, col.names=F, row.names=F)
}

relabel<-function(df,feat){
  ############################################################################# 
  # relabel(df)                                                               #
  # This function substitute labels for each column with more descriptive     #
  # labels                                                                    #
  # Input: df data frame contanining data set                                 #
  #        feat file name of features description file                        #
  # Output: dataset with more descriptive column names                        #
  #############################################################################
  
  #Get variable name of each column, these are in the format V<variable number>
  oldlabels<-names(df)
  
  #Mantain only variable number for each column
  oldlabels<-sapply(oldlabels,function(x) strtoi(sub("V","",x)))
  
  features<-read.csv(feat,sep="",header=FALSE)
  
  #Substitute abbreviations and include _ separator
  newlabels<-sapply(oldlabels,function(x) features[x,2])
  newlabels<-gsub("^t","Time_",newlabels)
  newlabels<-gsub("^f","Frequency_",newlabels)
  newlabels<-gsub("Body","Body_",newlabels)
  newlabels<-gsub("Gravity","Gravity_",newlabels)
  newlabels<-gsub("Acc","Acceleration_",newlabels)
  newlabels<-gsub("Gyro","Gyroscope_",newlabels)
  newlabels<-gsub("Mag","Magnitude_",newlabels)
  newlabels<-gsub("erk","erk_",newlabels)
  newlabels<-gsub("_-"," -",newlabels)
  
  #Substitute labels of each column with the non abbreviated labels
  names(df)<-newlabels
  
  return(df)
}

join<-function(df,subject_file,activities_file,sep="", header=FALSE){
  
  #############################################################################
  # join (df,file,sep,header)                                                 #   # This function adds subject and activity name columns to the data set      #
  # Input: df is the data set                                                 #
  #       file filename that contains subject performin each observation      #
  #       sep is column separator, header TRUE if file contains header        #
  # Output: dataframe with dataset including subject and activity name        #
  #############################################################################
  
  subjects<-read.csv(subject_file,sep=sep,header=header,col.names="Subject")
  df<-cbind(df,subjects)
 
  activities<-read.csv(activities_file,sep=sep,header=header,col.names="Activity")
  df<-cbind(df,activities)
  return(df)
}

dotidy<-function(df){
  
  #############################################################################
  # dotidy (df)                                                               #
  # This function obtains average of all variables aggregated by subject      #
  #       and activity                                                        #
  #                                                                           #
  # Output: dataframe containing tidy dataset                                 #
  #############################################################################
  
  
  tidydf<-df %>% group_by(Subject,Activity) %>% summarise_all(funs(mean))
  return(tidydf)
}

###########################################################################
#
#                    END OF FUNCTION DEFINITION SECTION
#
###########################################################################

###########################################################################
#
#                               MAIN SECTION
#
###########################################################################

############################################################################
#
# STEP 1: Merge the training and test sets to create one data set
#
############################################################################

print("Performing step 1...")

#Get a list of all the files included in the train and test subdirectories
#Filenames will be separated by subdirectory

allfiles<-getallfiles(c("train","test"))

#Duplicate the directory structure from the train directory
duplicated<-list.dirs(path="train",full.names=TRUE,recursive=TRUE)
duplicated<-gsub("train",condensed,duplicated)

#Create directory structure for joined files
result<-mapply(dir.create,duplicated)

#Merge files from test and train directories

result<-mapply(condense,allfiles$test,allfiles$train,"test|train",condensed)

###########################################################################
#
#                              END OF STEP 1
#
###########################################################################

###########################################################################
#
# STEP 2: Extracts only the measurements on the mean and standard deviation
# for each measurement
#
###########################################################################

print("Performing step 2...")

# X variable contains the filepath of merged training and testing dataset

X<-file.path(condensed,paste0("X_",condensed,".txt"))

# These are the columns that contain mean and std of each measurement

columns<-c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,
          253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)

#Get a dataframe with only the desired columns from the dataset
dfextracted<-extract(X,columns)

###########################################################################
#
#                              END OF STEP 2
#
###########################################################################

###########################################################################
#
# STEP 3: Use descriptive activity names to name the activities in the data
# set
#
###########################################################################

print("Performing step 3...")

# y variable contains the name of the file with activity numbers for
# each observation
y<-file.path(condensed,paste0("y_",condensed,".txt"))

# y_desc is the name of the output file, it will contain activity description
# for each observation
y_desc<-file.path(condensed,paste0("y_descriptive_",condensed,".txt"))

# desc_file contains the name of the file with activity description 
# for each number
desc_file<-"activity_labels.txt"


describe_activities(y,desc_file,y_desc)

###########################################################################
#
#                              END OF STEP 3
#
###########################################################################


###########################################################################
#
# STEP 4: Appropiately labels the data set with descriptive variable names
#
###########################################################################

print("Performing step 4...")

dfrelabeled<-relabel(dfextracted,"features.txt")

###########################################################################
#
#                              END OF STEP 4
#
###########################################################################

###########################################################################
#
# STEP 5: From the data set in step 4, creates a second, independent tidy
# data set with the average of each variable for each activity and each
# subject
#
###########################################################################

print("Performing step 5...")

subjects<-file.path(condensed,paste0("subject_",condensed,".txt"))
activities<-file.path(condensed,paste0("y_descriptive_",condensed,".txt"))
dfjoined<-join(dfrelabeled,subjects,activities)

tidydf<-dotidy(dfjoined)

result<-write.table(tidydf, file=output,col.names=F, row.names=F)
print(paste("Please check your results at ",output))

###########################################################################
#
#                              END OF STEP 5
#
###########################################################################

###########################################################################
#
#                          END OF MAIN SECTION
#
###########################################################################

