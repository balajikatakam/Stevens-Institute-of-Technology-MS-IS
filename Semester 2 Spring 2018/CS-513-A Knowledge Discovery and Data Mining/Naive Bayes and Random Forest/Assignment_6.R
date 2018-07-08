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
#install.packages
#install.packages(e1071)
#install.packages(class)
#install.packages(randomForest)

library(e1071)
library(class)
library(randomForest)

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

# Naïve Bayes method to develop a classification model
set.seed(299)

index<-sort(sample(nrow(breast_cancer_cpy),round(.25*nrow(breast_cancer_cpy))))
training<-breast_cancer_cpy[-index,2:11]
test<-breast_cancer_cpy[index,2:11]

nBayes_all <- naiveBayes(Class~., data=training)
cat_all <- predict(nBayes_all, test)

table(NB_all=cat_all,Class=test$Class)
wrong_nb<-sum(cat_all!=test$Class)
error_rate_nb<-wrong_nb/length(cat_all)
#print the error rate
error_rate_nb

# Random Forest method to develop a classification model
set.seed(299)

index<-sort(sample(nrow(breast_cancer_cpy),round(.25*nrow(breast_cancer_cpy))))
training<-breast_cancer_cpy[-index,2:11]
testing<-breast_cancer_cpy[index,2:11]

fit_rf<- randomForest( Class~., data=training, importance=TRUE, ntree=10000, proximity=TRUE, na.action = na.omit)
importance(fit_rf)
varImpPlot(fit_rf)
Prediction_rf<- predict(fit_rf, testing)
#plot the table of prediction
table(actual=testing[,10],Prediction_rf)


wrong_rf<- (testing[,10]!=Prediction_rf)
error_rate_rf<-sum(wrong_rf,na.rm = TRUE)/length(wrong_rf)
#print the error rate
error_rate_rf
print<-("The top 3 features are F2, F3 and F6")