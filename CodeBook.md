1. Collecting indeces of columns names which contains **mean** and **std**

    - **mean** means Mean value
    - **std** means Standard deviation

    ```
    column_names_store <- read.table(
      "./original_data//UCI HAR Dataset/features.txt",
      col.names = c("feature_number", "column_name"),
      colClasses = c("numeric", "character"))
    
    column_names <- column_names_store$column_name
    
    mean_and_std_column_indeces <- c(grep("mean", column_names), grep("std", column_names))
    ```    

2. Collecting **activities**, data frame sontains two collumns *activity_id* and *activity*

    ```
    activities <- read.table(
      "./original_data/UCI HAR Dataset/activity_labels.txt",
      col.names = c("activity_id", "activity"),
      colClasses = c("numeric", "character"))
    ```

3. Common function which consumes the original data class which can be **train** or **test** and
    than join subject_id, activities names and observed data into one data frame

    ```
    readData <- function(className) {
      data <- read.table(
        paste("./original_data//UCI HAR Dataset/", className, "/X_", className, ".txt", sep=""),
        col.names = column_names)
      
      data_needed <- data[, mean_and_std_column_indeces]
      
      data_activities <- read.table(
        paste("./original_data//UCI HAR Dataset/", className, "/y_", className, ".txt", sep=""),
        col.names = c("activity_id"))
      
      activity <- merge(data_activities, activities, by="activity_id")$activity
      
      data_subject <- read.table(
        paste("./original_data/UCI HAR Dataset//", className, "/subject_", className, ".txt", sep=""),
        col.names = c("subject_id"))
      
      data_needed <- cbind(data_subject, activity, data_needed)
    
      return(data_needed)
    }
    ```
4. Bind **train** and **test** data frames into one vertically
    ```
    binded <- rbind(readData("train"), readData("test"))
    ```
5. Write binded data into file **observed.txt** in **data** folder
    ```
    write.table(binded, "./data/observed.txt", col.names=FALSE, row.names=FALSE)
    ```
6. Calculates factor groupes by **subject** and **activity**
    ```
    subject_factor <- factor(binded$subject_id)
    activities_factor <-factor(binded$activity)
    ```
7. Calculate the average of each variable for each activity and each subject and than order it by subject
    ```
    grouped <- aggregate(binded[, -c(1,2)], list(subject_factor, activities_factor), FUN=mean)
    ordered <- grouped[order(grouped[1]), ]
    ```
8. Write ordered data into file **mean.txt** in **data** folder
    ```
    write.table(ordered, "./data/mean.txt", col.names=FALSE, row.names=FALSE)
    ```
9. Calculate columns names and write them into file **features.txt** in **data** folder
    ```
    data_column_names <- c("subject_id", "activity", column_names[mean_and_std_column_indeces])
    write.table(data_column_names, "./data/features.txt", col.names=FALSE, row.names=FALSE)
    ```