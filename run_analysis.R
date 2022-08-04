#merge training and test sets

x<- rbind(x_train, x_test)
y<-rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged <- cbind(Subject, x,y)

# extract the mean and standard deviation
mstdata <- Merged %>% select(subject, code, contains("mean"), contains("std"))

mstdata$code <- activities[mstdata$code, 2]

#label the data set with variable names

names(mstdata)[2] = "activity"
names(mstdata)<-gsub("Acc", "Accelerometer", names(mstdata))
names(mstdata)<-gsub("Gyro", "Gyroscope", names(mstdata))
names(mstdata)<-gsub("BodyBody", "Body", names(mstdata))
names(mstdata)<-gsub("Mag", "Magnitude", names(mstdata))
names(mstdata)<-gsub("^t", "Time", names(mstdata))
names(mstdata)<-gsub("^f", "Frequency", names(mstdata))
names(mstdata)<-gsub("tBody", "TimeBody", names(mstdata))
names(mstdata)<-gsub("-mean()", "Mean", names(mstdata), ignore.case = TRUE)
names(mstdata)<-gsub("-std()", "STD", names(mstdata), ignore.case = TRUE)
names(mstdata)<-gsub("-freq()", "Frequency", names(mstdata), ignore.case = TRUE)
names(mstdata)<-gsub("angle", "Angle", names(mstdata))
names(mstdata)<-gsub("gravity", "Gravity", names(mstdata))

#create the data set with the averages
FinalData <- mstdata %>%
  group_by(subject, activity) %>%
  summary(funs(mean))

write.table(FinalData, "FinalData.txt", row.name=FALSE)



  