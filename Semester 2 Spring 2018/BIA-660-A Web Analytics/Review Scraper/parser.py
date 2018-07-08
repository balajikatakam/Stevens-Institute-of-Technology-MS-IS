
"""
@author: Balaji Anand Katakam
Web Analytics BIA 660
Parser.py Assignment
"""
from bs4 import BeautifulSoup
import re
import time
import requests

def getCritic(review):            
    critic='NA'
    criticChunk=review.find('a',{'href':re.compile('/critic/')})
    if criticChunk: critic=criticChunk.text
    return str(critic)
    
def getRating(review):
    rating='NA'
    ratingFresh = review.find('div',{'class':re.compile('small fresh')});
    ratingRotten = review.find('div',{'class':re.compile('small rotten')});
    if ratingFresh: rating = 'fresh'
    if ratingRotten: rating = 'rotten'
    return str(rating)
    
def getSource(review):
    source = 'NA'
    sourceChunk = review.find('a',{'href':re.compile('/source')})
    if sourceChunk: 
        source = sourceChunk.find('em')
        source = str(source.text)
    return source

def getDate(review):
    date='NA'
    dateChunk=review.find('div', {'class':re.compile('review_date')})
    if dateChunk: date=dateChunk.text
    return str(date)
		
def getTextLen(review):
    text = 'NA'
    textLen = 'NA'
    textChunk=review.find('div',{'class':'the_review'})
    if textChunk: text=textChunk.text
    textLen = len(text.strip())
    if textLen==0: textLen='NA'
    return str(textLen)



def run(url):

    pageNum=1 # number of pages to collect

    fw=open('reviews.txt','w') # output file
	
    for p in range(1,pageNum+1): # for each page 

        print ('page',p)
        html=None

        if p==1: pageLink=url # url for page 1
        else: pageLink=url+'?page='+str(p)+'&sort=' # make the page url
		
        for i in range(5): # try 5 times
            try:
                #use the browser to access the url
                response=requests.get(pageLink,headers = { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', })
                html=response.content # get the html
                break # we got the file, break the loop
            except Exception as e:# browser.open() threw an exception, the attempt to get the response failed
                print ('failed attempt',i)
                time.sleep(2) # wait 2 secs

    
        if not html:continue # couldnt get the page, ignore
        
        soup = BeautifulSoup(html.decode('ascii', 'ignore'),'lxml') # parse the html 

        reviews=soup.findAll('div', {'class':re.compile('review_table_row')}) # get all the review divs

        for review in reviews:
            
            critic=getCritic(review)
            rating=getRating(review)
            date=getDate(review)
            source=getSource(review)
            textLen=getTextLen(review)
            
            fw.write(critic+'\t'+rating+'\t'+source+'\t'+date+'\t'+textLen+'\n') # write to file 
            print(critic+'\t'+rating+'\t'+source+'\t'+date+'\t'+textLen+'\n')
            time.sleep(1)	# wait 2 secs 

    fw.close()

if __name__=='__main__':
    url='https://www.rottentomatoes.com/m/space_jam/reviews/'
    run(url)


