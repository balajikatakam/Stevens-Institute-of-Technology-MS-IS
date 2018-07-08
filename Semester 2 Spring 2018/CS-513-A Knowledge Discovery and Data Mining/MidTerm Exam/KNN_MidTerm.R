#First Name: Balaji 
#Last Name: Katakam
#CWID: 10423274
#CS-513-A
#question 3.1
library(class)
rm(list=ls())

IBM<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/Balaji MidTerm/IBM_Attrition_v3.csv", na.strings = "")
IBM2<-na.omit(IBM)
IBM3=IBM2
#Question 3.2

IBM3$MaritalStatus <- as.numeric(factor(IBM3$MaritalStatus,
                                        levels=sort(unique(IBM3$MaritalStatus))))
range_1_100<-1:100
sample(range_1_100,70)
smpl70<-sort(sample(range_1_100,70))

idx<-sort(sample(nrow(IBM2),as.integer(.7*nrow(IBM2))))

training<-IBM2[idx,]

test<-IBM2[-idx,]

predict<-knn(training[,-c(3,6)],test[,-c(3,6)],training[,6],k=3)

table(Prediction=predict,Actual=test[,6])

#categorical value assigned for marital status
idx<-sort(sample(nrow(IBM3),as.integer(.7*nrow(IBM3))))

training1<-IBM3[idx,]

test1<-IBM3[-idx,]

predict1<-knn(training1[,-c(6)],test1[,-c(6)],training1[,6],k=3)

table(Prediction1=predict1,Actual=test1[,6])


