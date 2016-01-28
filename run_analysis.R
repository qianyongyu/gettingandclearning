library(dplyr)
library(tidyr)

# read and merge data files
train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
data <- rbind(train, test)

# read and merge label files
train_label <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("label")) 
test_label <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("label"))
label <- rbind(train_label, test_label)

# read and merge subject files
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
subject <- rbind(train_subject, test_subject)

# index is required for the gather / merge / spread process
idx <- list(idx = 1:dim(data))

# combine all columns
df <- cbind(data, label, subject, idx)

# gather measure names into a column to be joined with the feature list
gathered <- df %>% 
  gather(key = "column", value = "value", c(1:561)) %>%
  mutate(column = extract_numeric(column))

# read, filter and clean up feature list
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("column", "feature")) %>% 
  filter(grepl("mean\\(\\)|std\\(\\)", feature)) %>% 
  mutate(feature = tolower(gsub("\\W+", "", feature)))

# join data with feature list and spread into columns again
feature_merged <- merge(x = gathered, y = features, by = "column") %>%
  select(-column) %>%
  spread(feature, value) %>%
  select(-idx)

# convert label to activity mapping
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))
final <- merge(feature_merged, activities, by = "label") %>%
  select(-label)

# summarize by subject and activity
summarized <- final %>% 
  group_by(activity, subject) %>%
  summarize_each(funs(mean))

write.table(summarized,  file = "summarized.txt", row.names = FALSE)

  




