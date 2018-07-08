# Sentiment Counter
Write a script called senticounter.py. Define a function run() inside senticounter.py.

The function should:

- Accept as a parameter the path to a text file. The text file has one review per line. 

- Read the list of positive words from the positive-words.txt file.

- Create a dictionary that includes one key for each positive word that appears in the input text file. The dictionary should map each of these positive words to the number of reviews that include it. For example, if the word "great" appears in 5 reviews, then the dictionary should map the key "great" to the value 5. 

- Return the dictionary 

Notes: Ignore case. You can also assume that the input file includes only letters, no punctuation or other special characters.
