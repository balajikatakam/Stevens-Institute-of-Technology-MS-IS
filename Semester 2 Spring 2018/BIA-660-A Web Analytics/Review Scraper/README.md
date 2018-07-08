# Review Scraper
- Create a script named parser.py 

- Your script should define the following functions:

def getCritic(review): finds and returns the name of the critic from the given review object


def getRating(review):  finds and returns the rating from the given review object. The return value should be 'rotten' ,  'fresh', or 'NA' if the review doesn't have a rating.

 

def getSource(review):  finds and returns the source (e.g 'New York Daily News') of the review from the given review object. The return value should be 'NA' if the review doesn't have a source.

 

def getDate(review):  finds and returns the date of the review from the given review object. The return value should be  'NA' if the review doesn't have a date.


def getTextLen(review):  finds and returns the number of characters in the text of the review from the given review object. The return value should 'NA' if the review doesn't have text.

 

Notes:- Your script will be used to extract the critic, rating, source, date, and text length of 20 reviewers from a page of reviews on RottenTomatoes. Each of the total 20x5=100 fields is worth 5/100=0.05 points. If you return all of them correctly, you get 5 points.
