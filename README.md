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

=========================================================================================

Files included in this repo

=========================================================================================

	Codebook.md                     Code book of the output file, and full description of activities performed by 						run_analysis.R       					
	get_all_files.R			Code to scan directories of the dataset and obtain full list of files 
	condense.R			Code to merge files from the test and train dataset
	extract.R			Code to extract only mean and standard deviation related variables from dataset
	run_analysis.R			Main program 

=========================================================================================

How to run the script

=========================================================================================



	To run the script, from the command line:
		1.-Create directory to download the dataset 
		2.-Download the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to directory created in 1.
		3.-Create directory for program files
		4.-Change your current directory to directory created in 3.
		5.-Clone this repo using git clone
		6.-run "Rscript run_analysis.R <dataset directory> <optional output file>" don't include < > symbols in your command. If you don't supply  an output file default is "out.txt" in your current directory.


If you run the script from Rstudio in step 5 type system("Rscript run_analysis.R <dataset directory> <optional output file>), note that first you should change your working directory to the location where you cloned this repo with setwd() or supply the full path. 

After you run the script you should find in your dataset directory the "condensed" directory, containing all merged files. 
Also, the final tidy dataset will be located at the output file you specified or "out.txt" if you don't specify any when you run the script.

==========================================================================================

Tidy dataset

==========================================================================================

The final tidy dataset as requested in Step 5 of the project is included as "tidy_final_result.txt"



That's all!

Thank you very much for your time reviewing this project.











