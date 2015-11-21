## This first block of code downloads and unzips the required data file - according to the Project
## instructions, this step is not required, as the data files already reside within the working directory
#
#    ## Create a variable to contain the file URL
#    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#    ## Download the zipped data file to the data sub-directory
#    download.file(fileUrl, destfile = "./accel.zip", method = "curl")
#    ## Unzip the data files into the working directory, preserving the sub-directory structure
#    unzip("./accel.zip", exdir = ".")

## This block of code reads in the required data files from the working directory
## IMPORTANT NOTE: This assumes that the zip file's directory structure was maintained, and that the files are nested
## within the working directory

## Read in the subject codes for both data sets and apply a column name "testsubject"
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names=c("testsubject"))
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names=c("testsubject"))
## Read in the activity codes for both data sets and label the single column "activitycode"
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names=c("activitycode"))
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names=c("activitycode"))
## Read in the features data set for use as column names in both data sets
features <- read.table("./UCI HAR Dataset/features.txt")
## Read in the data observations for both data sets
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names=features[,2])
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names=features[,2])
## Read in the activity names for the datasets and assign column names to assist later joining
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("activitycode", "activityname"))


dateDownloaded <- date()


## This block of code grabs the required files within the specified zip file by creating a 
## temporary connection. This is my preferred approach, although it doesn't leave a copy of the original zip file
## in the working directory.  As above, according to the Project instructions, this step is not required, as the 
## data files already reside within the working directory
#
#
#    ## Create a variable to contain the file URL
#    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#    ## Define a temporary connection for the download
#    temp <- tempfile()
#    ##Download the file into the temporary connection
#    download.file(fileUrl,temp, method = "curl")
#    ## Unzip and read in the subject codes for both data sets and apply a column name "testsubject"
#    train_subject <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"), col.names=c("testsubject"))
#    test_subject <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"), col.names=c("testsubject"))
#    ## Unzip and read in the activity codes for both data sets and label the single column "activitycode"
#    train_activity <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"), col.names=c("activitycode"))
#    test_activity <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"), col.names=c("activitycode"))
#    ## Unzip and read in the data observations for both data sets
#    train_data <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
#    test_data <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
#    ## Unzip and ead in the activity names for the datasets and assign column names to assist later joining
#    activity_labels <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"), col.names=c("activitycode", "activityname"))
#    ## Unzip and read in the features data set for use as column names in both data sets
#    feature_variables <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
#    ## Close the temporary connection
#    unlink(temp)
#    dateDownloaded <- date()


## Load the required libraries for the data cleaning, shaping and summarizing functions
library(plyr)
library(dplyr)
library(tidyr)
library(reshape2)
library(stringr)


## The following block cleans and assigns column labels and combines the test subject, activity and observation data
## Create friendly activity names by changing all to lower case and removing underscores
activity_labels[,2] <- gsub("_","",tolower(activity_labels[,2]))

## Create unique and clean feature variable names by converting to lower case, removing commas and spaces
features$V2 <- gsub(",| |\\(|\\)","", tolower(features$V2))
## Separate the variable name into 3 components for rearranging
features <- separate(features,V2, into=c("first","second","third"), sep = "-", remove = FALSE)
## Merge the three components in a revised order, and combine with the record number to ensure unique variables
features = unite(features, "newfeatures", c(1,3,5,4), sep = "-", remove = FALSE)
## Remove "NAs" resulting from the separate() function
features$newfeatures = gsub("NA", "", features$newfeatures)
## Remove duplicate "body" in variable names
features$newfeatures = gsub("bodybody", "body", features$newfeatures)
## Remove terminal hypens for variables that had missing components in the unite() call
features$newfeatures = gsub("--$", "", features$newfeatures)
## Replace remaining "--" with "-" internal to the string
features$newfeatures = gsub("--", "-", features$newfeatures)

## Apply the new feature variables as column names to both data sets
colnames(train_data) <- features$newfeatures
colnames(test_data) <- features$newfeatures
## Append the activity names to the activity codes in each data set
test_activity = join(test_activity, activity_labels)
train_activity = join(train_activity, activity_labels)
## Combine the test subject data with the activity name data for both sets
test_subject <- bind_cols(test_subject, test_activity)
train_subject <- bind_cols(train_subject, train_activity)
## Combine Test subject df with observations for both datasets
test_all <- bind_cols(test_subject, test_data)
train_all <- bind_cols(train_subject, train_data)
## Combine the Test and Train datasets together, including a new column denoting which group the row comes from
alldata <- bind_rows("testgroup"=test_all, "traingroup"=train_all, .id = "group")


## The following block subsets the original data, melts and summarizes the data and writes the reulting tidy data set

## Determine which columns to select be searching column names for either "mean" or "std"
column_select <- c(1,2,4,grep("-mean$|-std$",names(alldata)))
## Subset the merged data set on columns containing identifiers and mean or std variables
sub_alldata <- alldata[,column_select]
## Remove the leading numbers from the variable names that were inserted to create unique entries
colnames(sub_alldata) <- gsub("^[0-9]*\\-","", colnames(sub_alldata))
## Remove remaining hyphens in the variable names
colnames(sub_alldata) <- gsub("-","", colnames(sub_alldata))
## Reshape the data so there is a single observation per row using melt
melt_alldata <- melt(sub_alldata, id=c("group","testsubject","activityname"))
## Create a new data set with the average for each variable for each activity by subject
subjectmean <- dcast(melt_alldata, testsubject + activityname ~ variable, mean)
colnames(subjectmean) <- paste0(c(rep("",2),rep("avg",ncol(subjectmean)-2)), colnames(subjectmean))
write.table(subjectmean, "./data/tidydata.txt", row.names = FALSE)
