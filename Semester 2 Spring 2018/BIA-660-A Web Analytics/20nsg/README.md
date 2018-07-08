# 20 Newsgroup
- Download the 20 newsgroups dataset from here: https://archive.ics.uci.edu/ml/datasets/Twenty+Newsgroups (Links to an external site.)Links to an external site.

- There are 20 folders. Use them to make a training set and a testing set.

- The testing set should include:

* All the documents from the folder "comp.windows.x". Their label should be "comp".

* All the documents from the folder "rec.sport.baseball". Their label should be "sports".

* All the documents from the folder "talk.politics.misc". Their label should be "politics".

* All the documents from "rec.autos". Their label should be "rec".

- You can use any of the other folders to build the training set. You can use as many documents and folders as you want. You cannot use documents from the 4 folders of the testing set. You cannot use external documents that are not from the 20 newsgroups dataset.

- Write a classification script that reads the 20 newsgroups dataset, creates the training and testing sets and gets the maximum possible accuracy on the testing set.

- IMPORTANT: MAKE SURE THAT YOUR SCRIPT ALWAYS DELETES AND IGNORES ALL THE LINES THAT APPEAR BEFORE THE FIRST EMPTY LINE OF EACH DOCUMENT. THIS APPLIES TO BOTH TESTING AND  TRAINING DOCUMENTS. This has to happen before you train and apply the model.

- Submit the script.

- This is a team assignment. 

- You get 10 points if you submit a script that works, even if the accuracy is low. 

- You get +3 points for every team that get a lower accuracy than yours.


