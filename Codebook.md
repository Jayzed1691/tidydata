title: "Tidy Data Codebook"
author: "Jonathan Zax"
date: "November 20, 2015"

The raw data for this assignment is contained within six files from the Human Activity Recognition Using Smartphones Dataset, Version 1.0, available for download from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The files required are:
 - 'features.txt': List of all features.
 - 'activity_labels.txt': Links the class labels with their activity name.
 - 'train/X_train.txt': Training set.
 - 'train/y_train.txt': Training labels.
 - 'train/subject_train.txt': Identifies the subject who performed the activity.
 - 'test/X_test.txt': Test set.
 - 'test/y_test.txt': Test labels.
 - 'test/subject_test.txt': Identifies the subject who performed the activity.

For the sake of completeness, the original codebook for the raw data sets is presented below, followed by a discussion of the selection and transformation conducted to result in the wide tidy dataset 'tidydata.txt'.

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz."

"Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)."

"Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals)."

"A. These signals were used to estimate variables of the feature vector for each pattern. '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions:
  - tBodyAcc-XYZ
  - tGravityAcc-XYZ
  - tBodyAccJerk-XYZ
  - tBodyGyro-XYZ
  - tBodyGyroJerk-XYZ
  - tBodyAccMag
  - tGravityAccMag
  - tBodyAccJerkMag
  - tBodyGyroMag
  - tBodyGyroJerkMag
  - fBodyAcc-XYZ
  - fBodyAccJerk-XYZ
  - fBodyGyro-XYZ
  - fBodyAccMag
  - fBodyAccJerkMag
  - fBodyGyroMag
  - fBodyGyroJerkMag

"B. The set of variables that were estimated from these signals are:
  - mean(): Mean value
  - std(): Standard deviation
  - mad(): Median absolute deviation 
  - max(): Largest value in array
  - min(): Smallest value in array
  - sma(): Signal magnitude area
  - energy(): Energy measure. Sum of the squares divided by the number of values. 
  - iqr(): Interquartile range 
  - entropy(): Signal entropy
  - arCoeff(): Autorregresion coefficients with Burg order equal to 4
  - correlation(): correlation coefficient between two signals
  - maxInds(): index of the frequency component with largest magnitude
  - meanFreq(): Weighted average of the frequency components to obtain a mean frequency
  - skewness(): skewness of the frequency domain signal 
  - kurtosis(): kurtosis of the frequency domain signal 
  - bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
  - angle(): Angle between to vectors.

"C. Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
  - gravityMean
  - tBodyAccMean
  - tBodyAccJerkMean
  - tBodyGyroMean
  - tBodyGyroJerkMean

"Notes:
  - Features are normalized and bounded within [-1,1]
  - Each feature vector is a row on the text file

The tidy data set that has been written into tidydata.txt is a data.frame with	180 observations of 68 variables.

The original 'subject_test' and 'subject_train' identifier data was retained without transformation. There were 30 test subjects in total in the combined test and train data sets, indicated by the integers 1 through 30. These appear in the first column of the tidy data set as:

 - 1  testsubject            : int  1:30 signifying the 30 test subjects
 
The second column, labeled "activityname" is a transformation of the integer items from y_train and y_test into human-friendly activity labels as provided in 'activity_labels.txt', after removing non-alphabetic characters and converting to lower case.
 
 - 2  activityname           : chr  "laying" "sitting" "standing" "walking" "walkingdownstairs" "walkingupstairs"
 
Each test subject was observed undertaking each of the 6 separate activities in the dataset, resulting in 180 summary observations.
 
The patterns described in part A above comprise a set of 33 features.  The tidy data set has subsetted the mean() and std() estimates for each of these features, resulting in a total of 66 variables.  

Additionally, the mean and standard deviation measures have been averaged for the tidy data set by testsubject and activity name.

