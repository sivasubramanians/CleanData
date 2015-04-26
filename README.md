# Tidy data set creation from a Human Activity Recognition Dataset 
This file gives an overview of how to create a tidy data set - This dataset will have variables derived by calculating the mean values of experimental variables that are collected from Human activity observation (using a smart phone).

The source dataset for this analysis can be obtained from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". 
Extract (unzip) the files to your working directory. The run_analysis.R file assumes that the initial datasets are extracted to your
working directory. 

The steps involved in creating a tidy dataset by transforming the data is as follows:

1. Read the three files that are part of the test dataset: X_test.txt, y_test.txt and subject_test.txt into a dataframe

2. Read the three files that are part of the training dataset: X_train.txt, y_train.txt and subject_train.txt into a dataframe

3. Merge the three test files into a single file and similiarly merge the three training files into a single file 

4. Assign column names to the test & training data frames.

5. Merge the test & training data frames into a single dataframe (using rbind)

6. In the merged dataframe, identify the columns which has mean and standard deviation values and extract a new dataset with only the mean & standard deviation variables along with the subject and activity variables.

7. Calculate the mean of filtered variables grouped by Activity & Subject details (ddply function)

8. Provide descriptive names to the variables created

9. Write the new data set to a text file 
