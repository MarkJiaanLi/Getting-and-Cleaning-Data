##The parts corresponds to the assignment requirements

if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata") 
##Creates the working repository "getcleandata" and unzips the file for analysis

##Part 1
x_train <- read.table("./getcleandata/UCI HAR Dataset/train/X_train.txt") 
y_train <- read.table("./getcleandata/UCI HAR Dataset/train/y_train.txt") 
s_train <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt")
colnames(x_train) <- features[,2] ##Column 2 in features dataset contains the 
##all the feature selection
colnames(s_train) <- "Subject"
colnames(y_train) <- "Activity"
trainOnly <- cbind(s_train, y_train, x_train)

x_test <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt") 
y_test <- read.table("./getcleandata/UCI HAR Dataset/test/y_test.txt") 
s_test <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt")
colnames(x_test) <- features[,2]
colnames(s_test) <- "Subject"
colnames(y_test) <- "Activity"
testOnly <- cbind(s_test, y_test, x_test)

##Make sure the column name for s_test and s_train, as well as y_test and 
##y_train are the same so that the rows can bind. This also answers part 4
TidyData <- rbind(testOnly, trainOnly)
dim(TidyData) ##To check for dimension after merging the two datasets. The number
##of column is the same which is 563, and the row number is doubled.

##Part 2
install.packages(dplyr)
library(dplyr)
MandSD <- select(TidyData, Subject, Activity, contains("mean"), contains("std"))
##The contains() function in select() will pick up a literal string, in this case
##mean and std

##Part 3
MandSD[, 2] <- ActLabel[MandSD[,2], 2]

##Part 5
FinalData <- aggregate(. ~Subject + Activity, MandSD, mean)
FinalData <- FinalData[order(FinalData$Subject, FinalData$Activity),]
write.table(FinalData, "FinaltidySet.txt", row.names = FALSE)