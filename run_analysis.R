#merge training and test sets

x<- rbind(x_train, x_test)
y<-rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged <- cbind(Subject, x,y)

# extract the mean and standard deviation
mstdata <- Merged %>% select(subject, code, contains("mean"), contains("std"))

mstdata$code <- activities[mstdata$code, 2]

#label the data set with variable names




