# Project-Assignment-Cleaning-Data
DataSource and Description: Please find the data used and the description from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The Solution contains 3 function
1> create_table: This reads the different text files and uses mapping decricribed in the data set to create a data table
2> mergeandextracts: 
Calls create_table for training and test data set and then merges the two data table returned.
Then a grep function is done on the column names of the merged data set to identify and exxtract only the mean and STD of the different variables
3> Summarize is used to write the summary table as asked

