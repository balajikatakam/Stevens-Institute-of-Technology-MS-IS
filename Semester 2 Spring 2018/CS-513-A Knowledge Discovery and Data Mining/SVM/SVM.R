#  First Name	: Balaji
#  Last Name	: Katakam
#  Id			    : 10423274
# Assignment 9: SVM Iris

#Q)Select every 5th record of the IRIS dataset and create the test dataset. 
#Use the remaining records as the training dataset. 
#Predict the species for the test datasets using SVM. What is the error rate? 

rm(list=ls())
library(e1071)
library(rpart)
data("iris")
View(iris)

levels(iris$Species)
is.factor(iris$Species)

##### Splitting the dataset #####
idx<-seq(1,nrow(iris),by=5)
training<-iris[-idx,]
test<-iris[idx,]


##### SVM #####
svm.model<-svm(factor(Species)~., data=training)
svm.pred<-predict(svm.model, test)

table(Actual=test[,5],svm.pred)
SVM_wrong<-(test$Species!=svm.pred)
rate<-sum(SVM_wrong)/length(SVM_wrong)
rate

#print error rate
