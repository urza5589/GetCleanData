library(readr)
library(data.table)
library(dplyr)
#Import both test and train observations
test <- read_table("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/test/X_test.txt","", col_names = FALSE)
train <- read_table("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/train/X_train.txt","", col_names = FALSE)

#import both test and train subject info
STest <- read_table("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/test/subject_test.txt","", col_names = FALSE)
STrain <- read_table("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/train/subject_train.txt","", col_names = FALSE)

#import both test and train activity info
ATest <- read_table("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/test/Y_test.txt","", col_names = FALSE)
ATrain <- read_table("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/train/Y_train.txt","", col_names = FALSE)

#import Labels
Labels <- read_delim("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/features.txt"," ", escape_double = FALSE, col_names = FALSE,trim_ws = TRUE)
ALabels <- read_table("C:/Users/howasam/Desktop/Coursera/Data Cleaning/R Project/UCI HAR Dataset/activity_labels.txt","", col_names = FALSE)

#union test and train into one data set for both data and activites
DataSet<- rbind(test,train)
Activtes <- rbind(ATest,ATrain)
Subjects <- rbind(STest,STrain)


#apply labels a colnams
colnames(DataSet)<-Labels$X2

#Find all columns performing mean() operations
meanCol <- c(grep("mean()",names(DataSet),value =TRUE,fixed = TRUE) ,grep("Mean()",names(DataSet),value =TRUE,fixed = TRUE))
#Findl all columns performing std()operations
stdCol <- c(grep("std()",names(DataSet),value =TRUE,fixed = TRUE) ,grep("Std()",names(DataSet),value =TRUE,fixed = TRUE))

#merge column names
allCol<-c(meanCol,stdCol)

#Ensure no Duplicate ColNames
allCol<-unique(allCol)

#Retreive only desired columns
SlimDataSet<-DataSet[,allCol]


#Join Activites with Data and apply activity labels
colnames(Subjects) = "Subjects"
fullData <- cbind(Subjects,Activtes,SlimDataSet)
labeldData <- merge(ALabels,fullData,by = ("X1"))

# clean column names
allCol = gsub("[()-]","",allCol)

# Give descriptive names to variables
colnames(labeldData)<-c("activitynumber","activitylabel","subject",allCol)

#Calculate final AVg  data
myAverages = labeldData %>% group_by(activitylabel,subject) %>% summarize_all(funs(mean))
