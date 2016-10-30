# CodeBook

This CodeBook describes the data, variables and transformations that have been performed to clean up the data.

## Dataset

The dataset used here (Human Activity Recognition Using Smartphones Data Set) is from the area of wearable computing. It contains recorded values from the accelerometers of Samsung Galaxy S smartphones.
Further information can be found here: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Transformation steps

1. Create R script to save the commands for this assignment and load library **data.table**
2. Define names of files and directory "data" to save the dataset
3. Download dataset and unzip it
4. View Readme file and explore all the other files
5. Load activity labels and features
6. Load test and training data
7. Remove underscores from activity labels for easier processing
8. Specify the labels that will be needed to calculate the result; only labels containing **mean** or **std** are considered relevant here
9. Combine the data from test and training files
10. Remove parentheses from data
11. Merge the created data frames (step 9) into a new data frame
12. Save tidied data info text file **tidy_data.txt**
13. Create a **data.table** from the tidied data
14. Apply SD and mean function to data to calculate the required values
15. Save results to another text file **result_tidy_data.txt**

## Variables

* activityData contains the value that describes the action at the time of recording a value (e.g. walking, standing or laying)
* subjectId contains a number between 1 and 30 that refers to one of the 30 participants that helped to collect data
* furthermore there are several columns for values regarding data collected by the accelerometers (three axis and a number of recording aspects)