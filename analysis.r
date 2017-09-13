# First we can use this line to set the wd
#setwd("DataAnalysis/UCI HAR Dataset")

# First part of the code is about loading each file
# If the data files are the only ones in the folder, it would be worth writing a loop instead of this by hand all-files import
testLabels = read.table("./test/y_test.txt")
testSet = read.table("./test/X_test.txt")
testSubject = read.table("./test/subject_test.txt")
ClassLabels = read.table("./activity_labels.txt")
trainLabels = read.table("./train/y_train.txt")
trainSet = read.table("./train/X_train.txt")
trainSubject = read.table("./train/subject_train.txt")
## Train acc
trainbodyAccx = read.table("./train/Inertial Signals/body_acc_x_train.txt")
trainbodyAccy = read.table("./train/Inertial Signals/body_acc_y_train.txt")
trainbodyAccz = read.table("./train/Inertial Signals/body_acc_z_train.txt")
trainbodyGyrox = read.table("./train/Inertial Signals/body_gyro_x_train.txt")
trainbodyGyroy = read.table("./train/Inertial Signals/body_gyro_y_train.txt")
trainbodyGyroz = read.table("./train/Inertial Signals/body_gyro_z_train.txt")
trainTotalAccx = read.table("./train/Inertial Signals/total_acc_x_train.txt")
trainTotalAccy = read.table("./train/Inertial Signals/total_acc_y_train.txt")
trainTotalAccz = read.table("./train/Inertial Signals/total_acc_z_train.txt")

##Test acc
testbodyAccx = read.table("./test/Inertial Signals/body_acc_x_test.txt")
testbodyAccy = read.table("./test/Inertial Signals/body_acc_y_test.txt")
testbodyAccz = read.table("./test/Inertial Signals/body_acc_z_test.txt")
testbodyGyrox = read.table("./test/Inertial Signals/body_gyro_x_test.txt")
testbodyGyroy = read.table("./test/Inertial Signals/body_gyro_y_test.txt")
testbodyGyroz = read.table("./test/Inertial Signals/body_gyro_z_test.txt")
testTotalAccx = read.table("./test/Inertial Signals/total_acc_x_test.txt")
testTotalAccy = read.table("./test/Inertial Signals/total_acc_y_test.txt")
testTotalAccz = read.table("./test/Inertial Signals/total_acc_z_test.txt")

## Features description
AllFeatures = read.table("features.txt")

## We add some labels 
names(ClassLabels)=c("LabelId", "Label")
names(testLabels)=c("LabelId")
names(testSubject) = c("SubjectId")

# Test dataset first
# We compute the means and std dev of each movement type, and we cbind them at the same time
testAllMeasures = cbind(BodyAccX_Mean = rowMeans(testbodyAccx), BodyAccX_SD =apply(X = testbodyAccx,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, BodyAccY_Mean = rowMeans(testbodyAccy), BodyAccY_SD = apply(X = testbodyAccy,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, BodyAccZ_Mean = rowMeans(testbodyAccz), BodyAccZ_SD=apply(X = testbodyAccz,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, bodyGyrox_Mean = rowMeans(testbodyGyrox), bodyGyrox_SD=apply(X = testbodyGyrox,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, bodyGyroy_Mean = rowMeans(testbodyGyroy), bodyGyroy_SD=apply(X = testbodyGyroy,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, bodyGyroz_Mean = rowMeans(testbodyGyroz), bodyGyroz_SD=apply(X = testbodyGyroz,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, TotalAccx_Mean = rowMeans(testTotalAccx), TotalAccx_SD=apply(X = testTotalAccx,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, TotalAccy_Mean = rowMeans(testTotalAccy), TotalAccy_SD=apply(X = testTotalAccy,MARGIN = 1,FUN =sd))
testAllMeasures = cbind(testAllMeasures, TotalAccz_Mean = rowMeans(testTotalAccz), TotalAccz_SD=apply(X = testTotalAccz,MARGIN = 1,FUN =sd))

# Labels, subjects and related measures are bound (they are in the same order)
testLabels = cbind(testLabels, testSubject, testAllMeasures)

# Labels are merged into the previous table by LabelId
testLabelled = merge(ClassLabels, testLabels, by = "LabelId")

# Train dataset goes next
names(ClassLabels)=c("LabelId", "Label")
names(trainLabels)=c("LabelId")
names(trainSubject) = c("SubjectId")
# We compute the means and std dev of each movement type, and we cbind them at the same time
trainAllMeasures = cbind(BodyAccX_Mean = rowMeans(trainbodyAccx), BodyAccX_SD =apply(X = trainbodyAccx,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, BodyAccY_Mean = rowMeans(trainbodyAccy), BodyAccY_SD = apply(X = trainbodyAccy,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, BodyAccZ_Mean = rowMeans(trainbodyAccz), BodyAccZ_SD=apply(X = trainbodyAccz,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, bodyGyrox_Mean = rowMeans(trainbodyGyrox), bodyGyrox_SD=apply(X = trainbodyGyrox,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, bodyGyroy_Mean = rowMeans(trainbodyGyroy), bodyGyroy_SD=apply(X = trainbodyGyroy,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, bodyGyroz_Mean = rowMeans(trainbodyGyroz), bodyGyroz_SD=apply(X = trainbodyGyroz,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, TotalAccx_Mean = rowMeans(trainTotalAccx), TotalAccx_SD=apply(X = trainTotalAccx,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, TotalAccy_Mean = rowMeans(trainTotalAccy), TotalAccy_SD=apply(X = trainTotalAccy,MARGIN = 1,FUN =sd))
trainAllMeasures = cbind(trainAllMeasures, TotalAccz_Mean = rowMeans(trainTotalAccz), TotalAccz_SD=apply(X = trainTotalAccz,MARGIN = 1,FUN =sd))
# Labels, subjects and related measures are bound (they are in the same order)
trainLabels = cbind(trainLabels, trainSubject, trainAllMeasures)
# Labels are merged into the previous table by LabelId
trainLabelled = merge(ClassLabels, trainLabels, by = "LabelId")

#Train and test datasets are rbound together in one big set
DataSet = rbind(trainLabelled, testLabelled)

# The dataset is aggregated by label and subejct, so each subject has one row for each activity
TidySummaryDataSet = aggregate(DataSet, by = list(DataSet$Label, DataSet$SubjectId), FUN = mean)
# Rename the columns created by the aggregate function
colnames(TidySummaryDataSet)[1:2] <- c("Activity", "Subject")
# Remove the columns that give a redundant information
TidySummaryDataSet <- TidySummaryDataSet[,!(colnames(TidySummaryDataSet) %in% c("LabelId", "Label", "SubjectId"))]

#Final dataset is saved
write.table(x = TidySummaryDataSet, file = "Tidy_dataset.txt", row.names = F)