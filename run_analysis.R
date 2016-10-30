# data.table is used at the end of the file
library(data.table)

# define names of files and directories
dirname <- "data"
filename <- "UCI HAR Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# check if directories and files exist already
# download and unzip data file
if (!dir.exists(dirname)) dir.create(dirname)
if (!file.exists(file.path(dirname, filename))) download.file(fileURL, destfile=file.path(dirname, filename), method="curl")
if (!dir.exists(file.path(dirname, "UCI HAR Dataset"))) unzip(file.path(dirname, filename), exdir=dirname)

# read activity labels and feature descriptions
# specify column names
activityLabels <- read.table("data/UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"))
features <- read.table("data/UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"))

# read test data
subjectTest <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
xTest <- read.table("data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("data/UCI HAR Dataset/test/Y_test.txt")

# read training data
subjectTrain <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
xTrain <- read.table("data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("data/UCI HAR Dataset/train/Y_train.txt")

# remove underscore from activity labels
activityLabels$activityLabel <- gsub("_", "", as.character(activityLabels$activityLabel))

# specify labels that are needed to calculate the result values
featuresExtracted <- grep(".*mean.*|.*std.*", features$featureLabel)

# combine test and training data: subjects
subjectData <- rbind(subjectTest, subjectTrain)
names(subjectData) <- "subjectId"

# combine test and training data: x-Data
xData <- rbind(xTest, xTrain)
xData <- xData[, featuresExtracted]

# remove parentheses
names(xData) <- gsub("\\(|\\)", "", features$featureLabel[featuresExtracted])

# combine test and training data: y-Data
yData <- rbind(yTest, yTrain)
names(yData) <- "activityId"

# merge data frames yData and activityLabels and write tidied data into text file
activityData <- merge(yData, activityLabels, by="activityId")$activityLabel
allData <- cbind(subjectData, xData, activityData)
write.table(allData, "tidy_data.txt")

# use package data.table to apply SD and mean functions to data and write result data into text file
allDataTable <- data.table(allData)
resultData <- allDataTable[, lapply(.SD, mean), by=c("subjectId", "activityData")]
write.table(resultData, "result_tidy_data.txt")
