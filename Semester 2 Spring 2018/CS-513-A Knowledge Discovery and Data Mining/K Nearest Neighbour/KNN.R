#First Name: Balaji 
#Last Name: Katakam
#CWID: 10423274
#CS-513-A
#question 3.1
library(class)
rm(list=ls())
?knn()
test_data1<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/knn/Test_Data_Set.csv")
train_data1<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/knn/Training_DataSet.csv")
#prediction when k=2
prediction <- knn(train_data1[,-5],test_data1[,-5],train_data1[,5],k=2)
table(prediction_q1=prediction,Actual1=test_data1[,5])
#error rate
check<-c(prediction)==c(test_data1[,5])
error_rate<-(1-sum(check)/length(check))*100
cat("Error Rate is: ",error_rate)

#question 3.2

breast_cancer<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/breast-cancer-wisconsin.data.csv", na.strings = "?")
# Q 3.2 A
breast_cancer<-na.omit(breast_cancer)
#q 3.2 B
test <- seq(1,nrow((breast_cancer)),by=5)
test_data <- breast_cancer[test,]
train_data <- breast_cancer[-test,]


prediction_1 <- knn(train_data[,2:10],test_data[,2:10],train_data[,11],k=1)
table(prediction_11=prediction_1,Actual=test_data[,11])
error_1=round(mean(test_data[,11]!=prediction_1)*100,2)
print(paste0("Error Rate in DataSet When K=1 : ", error_1,"%"))
accu=100-error_1
print(paste0("Accuracy Rate : ",accu,"%"))

prediction_2 <- knn(train_data[,2:10],test_data[,2:10],train_data[,11],k=2)
table(prediction_22=prediction_2,Actual=test_data[,11])
error_2=round(mean(test_data[,11]!=prediction_2)*100,2)
print(paste0("Error Rate in DataSet When K=2 : ", error_2,"%"))
accu2=100-error_2
print(paste0("Accuracy Rate : ",accu2,"%"))



prediction_5 <- knn(train_data[,2:10],test_data[,2:10],train_data[,11],k=5)
table(prediction_55=prediction_5,Actual=test_data[,11])
error_5=round(mean(test_data[,11]!=prediction_5)*100,2)
print(paste0("Error Rate in DataSet When K=5 : ", error_5,"%"))
accu5=100-error_5
print(paste0("Accuracy Rate : ",accu5,"%"))

prediction_10 <- knn(train_data[,2:10],test_data[,2:10],train_data[,11],k=10)
table(prediction_1010=prediction_10,Actual=test_data[,11])
error_10=round(mean(test_data[,11]!=prediction_10)*100,2)
print(paste0("Error Rate in DataSet When K=10 : ", error_10,"%"))
accu10=100-error_10
print(paste0("Accuracy Rate : ",accu10,"%"))

