# gettingandclearning

Final project for "Getting and Cleaning" course. This repository contains
script to tidy an existing data set as per the final project requirement.

## Structure

* README.md - describes the files in the repository
* run_analysis.R - the script that tidies the original data set
* CodeBook.md - describes the variables in the tidy data set

## Original Data

The original data set represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
The data file is retrieved from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## What the script does

The run_analysis.R script makes the following assumptions.

1. The original data set has been extracted in a "UCI HAR Dataset" folder.
2. The 'dplyr' and 'tidyr' R libraries have been installed.

The script performs the following high level tasks.

1. Load the data, label and subject files from both test and train folders and merge them.
2. Gather the column indexes into a 'column' field.
3. Load and filter the features to only keep the ones that contain "mean()" and "std()", and clean up the feature names to be used as variable names.
4. Merge the feature list with the main data file using column index.
5. Load the activity labels and merge them with the main data set.
6. Summarized the mean of all the variables by subject and activity, and save the data set into a "summarized.txt" file.
