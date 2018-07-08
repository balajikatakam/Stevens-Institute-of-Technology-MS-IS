
"""
Created on Mon Feb  5 18:54:21 2018

@author: Balaji Anand Katakam
CWID: 10423274
BIA-660
Web Analytics
"""

def loadLexicon(fname):
    newLex=set()
    lex_conn=open(fname)
    for line in lex_conn:
        newLex.add(line.strip())
    lex_conn.close()
    
    return newLex

def run(path):        
    poscount={}     
    positiveLex=loadLexicon('positive-words.txt')
    fileinput=open(path) 
    
    for line in fileinput:
        wordreader=set(line.lower().strip().split(' '))
     
        for word in wordreader: 
            if word in positiveLex:
               if word in poscount:
                  poscount[word]=poscount[word]+1
               else:
                   poscount[word]=1
    
    return poscount                               

if __name__ == "__main__":
    poscount=run('textfile')
print(poscount)