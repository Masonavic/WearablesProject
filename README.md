# Samsung Wearables Data Analysis
Project for Getting and Cleaning Data Course on Coursera

The purpose of the R script `run_script.r` is to collect and process data from the "UCI HAR Dataset" and present it as a "tidy" dataset.

The sequence of commands in the data processing script are summarized below:

1. The script starts (lines 5 and 6) by reading in the activity (e.g. walking, standing, etc) and feature (i.e body acceleration, gravity acceleration, etc) definitions, both as character vectors.
2. Next, lines 8-29 performs the following sequence on both the test and training datasets:
 1. Reads in the `X` file, which contains the time series for all of the accelerometer data, into a variable called `(test/train)DataTimeSeries`. This winds up being a 561-column data frame.
 2. Reads in the `subject` file, which contains the time series for all of the subjects. This is a 1-column data frame called `(test/train)SubjectTimeSeries` with several repeated values, as presumably several time series points are recorded for a single subject.
 3. Reads in the `y` file, which contains activity codes for the time series. This is a 1-column data frame called `(test/train)ActivityCodeTimeSeries`
 4. Accomplishing **Objective 3**, the `(test/train)ActivityCodeTimeSeries` is translated from codes into activity names by subsetting the `activitydefs` character vector.
 5. Finally, all of the data is integrated into one data frame called `(test/train)TimeSeries` using `cbind`. The use of `[[1]]` is to ensure that a vector is passed to the function rather than a 1-column data frame, which `cbind` apparently can't handle. This results in a 563-column data frame.
3. Line 35 integrates all data from both test and training data sets by using `rbind`, accomplishing **Objective 1**.
4. Line 38 accomplishes **Objective 2** by filtering only the columns containing "mean" or "std" designations. A `grep` command is used for this purpose. The first two columns (Subject and  Activity) are retained. The column count is reduced to 68 after this operation.
5. Finally, **Objective 5** is accomplished in line 41 by an `aggregate` command. This results in the final variable that is used to output the Tidy data set, `MeanStdSummary`, which averages all of the "mean" and "std" data columns by Subject and Activity.

It is my contention that **Objective 4** is accomplished by using the feature and activity definitions supplied, in addition to the code book.
