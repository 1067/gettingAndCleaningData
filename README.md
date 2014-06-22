==================================================================
Course project for 'Getting and Cleaning data' course from coursera.org
Version 1.0
==================================================================

The repo includes the following files:
=========================================

- 'README.md'
- 'run_analysis.R': Contains R code to clean up data
- 'CodeBook.md': Describes the variables, the data, and any transformations or work that performed to clean up the original data
- 'original_data': Contains original data package with own 'README.txt' file
- 'data/mean.txt': Data set with the average of each variable for each activity and each subject from 'observed.txt'
- 'data/observed.txt': Contains only  only the measurements on the mean and standard deviation for each measurement from original data
- 'data/features.txt': Contains column names (gathered features) for 'mean.txt' and 'observed.txt'

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
