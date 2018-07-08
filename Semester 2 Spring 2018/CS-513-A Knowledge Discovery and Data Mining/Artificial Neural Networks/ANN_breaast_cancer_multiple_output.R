
#  First Name      : Balaji
#  Last Name       : Katakam
#  CWID            : 10423274
#  purpose         : Assignment ANN Multiple output  
#                  : Two output nodes i.e for Benign and Malignant


rm(list=ls())
library("neuralnet")

breastcancer<-
  read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/breast-cancer-wisconsin.data.csv",
           na.strings = "?")
### performing EDS over the dataset

#summary(breastcancer)
mean(breastcancer$F2)
mean(breastcancer$F6)
apply(breastcancer[,c(-1,-11)],2,mean)


### remove all the records with missing value
### see mfv and median for other strategies
?na.omit()


benign<-ifelse(breastcancer$Class==2,1,0)
malignant<-ifelse(breastcancer$Class==4,1,0)

breastcancer2<- na.omit(data.frame(breastcancer,benign,malignant))

index <- seq (1,nrow(breastcancer2),by=5)
test<-breastcancer2[index,]
training<-breastcancer2[-index,]


library("neuralnet")
?neuralnet()

net_breastcancer2  <- neuralnet(benign+malignant~F1+F2+F3+F4+F5+F6+F7+F8+F9
                                ,training, hidden=10, threshold=0.01)




#Plot the neural network
plot(net_breastcancer2)

net_breastcancer2_results <-compute(net_breastcancer2, test[,c(-1,-11,-12,-13)]) 
class(net_breastcancer2_results$net.result)


str(net_breastcancer2_results)

results1<-data.frame(Actual_Benign=test$benign,
                     Actual_Malignant=test$malignant,
                     ANN_Benign=round(net_breastcancer2_results$net.result[,1]),
                     ANN_Malignant=round(net_breastcancer2_results$net.result[,2]))


results12<-data.frame(Actual_Benign=test$benign,
                      Actual_Malignant=test$malignant,
                      ANN_Benign=round(net_breastcancer2_results$net.result[,1]),
                      ANN_Malignant=round(net_breastcancer2_results$net.result[,2])
                      ,Prediction=ifelse(round(net_breastcancer2_results$net.result[,1])==1,'B','M'))

table(Actual=results12$Actual_Malignant,Prediction=results12$Prediction)

wrong<- (round(net_breastcancer2_results$net.result[,1])!=test$benign )
error_rate<-sum(wrong)/length(wrong)
error_rate

#Plotting the neural network
plot(net_breastcancer2)
