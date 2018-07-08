# 4 grams
Create script called getngrams.py. 

Your script should define the following functions:

 

processSentence(sentence,posLex,negLex,tagger):  The parameters of this function are a sentence (a string), a set positive words, a set of negative words, and a POS tagger.  The function should return a list with all the 4-grams in the sentence that have the following structure:                                                   

not <any word> <pos/neg word> <noun>

For example: not a good idea

 ---------------------------------------------------------------------------------------------

getTop3(D): The only parameter of this function is a dictionary D.  All the values in the dictionary are integers. The function returns a list of the keys with the 3 largest values in the dictionary.

 

Notes:

Don't change the names or the parameters of any of the functions
Make sure that your script imports all the libraries needed by the two functions
Ignore case 
