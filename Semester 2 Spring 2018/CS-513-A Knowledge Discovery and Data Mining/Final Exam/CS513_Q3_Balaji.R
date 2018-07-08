#################################################
#  College    : Stevens 
#  Subject    : CS 513A-KDDM
#  Purpose    : Final Exam Assignment
#  First Name : Balaji
#  Last Name  : Katakam
#  Id			    : 10423274
#  Date       : 05/09/2018
#  Comments   :
#################################################
remove(list=ls())
library(e1071)
library(class)
library(C50)
library(randomForest)
library(rpart)
library(rpart.plot)
library(rattle)
library(RColorBrewer)
library(randomForest)

#Q3. Use the "IBM Employee Attrition V2" dataset in CANVAS and apply algorithms to it
#read the dataset from directory (IBM attrition csv file)
data <- read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/IBM_Employee_Attrition_V2.csv")
#View(data)

#Check levels available for every Variable
levels(data$Attrition)
levels(data$BusinessTravel)
levels(data$Gender)
levels(data$MaritalStatus)
levels(data$OverTime)

#Convert to Factor Variable

data$Attrition <- as.factor(data$Attrition)
data$BusinessTravel <- as.factor(data$BusinessTravel)
data$Gender <- as.factor(data$Gender)
data$MaritalStatus <- as.factor(data$MaritalStatus)
data$OverTime <- as.factor(data$OverTime)

is.factor(data$Attrition)
is.factor(data$OverTime)

#Lets Remove Employee ID
data <- subset(data,select = -c(EmployeeID))

#Splitting the data into training and test in the ratio of 75:25.
set.seed(123)
index<-sort(sample(nrow(data),round(.25*nrow(data))))
training<-data[-index,]
test<-data[index,]
#View(training)

#CART
CART_class<-rpart( Attrition~.,data=training)
rpart.plot(CART_class)

CART_predict2<-predict(CART_class,test, type="class")
CART_wrong2<-sum(test[,2]!=CART_predict2)
CART_error_rate2<-CART_wrong2/length(test[,2])
CART_error_rate2 

#Error Rate is 0.1413043
#Primary Splitting Node is TotalWorkingYears for CART

#C50

C50_class <- C5.0( Attrition~.,data=training )

summary(C50_class )

#	Attribute usage: 100.00%	OverTime 100.00%	TotalWorkingYears 85.84%	EnvironmentSatisfaction

plot(C50_class)
C50_predict<-predict( C50_class ,test , type="class" )
table(actual=test[,2],C50=C50_predict)
wrong<- (test[,2]!=C50_predict)
c50_rate<-sum(wrong)/length(test[,2])
c50_rate

#Error Rate is 0.1494565

#Random Forest
#importance means to measure importance of the values
fit_rf <- randomForest( Attrition~., data=training, ntree=1000)
importance(fit_rf)
varImpPlot(fit_rf)
#The Top 3 Important Features based on MeanDecreaseGini are MonthlyIncome, Age and TotalWorkingYears


Prediction <- predict(fit_rf, test)
table(actual=test[,2],Prediction)


wrong<- (test[,2]!=Prediction )
error_rate<-sum(wrong)/length(wrong)
error_rate 

#The Most Important feature is Totalworkingyears, since it's used as a primary feature in every model.
