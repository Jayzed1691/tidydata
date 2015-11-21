# tidydata
Repository for the Coursera Johns Hopkins Getting and Cleaning Data Course project

The code in run_analysis.R is used to read several files from the "Human Activity Recognition Using Smartphones Dataset" containing data collected from Samsung Galaxy S smartphones.

The original file set can be found at:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The zip file contains the following  nested directory structure:

  - /UCI HAR Dataset
  - /UCI HAR Dataset/test
  - /UCI HAR Dataset/train
  - /UCI HAR Dataset/test/Inertial Signals
  - /UCI HAR Dataset/train/Inertial Signals

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

I have additionally included, as a comment block, several lines of code that would download the zip file to a temporary connection and unzip and read only the required files.  This is my preferred method but, again, is not required for the purpose of the assignment.

The first block of active code is a series of read.table calls on the 8 required files:
  - 'subject_train.txt' reads into 'train_subject' with a column name of 'testsubject' applied
  - 'subject_test.txt' reads into 'test_subject' with a column name of 'testsubject' applied
  - 'y_train.txt' reads into 'train_activity' with a column name of 'activitycode' to facilitate a later join
  - 'y_test.txt' reads into 'test_activity' with a column name of 'activitycode' to facilitate a later join
  - 'features.txt' reads into 'features'
  - 'X_train.text' reads into 'train_data' with column names applied from the 'features' dataframe
  - 'X_test.text' reads into 'test_data' with column names applied from the 'features' dataframe
  - 'activity_labels.txt' reads into 'activity_labels' with column names of 'activitycode' and 'activityname' to facilitate a later join

The code then loads the plyr, dplyr, tidyr, reshape2 and stringr packages.

The next block of code prepares tidy-data-friendly activity labels and feature names as follows:
  - The activity labels are all changed to lower case and the '_' characters are removed using gsub()
  - The features names go through a more involved, and possibly unnecessary process resulting in a 'newfeatures' vector:
    - changed to lower case and removal of all ',',' ','(' and ')' characters using gsub()
    - separating the resulting names into a maximum of 3 strings on the '-' character using separate()
    - joining the original feature row number to the three strings in a revised order (1,3,2), separated by '-' using unite()
      -(While not strictly required, I prefer the possibility of sorting the columns by feature name and having the mean and standard          -deviation for each variable next to each other. The row number is appended to eliminate any duplicate names that might cause            -problems in a later bind() call.  PLEASE NOTE:  the unite() call will print a warning, because not all of the feature names             -separated into 3 components, resulting in NA values. These are addressed later.
    - the next several lines remove, respectively, 'NA', duplicate 'body', terminal '--' from missing components and internal duplicate        '--'

The following block of code creates the unified data set from all of the individual elements, with tidy variables and activity names:
  - 'train_data' and 'test_data' are given the 'newfeatures' column names
  - 'train_activity' and 'test_activity' are appended with descriptive 'activity_labels' using join()
  - 'train_subject' and 'test_subject' are combined with the descriptive 'activity_labels' using bind_cols()
  - 'train_all' and 'test_all' are produced by combining '_subject' and '_data' using bind_cols()
  - 'alldata' containing the entire data set is produced by combining 'train_all' and 'test_all' using bind_rows(), and creating a new        vector named 'group' which identifies which original group the data belongs to - either 'testgroup' or 'traingroup'.

With the complete dataset in hand, it is time to begin subsetting and reshaping it.
  - The first step is to select columns for the tidydata set.  I specify the identifying columns (1,2,4) and subset the remainder            searching for a terminal '-std' or '-mean' using grep(). The '-' was explicitly retained in the earlier steps in order to distinguish     the original feature names containing 'mean()' from those containing 'mean', e.g. 'gravitymean' and 'meanfreq', as these have no         corresponding standard deviation measure.  The result is a 69-element vector, with three id columns ('group', 'testsubject',             'activityname') and 66 feature observation variables - 1 per column
  - 'sub_alldata' is then subsetted from 'alldata' using the 'column_select' produced above
  - 'sub_alldata' column names are cleaned by removing leading numbers and hyphens
  - 'sub_alldata' is reshaped to 'melt_alldata', a tall and narrow table with the three id columns from above and a single observation        per row using melt()
  -  'subjectmean' is prepared using dcast(), in which 'testsubject' and 'activityname' are retained as identifiers, and the mean is          calculated for all of the remaining 66 variables
  -  Column names for 'subjectmean' are revised by prepending 'avg' to the feature names to indicate the values are now averaged
  -  'tidydata.text' is prepared in the working directory by calling write.table() on 'subjectmean'

The penultimate tidy data set may be reproduced from the resulting text file using the following code:

read.table("./data/tidydata.txt", header = TRUE)



