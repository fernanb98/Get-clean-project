===================================================================
Getting and Cleaning Data Course Project
Version 1.0
===================================================================
Fernando Baz García
Mexico City, 01090 México
fernanb_98@yahoo.com
===================================================================

This is the final Cleaning Data Course Project. The purpose of this project is to demonstrate ability to collect, work with and clean a data set. The dataset contains the results of experiments on Human Activity Recognition using smartphones, carried out with a group of 30 volunteers, where each person performend six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone. The 3-axial linear acceleration and 3-axial angular velocity were captured from the smartphone embeded accelerometer and gyroscope. The data can be donwloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original data whas partitioned in two sets, where 70% of the volunteers were selected for generating the training data an 30% the test data.

The original dataset and description files are structured as follows:

	-UCI HAR Dataset
		|-README.txt
		|-activity_labels.txt
		|-features.txt
		|-features_info.txt
		|------test
			|-subject_test.txt
			|-X_test.txt
			|-y_test.txt
			|--InertialSignals
				|-body_acc_x_test.txt
				|-body_acc_y_test.txt
				|-body_acc_z_test.txt
				|-body_gyro_x_test.txt
				|-body_gyro_y_test.txt
				|-body_gyro_z_test.txt
				|-total_acc_x_test.txt
				|-total_acc_y_test.txt
				|-total_acc_z_test.txt
	
		|------train
			|-subject_train.txt
			|-X_train.txt
			|-y_train.txt
			|--InertialSignals
				|-body_acc_x_train.txt
				|-body_acc_y_train.txt
				|-body_acc_z_train.txt
				|-body_gyro_x_train.txt
				|-body_gyro_y_train.txt
				|-body_gyro_z_train.txt
				|-total_acc_x_train.txt
				|-total_acc_y_train.txt
				|-total_acc_z_train.txt

README.txt contains a description of these file contents. Its reproduced below:

	- 'features_info.txt': Shows information about the variables used on the feature vector.
	
	- 'features.txt': List of all features.
	
	- 'activity_labels.txt': Links the class labels with their activity name.
	
	- 'train/X_train.txt': Training set.
	
	- 'train/y_train.txt': Training labels.
	
	- 'test/X_test.txt': Test set.
	
	- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

	- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
	
	- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
	
	- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
	
	- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


This project consist of five steps, for each one follows a description of activities, variables and values.

1.- Merge the training and test sets to create one data set
===========================================================
Activities:
	A.-Get two lists of files, included in train and test subdirectories.
	B.-Get the directory structure of train dataset(or test dataset, as they are equal). This means a list of all its 		subdirectories.
	C.-Using B as a template, create a new directory structure, that will contain the merged train and test files. This 		directory will be called "condensed".
	D.-For each member of A, read the corresponding train and test files in separate dataframes, then combine its rows in a 	new dataframe. 
	E.-For each new dataframe in D, create a new file, at the directory structure created in C. Filenames will be same as 		original, replacing "test" or "train" with word "condensed". 

As this step only merges existing data, variable names and descriptions are the same as original data. Test dataset contains 2947 rows for X_test, and train dataset contains 7352 rows for X_train, so resulting merged datafiles contain 10299 rows each. 


2.-Extract only the measurements on the mean and standard deviation for each measurement
========================================================================================

Activities:

	A.-Using the variable names included in features.txt, select those that include mean() or std(). These are (1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)
	
	B.-Read condensed X_condensed.txt into a dataframe.
	C.-Create a new dataframe(named dfextracted) extracting columns selected in A. 

3.-Use descriptive activity names to name the activities in the data set
========================================================================================
Activities:

	A.-Read the y_condensed.txt file into a dataframe
	B.-Read the activity description file "activity_labels.txt" into a dataframe
	C.-For each activity number found in y_condensed.txt, replace it for its corresponding activity label
	D.-Store the results of C in a new file called y_descriptive_condensed.txt

4.-Appropiately label the data set with descriptive variable names
========================================================================================
Activities:

	A.-Get the column variable numbers of  dfextracted dataframe obtained in step 2. These are in the following format: 			V<variable number>. Variable number corresponds to number found in features.txt
	B.-For each variable number, obtain variable name from features.txt
	C.-For each variable name, do the following substitutions:
		Initial "t" for "time"
		Initial "f" for "Frequency"
		"Acc" for "Acceleration"
		"Gyro" for "Gyroscope"
		"Mag" for "Magnitude"
	   Also separate variable name parts with "_" to improve readability. 
	D.-Change column names of dfextracted dataframe by new names. This is stored in dfrelabeled dataframe.