The names have been revised from the original 'features.txt' to remove non-alphabetic characters, and reorder the internal components slightly for more user-friendly sorting. The new names are constructed of a series of elements as follows:

 - [avg] - all variables are averages of the specified observations from the original datasets
 - [t,f] - t is used to denote time domain signals and f to denote frequency domain signals
 - [body,gravity] - acceleration measures have been separated into body or gravity signals
 - [acc, gyro] - original signals obtained from either the accelerometer or the gyroscope
 - [jerk, mag] - body linear acceleration and angular velocity were derived in time to obtain jerk signals, while the magnitude of these    three-dimensional signals were calculated using the Euclidean norm 
 - [x,y,z] - denote the three axial signals in the X, Y and Z directions
 - [mean, std] - finally, each variable name ends with either "mean" or "std" denoting whether the original measure was a mean or          standard deviation of the related observations

The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.
The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

 The variables are all vectors of type num.
 The variable names in this tidy data set are:
 
  - 3  avgtbodyaccxmean
  - 4  avgtbodyaccymean
  - 5  avgtbodyacczmean
  - 6  avgtbodyaccxstd
  - 7  avgtbodyaccystd
  - 8  avgtbodyacczstd
  - 9  avgtgravityaccxmean
  - 10 avgtgravityaccymean
  - 11 avgtgravityacczmean
  - 12 avgtgravityaccxstd
  - 13 avgtgravityaccystd
  - 14 avgtgravityacczstd
  - 15 avgtbodyaccjerkxmean
  - 16 avgtbodyaccjerkymean
  - 17 avgtbodyaccjerkzmean
  - 18 avgtbodyaccjerkxstd
  - 19 avgtbodyaccjerkystd
  - 20 avgtbodyaccjerkzstd
  - 21 avgtbodygyroxmean
  - 22 avgtbodygyroymean
  - 23 avgtbodygyrozmean
  - 24 avgtbodygyroxstd
  - 25 avgtbodygyroystd
  - 26 avgtbodygyrozstd
  - 27 avgtbodygyrojerkxmean
  - 28 avgtbodygyrojerkymean
  - 29 avgtbodygyrojerkzmean
  - 30 avgtbodygyrojerkxstd
  - 31 avgtbodygyrojerkystd
  - 32 avgtbodygyrojerkzstd
  - 33 avgtbodyaccmagmean
  - 34 avgtbodyaccmagstd
  - 35 avgtgravityaccmagmean
  - 36 avgtgravityaccmagstd
  - 37 avgtbodyaccjerkmagmean
  - 38 avgtbodyaccjerkmagstd
  - 39 avgtbodygyromagmean
  - 40 avgtbodygyromagstd
  - 41 avgtbodygyrojerkmagmean
  - 42 avgtbodygyrojerkmagstd
  - 43 avgfbodyaccxmean
  - 44 avgfbodyaccymean
  - 45 avgfbodyacczmean
  - 46 avgfbodyaccxstd
  - 47 avgfbodyaccystd
  - 48 avgfbodyacczstd
  - 49 avgfbodyaccjerkxmean
  - 50 avgfbodyaccjerkymean
  - 51 avgfbodyaccjerkzmean
  - 52 avgfbodyaccjerkxstd
  - 53 avgfbodyaccjerkystd
  - 54 avgfbodyaccjerkzstd
  - 55 avgfbodygyroxmean
  - 56 avgfbodygyroymean
  - 57 avgfbodygyrozmean
  - 58 avgfbodygyroxstd
  - 59 avgfbodygyroystd
  - 60 avgfbodygyrozstd
  - 61 avgfbodyaccmagmean
  - 62 avgfbodyaccmagstd
  - 63 avgfbodyaccjerkmagmean
  - 64 avgfbodyaccjerkmagstd
  - 65 avgfbodygyromagmean
  - 66 avgfbodygyromagstd
  - 67 avgfbodygyrojerkmagmean
  - 68 avgfbodygyrojerkmagstd
