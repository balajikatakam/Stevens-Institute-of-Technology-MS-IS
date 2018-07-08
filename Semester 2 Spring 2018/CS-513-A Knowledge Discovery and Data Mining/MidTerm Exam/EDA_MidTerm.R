rm(list=ls())

#install.packages("ggplot2")
library(ggplot2)

#read IBM ATTRITION V3
IBM<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/Balaji MidTerm/IBM_Attrition_v3.csv", na.strings = "?")

#1.1
summary(IBM)

#1.2 missing values are being indicated as na in column F6
View(IBM)

#1.3 Frequency Table
table(Attrition=IBM$Attrition,MaritalStatus=IBM$MaritalStatus)

#1.4 Scatter plot
plot(IBM[,-c(2,4,6)])

#1.5 histogram
boxplot(IBM[,-c(2,4,6)])

hist(IBM$Age)

str(IBM$MaritalStatus)
table(IBM$MaritalStatus)
ggplot(IBM, aes(x=MaritalStatus)) +
  geom_bar()

hist(IBM$YearsAtCompany)


#1.6 Replace na with mean of monthly income
IBM$MonthlyIncome <- ifelse(is.na(IBM$MonthlyIncome), mean(IBM$MonthlyIncome, na.rm=TRUE), IBM$MonthlyIncome)





