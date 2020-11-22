# read and load data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

# 1-merge train and test data set
x <- rbind(x_train, x_test)

# 2-extract only mean and std
mean_std <- grep("mean()|std()", features[,2])

# define descriptive names
Descriptive_names <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(x) <- Descriptive_names[mean_std]

# average for each subject and activity
summarised <- dataset %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

write.table(summarised, "final_table.txt")
