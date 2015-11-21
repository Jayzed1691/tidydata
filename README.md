# tidydata
Repository for the Coursera Johns Hopkins Getting and Cleaning Data Course project

The code in run_analysis.R is used to read several files from the "Human Activity Recognition Using Smartphones Dataset" containing data collected from Samsung Galaxy S smartphones.

The original file set can be found at:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The zip file contains the following  nested directory structure:

/UCI HAR Dataset
/UCI HAR Dataset/test
/UCI HAR Dataset/train
/UCI HAR Dataset/test/Inertial Signals
/UCI HAR Dataset/train/Inertial Signals

The parent directory contains several descriptive and data files:
  - 'activity_labels.txt' - the link from the activity class labels to their descriptive labels (6 in total)
  - 'features.txt' - the variables observed (561 items denoting time and frequency signals from the accelerometer and gyroscope through a     series of movements and transformations).
  - 'README.txt' - provides an overview of the project and associated data files
  - 'features_info.txt' - a listing and description of the variables included
  
Each sub-directory contains the data files to be transformed through this exercise, specific to the "test" or "train" group.  As the data will be combined into a single file, this distinction, while preserved in the aggregate data.table, the discussion and code treats the respective files equivalently:
  - 'subject_test.txt' and 'subject_train.txt' - identifies the subject who performed the measured activities
  - 'X_test.txt' and 'X_train.txt' - contains the observations for the research
  - 'y_test' and 'y_train.txt' - contains the test labels for each observation

The 'Inertial Signals' were not required for the purpose of this exercise, and so will not be discussed further.

The assignment states that the code can be run assuming the required data files reside in the working directory.  I have made the assumption that the original zip file was downloaded to the working directory and unzipped with the original directory structure intact.

The various 'read' statements make use of this directory structure, but I have also included the requisite code to replicate the downloading and unzipping steps at the top of the block as comments, to be used if necessary.



