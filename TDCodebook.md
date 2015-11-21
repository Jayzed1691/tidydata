title: "Tidy Data Codebook"
author: "Jonathan Zax"
date: "November 20, 2015"


'data.frame':	180 obs. of  68 variables:
 Identifiers are contained in the first two columns labeled "testsubject" and "activityname".
 There were 30 test subjects in total in the combines test and train data sets, indicated by the integers 1 through 30.
 Each test subject was observed undertaking 6 separate activities in the dataset, resulting in 180 summary observations.
    -1  testsubject            : int  1:30
    -2  activityname           : chr  "laying" "sitting" "standing" "walking" "walkingdownstairs" "walkingupstairs"
 
 There follow 66 variables with names constructed of a series of elements as follows:
 [avg] - all variables are averages of the specified observations from the original datasets
 [t,f] - t is used to denote time domain signals and f to denote frequency domain signals
 [body,gravity] - acceleration measures have been separated into body or gravity signals
 [acc, gyro] - original signals obtained from either the accelerometer or the gyroscope
 [jerk, mag] - body linear acceleration and angular velocity were derived in time to obtain jerk signals, while the magnitude of these three-dimensional signals were calculated using the Euclidean norm 
 [x,y,z] - denote the three axial signals in the X, Y and Z directions
 [mean, std] - finally, each variable name ends with either "mean" or "std" denoting whether the original measure was a mean or standard deviation of the related observations

The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.
The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

 The variables are all vectors of type num.
 The variable names in this tidy data set are:
    -3  avgtbodyaccxmean
    -4  avgtbodyaccymean
    -5  avgtbodyacczmean
    -6  avgtbodyaccxstd
    -7  avgtbodyaccystd
    -8  avgtbodyacczstd
    -9  avgtgravityaccxmean
    -10 avgtgravityaccymean
    -11 avgtgravityacczmean
    -12 avgtgravityaccxstd
    -13 avgtgravityaccystd
    -14 avgtgravityacczstd
    -15 avgtbodyaccjerkxmean
    -16 avgtbodyaccjerkymean
    -17 avgtbodyaccjerkzmean
    -18 avgtbodyaccjerkxstd
    -19 avgtbodyaccjerkystd
    -20 avgtbodyaccjerkzstd
    -21 avgtbodygyroxmean
    -22 avgtbodygyroymean
    -23 avgtbodygyrozmean
    -24 avgtbodygyroxstd
    -25 avgtbodygyroystd
    -26 avgtbodygyrozstd
    -27 avgtbodygyrojerkxmean
    -28 avgtbodygyrojerkymean
    -29 avgtbodygyrojerkzmean
    -30 avgtbodygyrojerkxstd
    -31 avgtbodygyrojerkystd
    -32 avgtbodygyrojerkzstd
    -33 avgtbodyaccmagmean
    -34 avgtbodyaccmagstd
    -35 avgtgravityaccmagmean
    -36 avgtgravityaccmagstd
    -37 avgtbodyaccjerkmagmean
    -38 avgtbodyaccjerkmagstd
    -39 avgtbodygyromagmean
    -40 avgtbodygyromagstd
    -41 avgtbodygyrojerkmagmean
    -42 avgtbodygyrojerkmagstd
    -43 avgfbodyaccxmean
    -44 avgfbodyaccymean
    -45 avgfbodyacczmean
    -46 avgfbodyaccxstd
    -47 avgfbodyaccystd
    -48 avgfbodyacczstd
    -49 avgfbodyaccjerkxmean
    -50 avgfbodyaccjerkymean
    -51 avgfbodyaccjerkzmean
    -52 avgfbodyaccjerkxstd
    -53 avgfbodyaccjerkystd
    -54 avgfbodyaccjerkzstd
    -55 avgfbodygyroxmean
    -56 avgfbodygyroymean
    -57 avgfbodygyrozmean
    -58 avgfbodygyroxstd
    -59 avgfbodygyroystd
    -60 avgfbodygyrozstd
    -61 avgfbodyaccmagmean
    -62 avgfbodyaccmagstd
    -63 avgfbodyaccjerkmagmean
    -64 avgfbodyaccjerkmagstd
    -65 avgfbodygyromagmean
    -66 avgfbodygyromagstd
    -67 avgfbodygyrojerkmagmean
    -68 avgfbodygyrojerkmagstd
