rm(list=ls())

breast_cancer<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/breast-cancer-wisconsin.data.csv", na.strings = "?")

#1.1
summary(breast_cancer)

#1.2 missing values are being indicated as na in column F6
View(breast_cancer)
#1.3 mode
library(modeest)
PL_mfv<-mlv(breast_cancer$F6 , method = "mfv",na.rm = TRUE) 
str(PL_mfv)
PL_mfv$M
is.na(breast_cancer$F6)
breast_cancer[is.na(breast_cancer$F6),"F6"]<-PL_mfv$M

#1.4 Frequency Table
table(class=breast_cancer$Class,F6=breast_cancer$F6)
#1.5 Scatter plot
plot(breast_cancer[2:7])
#1.6 Histogram  box plot for columns F7 to F9
hist(breast_cancer$F7)
hist(breast_cancer$F8)
hist(breast_cancer$F9)

boxplot(breast_cancer[8:10])

#2 Delete all the objects from your R- environment. Reload the "breast-cancer-wisconsin.data.csv" from canvas into R. Remove any row with a missing value in any of the columns.

rm(list=ls())

breast_cancer<-read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/breast-cancer-wisconsin.data.csv", na.strings = "?")

breast_cancer<-na.omit(breast_cancer)