
# Read in Activity and Feature Definitions as strings
# ("[[1]]" at end makes sure output is character vector rather than data frame.)

activitydefs<-read.table("UCI HAR Dataset/activity_labels.txt", colClasses =c("NULL","character"))[[1]]
featuredefs<-read.table("UCI HAR Dataset/features.txt", colClasses =c("NULL","character"))[[1]]

# Process Test Data:
# Read measurement time series, column names = feature definitions
testDataTimeSeries<-read.table("UCI HAR Dataset/test/X_test.txt",col.names = featuredefs)
# Read subject time series, single column of integers 
testSubjectTimeSeries<-read.table("UCI HAR Dataset/test/subject_test.txt",colClasses = "integer")
# Read activity code time series, single column of integers
testActivityCodeTimeSeries<-read.table("UCI HAR Dataset/test/y_test.txt",colClasses = "integer")[[1]]
# OBJECTIVE 3: Translate activity codes to activities
testActivityTimeSeries<-activitydefs[testActivityCodeTimeSeries]

# Integrate all test data
testTimeSeries<-cbind(Subject=testSubjectTimeSeries[[1]],Activity=testActivityTimeSeries,testDataTimeSeries)

# For Training data:
# Read measurement time series, column names = feature definitions
trainDataTimeSeries<-read.table("UCI HAR Dataset/train/X_train.txt",col.names = featuredefs)
# Read subject time series, single column of integers 
trainSubjectTimeSeries<-read.table("UCI HAR Dataset/train/subject_train.txt",colClasses = "integer")
# Read activity code time series, single column of integers
trainActivityCodeTimeSeries<-read.table("UCI HAR Dataset/train/y_train.txt",colClasses = "integer")[[1]]
# OBJECTIVE 3: Translate activity codes to activities
trainActivityTimeSeries<-activitydefs[trainActivityCodeTimeSeries]

# Integrate all training data
trainTimeSeries<-cbind(Subject=trainSubjectTimeSeries[[1]],Activity=trainActivityTimeSeries,trainDataTimeSeries)

# OBJECTIVE 1: Integrate test & training data
TimeSeries<-rbind(testTimeSeries,trainTimeSeries)

# OBJECTIVE 2: This command filters columns 1, 2, (subject and activity respectively) and all columns containing 
TimeSeriesMeanStd<-TimeSeries[,c(1,2,grep("\\.mean\\.|\\.std\\.",names(TimeSeries)))]

# OBJECTIVE 5: Averages all data past column 2 (i.e. all sensor data) by both Subject and Activity using aggregate command
MeanStdSummary<-aggregate(TimeSeriesMeanStd[, -(1:2)],by=list(Subject=TimeSeriesMeanStd$Subject,Activity=TimeSeriesMeanStd$Activity),FUN = mean)

