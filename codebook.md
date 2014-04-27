#CODE BOOK

The following code book explains the cleaning data process:

##1. Obtaining data

*Data was downloaded from the following link to the work directory :https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
*The working directory must contain the folder named "UCI HAR Dataset"
*The main datasets are "train.txt" and "test.txt", but were first read with the <readLines> function

##2. Adjusting format

*"test and "train" datasets were then transformed into tables using the <read.table> function specifiyng thetext argument as TRUE so it recognizes the origin format of the data. The separation observed was an empty space, so the arg sep=" ". Each line or row did not have the same columns so the fill argument filled missing colmns with NA.
*the time spent to do certain parts of the code was quite long so time to time the <write.csv> function was used to save the resulting data frames.
*After doing this there were a lot of missing values that came from double spaces in the original data, so a <for loop> was done to eliminate NA values row by row. Each row now had 561 values, corresponding to the number of features specified. The for loop was divided in some pieces because of the time spent to completed in order to avoid an excessive amount of time running it.
*"test3" and "train3" are the data frames for each group that will be used afterwards in the new tidy data.

##3. Names of features

*features were also read with readLines and then with read.table, so a vector with the features was created, each corresponding to the name of a column in both previous data sets.
*<grep> function was used to subset the features to the ones containing information of the "mean" and "standard deviation", the "\\" was used to avoid subsetting meanFreq that was not a variable of interest.
*"used.feat told us the position within the vector features of the features we were going to need.

##4. Merging data

*in both datasets "train3" and "test3" we used the names in features as the name for each column
*we created a "group" column so we can identify which rows correspond to data from "test" and which from "train". The group variable has 2 levels: "train" or "test".
*both datasets had the same column names and the same number of columns so the <cbind> function was used to merge both datasets into data1.
*the identical funtcion was used to see if there was been a good merge without eliminating rows of observations.
*data2 was created as a subset of data1 but only with the columns that we were interested by using the numeric vector: "used.feat".

##5. Arreging new tidy data
*the tidy data specified had the average of the values for each subject and variable
*tidy was created as a data frame with the first column as the names of the variables in data2 and the second as the value that was the mean of each column of the data2 dataset.
*a new column was created to specify if the vale was a "mean" or "standard deviation". I used the <grepl> function to have a logical vector and combined with the <ifelse function>.
* the same process was repeated to add more information extracted from the original name of the variable, creating the following columns:

    *AXIS: indicates the axis measured and the levels are: "X","Y","Z" and magnitude if it was a magnitude.
    *UNIT: if it was "time" or a "fast fourier transform", the same names were used as levels
    *SENSOR: if the sensor used was "ACCELERATOR" or "GYROSCOPE", using same names as levels
    *SINGALS: it he signal was od the "BODY" or "GRAVITY.
    *JERK.SIGNAL: it the variable is a jerk signal, the levels are "JERK" or "No JERK" it it is not.
    
*finally the tidy dataset was saved into the working directory as a table in csv format.

 
