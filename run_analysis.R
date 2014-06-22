column_names_store <- read.table(
  "./original_data//UCI HAR Dataset/features.txt",
  col.names = c("feature_number", "column_name"),
  colClasses = c("numeric", "character"))

column_names <- column_names_store$column_name

mean_and_std_column_indeces <- c(grep("mean", column_names), grep("std", column_names))

activities <- read.table(
  "./original_data/UCI HAR Dataset/activity_labels.txt",
  col.names = c("activity_id", "activity"),
  colClasses = c("numeric", "character"))

readData <- function(className) {
  path <- "./original_data/UCI HAR Dataset/"
  
  data <- read.table(
    paste(path, className, "/X_", className, ".txt", sep=""),
    col.names = column_names)
  
  data_needed <- data[, mean_and_std_column_indeces]
  
  data_activities <- read.table(
    paste(path, className, "/y_", className, ".txt", sep=""),
    col.names = c("activity_id"))
  
  activity <- merge(data_activities, activities, by="activity_id")$activity
  
  data_subject <- read.table(
    paste(path, className, "/subject_", className, ".txt", sep=""),
    col.names = c("subject_id"))
  
  data_needed <- cbind(data_subject, activity, data_needed)

  return(data_needed)
}

binded <- rbind(readData("train"), readData("test"))

write.table(binded, "./data/observed.txt", col.names=FALSE, row.names=FALSE)

subject_factor <- factor(binded$subject_id)
activities_factor <-factor(binded$activity)

grouped <- aggregate(binded[, -c(1,2)], list(subject_factor, activities_factor), FUN=mean)
ordered <- grouped[order(grouped[1]), ]

write.table(ordered, "./data/mean.txt", col.names=FALSE, row.names=FALSE)

data_column_names <- c("subject_id", "activity", column_names[mean_and_std_column_indeces])
write.table(data_column_names, "./data/features.txt", col.names=FALSE, row.names=FALSE)