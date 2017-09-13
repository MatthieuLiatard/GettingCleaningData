# Description of analysis files in R

## Analysis files list in the directory
* 'analysis.r': code file of the analysis, it contains all the instructions to access the data files, extract and tidy up the dataset. See below for explanation of the content of this file.
* 'Codebook.md': This markup file goes through the list of measures output from the analysis file into the tidy dataset.
* 'ReadMe.md': The current file describes the files in the directory and the analysis file.
* 'Tidy_dataset.txt': This is the output dataset with all the variables decribed in the codebook (60ko).

## Data files list
- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.                    

## Analysis file technical description
This is a step-by-step decription of the inner workings of the analysis file.

1. The first step is to import the data from the files. If the data files are the only ones in the folder, it would be worth writing a loop instead of this by hand all-files import,
2. Then each row measures of each acceleration file is summarized by it mean and standard deviation,
3. The new summarized measures are aggregated in one dataset where each pair of columns is specific to a type of acceleration,
4. The previous operation is done separately on the test and training dataset
5. Each of these dataset is aggregated with the corresponding subject id number, activity id number, and then the activity id number is used to bind the full name of the activity type,
6. The test and training dataset are added up
7. This new large dataset is aggregated by label and subject, so each subject has one row for each activity
8. Some columns are renamed and others removed so we end up with a clean dataset
9. This significantly shorter dataset is saved in the 'Tidy_dataset.txt' file