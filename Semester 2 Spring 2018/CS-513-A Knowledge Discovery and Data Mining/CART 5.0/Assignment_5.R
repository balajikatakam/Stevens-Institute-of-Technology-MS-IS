#################################################
#  College    : Stevens 
#  Subject    : CS 513A Knowledge Discovery and Data Mining 
#  Assignment : Homework Assignment 5
#  First Name : Balaji
#  Last Name  : Katakam
#  Id			    : 10423274
#  Date       : 04/24/2018
#  Comments   : None
#################################################


rm(list=ls())
#install.packages("C50")
library('C50')
#loading the CSV into Breast_cancer
breast_cancer<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/naive bayes random forest/breast-cancer-wisconsin.data.csv",na.strings="?")
#view the dataframe
View(breast_cancer)
#creating a copy of the breast cancer dataframe
breast_cancer_cpy<-breast_cancer
#factoring every column of the dataframe
breast_cancer_cpy$F1 <- as.factor(breast_cancer_cpy$F1)
breast_cancer_cpy$F2 <- as.factor(breast_cancer_cpy$F2)
breast_cancer_cpy$F3 <- as.factor(breast_cancer_cpy$F3)
breast_cancer_cpy$F4 <- as.factor(breast_cancer_cpy$F4)
breast_cancer_cpy$F5 <- as.factor(breast_cancer_cpy$F5)
breast_cancer_cpy$F6 <- as.factor(breast_cancer_cpy$F6)
breast_cancer_cpy$F7 <- as.factor(breast_cancer_cpy$F7)
breast_cancer_cpy$F8 <- as.factor(breast_cancer_cpy$F8)
breast_cancer_cpy$F9 <- as.factor(breast_cancer_cpy$F9)
breast_cancer_cpy$Class <- as.factor(breast_cancer_cpy$Class)

#setting the seed to 299
set.seed(299)
#creating the Training and Testing Dataset
index<-sort(sample(nrow(breast_cancer_cpy),round(.25*nrow(breast_cancer_cpy))))
train<-breast_cancer_cpy[-index,2:11]
test<-breast_cancer_cpy[index,2:11]

# Whole dataset
C50_mainclass <- C5.0(Class~.,data=breast_cancer_cpy)
#summary of whole dataset
summary(C50_mainclass)

plot(C50_mainclass)

# splitting the Dataset into testing and training set
C50_training_class <- C5.0(Class~.,data=train)
summary(C50_training_class)
plot(C50_training_class)

C50_prediction<-predict( C50_training_class,test,type="class")
table(actual=test[,10],C50=C50_prediction)
wrong<- (test[,10]!=C50_prediction)
c50_error_rate<-sum(wrong)/length(test[,10])
#print the error rate
c50_error_rate
