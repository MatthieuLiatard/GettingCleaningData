# First we can use this line to set the wd
#setwd("DataAnalysis/UCI HAR Dataset")

# First part of the code is about loading each file
# If the data files are the only ones in the folder, it would be worth writing a loop instead of this by hand all-files import
## Features description that will serve as labels for each measures
AllFeatures = read.table("features.txt", col.names = c("id", "Measure"))
## Labels for each activity
ClassLabels = read.table("./activity_labels.txt", col.names = c("ActivityId", "Activity"))

testLabels = read.table("./test/y_test.txt", col.names = "ActivityId")
testSet = read.table("./test/X_test.txt", col.names = AllFeatures$Measure)
testSubject = read.table("./test/subject_test.txt", col.names = "SubjectId")

trainLabels = read.table("./train/y_train.txt", col.names = "ActivityId")
trainSet = read.table("./train/X_train.txt", col.names = AllFeatures$Measure)
trainSubject = read.table("./train/subject_train.txt", col.names = "SubjectId")


## Filter by mean and std
FilterVector = grepl(c("mean","std"), AllFeatures$Measure)

# Dataset is filtered on some specific columns, it becomes much leaner
testSet = testSet[FilterVector]
trainSet = trainSet[FilterVector]

## Add subjects in both datasets
# Labels, subjects and related measures are bound (they are in the same order)
testSet = cbind(testLabels, testSubject, testSet)
trainSet = cbind(trainLabels, trainSubject, trainSet)

#Train and test datasets are rbound together in one big set
DataSet = rbind(testSet, trainSet)

# Dataset is labelled properly
DataSet = merge(ClassLabels, DataSet, by = "ActivityId")

# The dataset is aggregated by label and subejct, so each subject has one row for each activity
TidySummaryDataSet = aggregate(DataSet, by = list(DataSet$Activity, DataSet$SubjectId), FUN = mean)
# Rename the columns created by the aggregate function
colnames(TidySummaryDataSet)[1:2] <- c("Activity Label", "Subject")
# Remove the columns that give a redundant information
TidySummaryDataSet <- TidySummaryDataSet[,!(colnames(TidySummaryDataSet) %in% c("Activity", "ActivityId", "SubjectId"))]

# Rename the columns
names(TidySummaryDataSet) <- gsub("^t", "Time", names(TidySummaryDataSet))
names(TidySummaryDataSet) <- gsub("^f", "Frequency", names(TidySummaryDataSet))
names(TidySummaryDataSet) <- gsub("Acc", "Acceleration", names(TidySummaryDataSet))
names(TidySummaryDataSet) <- gsub("Mag", "Magnitude", names(TidySummaryDataSet))


#Final dataset is saved
write.table(x = TidySummaryDataSet, file = "Tidy_dataset.txt", row.names = F)