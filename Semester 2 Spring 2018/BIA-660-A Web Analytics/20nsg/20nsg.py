#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 26 19:50:44 2018

@author: Team 4
"""
import os
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics import accuracy_score
from sklearn.neighbors import KNeighborsClassifier
from nltk.corpus import stopwords
from sklearn.grid_search import GridSearchCV
from sklearn.ensemble import VotingClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn import linear_model
from itertools import islice

import re
from sklearn.feature_extraction.text import TfidfVectorizer 
from sklearn.naive_bayes import MultinomialNB


def loadData(path,label, reviews, labels):
    listing = os.listdir(path) 
    count = 0
    
    for file in listing:
        count = count+ 1
        linecount = 0
        f=open(path+'/'+file, encoding = "latin-1")
        for line in f:
            if re.match(r'\s', line):
                break
            else:
                linecount = linecount + 1
                f.readline()
                
        
        #print(f)
        labels.append(label)
        
        content = ''
        for line in islice(f,linecount,None):
             content += line.strip() 

        f.close()
        
        reviews.append(content.lower()) 
        
           

    return reviews,labels

reviews=[]
labels=[]

reviews_train,labels_train=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Trainng/comp.graphics', 'comp', reviews, labels)
reviews_train,labels_train=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Trainng/rec.sport.hockey', 'sports', reviews, labels)

reviews_train,labels_train=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Trainng/comp.os.ms-windows.misc','comp', reviews, labels)

reviews_train,labels_train=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Trainng/rec.motorcycles', 'rec', reviews, labels)
reviews_train,labels_train=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Trainng/talk.politics.guns', 'politics', reviews, labels)

reviews_train,labels_train=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Trainng/talk.politics.mideast','politics', reviews, labels)

reviews_test=[]
labels_test=[]



reviews_test,labels_test=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Testing/comp.windows.x','comp', reviews_test, labels_test)

reviews_test,labels_test=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Testing/rec.autos', 'rec', reviews_test, labels_test)
reviews_test,labels_test=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Testing/rec.sport.baseball', 'sports', reviews_test, labels_test)

reviews_test,labels_test=loadData('/Users/amit/Desktop/Masters/Semester 2/Web Analytics/Week 8/Testing/talk.politics.misc','politics', reviews_test, labels_test)




counter = CountVectorizer(stop_words=stopwords.words('english'))

#counter = TfidfVectorizer( min_df = 0, max_df = 0.8, sublinear_tf = True, use_idf = True, max_features = None, vocabulary = None, binary = True)
#counter = TfidfVectorizer(analyzer = "word", binary = False, ngram_range = (1, 4),
#                    stop_words = stopwords.words('english'),  min_df = 2)
counter.fit(reviews_train)

#count the number of times each term appears in a document and transform each doc into a count vector
counts_train = counter.transform(reviews_train) #transform the training data
counts_test = counter.transform(reviews_test) #transform the testing data

MNB = MultinomialNB(alpha=0.08,fit_prior=True,class_prior=None)
#MNB = DecisionTreeClassifier()
MNB.fit(counts_train,labels_train)
prd = MNB.predict(counts_test)
print(accuracy_score(prd,labels_test))

'''
MNB_classifier = MultinomialNB()


KNN_classifier=KNeighborsClassifier()
LREG_classifier=LogisticRegression()
DT_classifier = DecisionTreeClassifier()

predictors=[('knn',KNN_classifier),('lreg',LREG_classifier),('dt',DT_classifier), ('mnb',MNB_classifier)]

VT=VotingClassifier(predictors)

#=======================================================================================
#build the parameter grid

MNB_grid = [{'alpha': [1]}]
#MNB_grid = MultinomialNB(alpha=0.08,fit_prior=True,class_prior=None)

#build a grid search to find the best parameters
gridsearchMNB = MultinomialNB(MNB_classifier, MNB_grid)

#run the grid search
gridsearchMNB.fit(counts_train,labels_train)


#=======================================================================================
#build the parameter grid
KNN_grid = [{'n_neighbors': [3,5,10], 'weights':['uniform','distance']}]

#build a grid search to find the best parameters
gridsearchKNN = GridSearchCV(KNN_classifier, KNN_grid, cv=3)

#run the grid search
gridsearchKNN.fit(counts_train,labels_train)

#=======================================================================================

#build the parameter grid
DT_grid = [{'max_depth': [3,4,5,6,7,8],'criterion':['gini','entropy']}]

#build a grid search to find the best parameters
gridsearchDT  = GridSearchCV(DT_classifier, DT_grid, cv=3)

#run the grid search
gridsearchDT.fit(counts_train,labels_train)

#=======================================================================================

#build the parameter grid
LREG_grid = [ {'C':[0.5,1,1.5,2],'penalty':['l1','l2']}]

#build a grid search to find the best parameters
gridsearchLREG  = GridSearchCV(LREG_classifier, LREG_grid, cv=3)

#run the grid search
gridsearchLREG.fit(counts_train,labels_train)

#=======================================================================================





VT.fit(counts_train,labels_train)

#use the VT classifier to predict
predicted=VT.predict(counts_test)

#print the accuracy
print (accuracy_score(predicted,labels_test))
'''