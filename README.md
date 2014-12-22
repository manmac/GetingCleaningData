#ASSIGNMENT DETAILS:

GOALS: The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#IMPLEMENTATION:

The script run_analysis.R does the following:

>    a. Merges the training and the test sets to create one data set.

>    b. Extracts only the measurements on the mean and standard deviation for each measurement.

>    c. Uses descriptive activity names to name the activities in the data set

>    d. Appropriately labels the data set with descriptive activity names.

>    e. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#LIBRARY/DEPENDENCIES:

The script run_analysis.R is dependent on rshape2 library. If not already available, please download it from CRAN using the following: 
>install.packages("rshape2") 

To import: 
>library(rshape2)

#TO EXECUTE THE SCRIPT:

Simply copy the script onto the working directory of R. Once copied run by sourcing the script:

>    source('~/run_analysis.R')

This would automatically download all the files and import environment and perform all tasks as described in section "IMPLEMENTATION" above. The following file is written onto the directory "UCI HAR Dataset" directory:

tidyData.txt is a final csv containing 180 observations of 68 variables containing the average of each variable for each activity and each subject. 