5.- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
========================================================================================
Activities:

	A.-Read the y_descriptive_condensed.txt file, this includes text description of each activity performed (10,299 rows), 		for example WALKING, STANDING...
	B.-Read the subject_condensed.txt file, this includes subject number for each activity performed (10,299 rows)
	C.-Add Subject and Activities columns to dfrelabeled dataframe obtained in step 4. Store results in dfjoined dataframe.
	D.-Group dfjoined dataframe by Subject and Activity
	E.-For each column obtain mean of observations for each Subject and Activity
	F.-Store results in tidydf dataframe and store it in output file. This file consists of 180 rows and a header row (total 		181).Each row consists of 68 columns.

Final tidydf complies with the following:

	1.-Each variable is in a separate column
	2.-Each different observation (in this case the mean of observations) is in a different row.
	3.-Only one table is created, as all variables are of the same "kind"
	4.-There is no need of a column to link tables, as only one table is created

Description of each one of the 68 columns of tidy dataset
	1	Subject id
	2	Activity name
	3-5	Mean of (Time domain mean of body acceleration)  in X, Y and Z axis
	6-8	Mean of (Time domain standard deviation of body acceleration) in X, Y and Z axis
	9-11	Mean of (Time domain mean of gravity acceleration) in X, Y and Z axis
	12-14	Mean of (Time domain standard deviation of gravity acceleration) in X,Y and Z axis
	15-17	Mean of (Time domain mean of body acceleration jerk) in X, Y and Z axis
	18-20	Mean of (Time domain standard deviation of body acceleration jerk) in X, Y and Z axis
	21-23	Mean of (Time domain mean of body angular velocity) in X, Y and Z axis
	24-26	Mean of (Time domain standard deviation of body angular velocity) in X, Y and Z axis
	27-29	Mean of (Time domain mean of body angular velocity jerk) in X, Y and Z axis
	30-32	Mean of (Time domain standard deviation of angular velocity jerk) in X, Y and Z axis
	33	Mean of (Time domain mean of body acceleration magnitude)
	34 	Mean of (Time domain standard deviation of body acceleration magnitude)
	35	Mean of (Time domain mean of gravity acceleration magnitude)
	36	Mean of (Time domain standard deviation of gravity acceleration magnitude)
	37	Mean of (Time domain mean of body acceleration jerk magnitude)
	38	Mean of (Time domain standard deviation of body acceleration jerk magnitude)
	39	Mean of (Time domain mean of body angular velocity magnitude)
	40	Mean of (Time domain standard deviation of angular velocity magnitude)
	41	Mean of (Time domain mean of body angular velocity jerk magnitude)
	42	Mean of (Time domain standard deviation of body angular velocity jerk magnitude)
	43-45	Mean of (Frequency domain mean of body acceleration) in X, Y and Z axis
	46-48	Mean of (Frequency domain standard deviation of body acceleration) in X, Y and Z axis
	49-51	Mean of (Frequency domain mean of body acceleration jerk) in X, Y and Z axis
	52-54	Mean of (Frequency domain standard deviation of body acceleration jerk) in X, Y and Z axis
	55-57	Mean of (Frequency domain mean of body angular velocity) in X, Y and Z axis
	58-60	Mean of (Frequency domain standard deviation of body angular velocity) in X, Y and Z axis
	61	Mean of (Frequency domain mean of body acceleration magnitude)
	62	Mean of (Frequency domain standard deviation of body acceleration magnitude)
	63	Mean of (Frequency domain mean of body acceleration jerk magnitude)
	64	Mean of (Frequency domain standard deviation of body acceleration jerk magnitude)
	65	Mean of (Frequency domain mean of body angular velocity magnitude)
	66	Mean of (Frequency domain standard deviation of body angular velocity magnitude)
	67	Mean of (Frequency domain mean of body angular velocity jerk magnitude)
	68	Mean of (Frequency domain standard deviation of body angular velocity jerk magnitude)

Variables in parenthesis are obtained from original dataset, the word "mean" and "standard deviation" here are calculated for the sampling windows of 2.56 sec each with 50% overlap (128 readings/windows) as is explained in README.txt of original dataset. Acceleration is expressed in standard gravity units 'g'. Angular velocity units are radians/second. 

















		


	















