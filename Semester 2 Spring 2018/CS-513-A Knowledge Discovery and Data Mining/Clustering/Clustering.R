#  First Name      : Balaji
#  Last Name       : Katakam
#  Id              : 10423274
#  purpose         : Cluster analysis for Breast cancer

#install.packages("factoextra")
#install.packages("ggplot2")
remove(list=ls())
library(ggplot2)
library(factoextra)
breast_cancer<-
  read.csv("G://Stevens/Semester 2/CS-513-A Knowledge Discovery and Data Mining/breast-cancer-wisconsin.data.csv",
           na.strings = "?")
breast_cancer2<-na.omit(breast_cancer)

breast_cancer2_dist<-dist( breast_cancer2[,-c(1,11)])
hclust_resutls<-hclust(breast_cancer2_dist, method = 'average')
#plot(hclust_resutls)
hclust_2<-cutree(hclust_resutls,2)
table(hclust_2,breast_cancer2[,11])
hcl <- hclust_2*2
wrong_1<- (hcl!=breast_cancer2[,11] )
error_rate_1<-sum(wrong_1)/length(wrong_1)
error_rate_1

#kmeans clustering
kmeans_2<- kmeans(breast_cancer2[,-c(1,11)],2,nstart = 10)
kmeans_2$cluster
table(kmeans_2$cluster,breast_cancer2[,11])
kmn <- kmeans_2$cluster*2
wrong_2<- (kmn!=breast_cancer2[,11])
error_rate_2<-sum(wrong_2)/length(wrong_2)
error_rate_2
