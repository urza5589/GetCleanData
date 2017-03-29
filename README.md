# Getting and Cleaning data Coursera project

Data for project iwth description avialbale at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Actual data download is:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

-------------------------------------------------
# CourseProjectR:

This script performs all neccesary steps to transform the data set provided.

1) It reads in all data for test/training activites/labels/subjects
2) Unions test and training data together for each type of data
3) apply column labels to activity data
4) use column names to pull out Mean() and Std(). Only pull fields with () to ensure they are mean or STD calculatins rather then calculations on prvious means or STDs. Account for first letter capatilzation
5) Join activites and data together and apply activity labels
6) Join subjects and rename all columns to sensible nams
7) Generates a tidy data text file 
8) Pulls avgs from tidy data file
