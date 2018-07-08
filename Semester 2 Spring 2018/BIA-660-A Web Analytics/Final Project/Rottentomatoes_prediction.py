
# coding: utf-8

# # Web Analytics - BIA 660 Final Project

# ## Rottentomatoes - Movie Rating Regression Model

# #### Abhitej Kodali, Amit Kumar, Balaji Katakam, Sameul Mathews, Ugandhar

#  

# In[243]:


import pandas as pd
import IPython.display as ipd
import re, os, keras
import numpy as np
from datetime import datetime
import matplotlib.pyplot as plt
import seaborn as sb
from pandas.tseries.holiday import USFederalHolidayCalendar as calendar
from keras.models import Sequential
from keras.layers import Dense, Dropout
from keras.wrappers.scikit_learn import KerasRegressor
from keras import optimizers
from keras.callbacks import TensorBoard
from keras.models import model_from_json
from sklearn.model_selection import cross_val_score, KFold
from sklearn.preprocessing import StandardScaler, MinMaxScaler
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import chi2
from sklearn.pipeline import Pipeline
from sklearn.cross_validation import train_test_split
from sklearn import metrics
import codecs
from sklearn.decomposition import PCA

pd.set_option('display.max_columns', 50)


#  

# ###### Loading the File..

# In[270]:


doc = codecs.open('rotten.txt','rU','UTF-8') #open for reading with "universal" type set

movie_list = pd.read_csv(doc,sep='\t')
df = movie_list
ipd.display(df.head())


# ###### Data Cleaning..

# In[274]:


#Cleaning
df['In Theaters'] = df['In Theaters'].str.replace("wide","").str.replace(",","").str.replace("limited","").str.replace("Wide","").str.replace("\xa0","")
df['Runtime'] = pd.to_numeric(df['Runtime'].map(lambda x: str(x)[:-8]))
df['Rating'] = df['Rating'].map(lambda x: str(x).split()[0])
df['critic_score'] = df['critic_score'].str.replace("%","").astype(np.float)
df['audience_score'] = df['audience_score'].str.replace("%","").astype(np.float)
df['In Theaters'] = pd.to_datetime(df['In Theaters'],format="%b %d %Y",errors='ignore')

ipd.display(df.head())


#  

# ###### New Features are created..

# In[279]:


#Holidays
cal = calendar()
holidays = cal.holidays(start=df['In Theaters'].min(), end=df['In Theaters'].max())
df['Holiday'] = df['In Theaters'].isin(holidays)
df['Holiday'] = df['Holiday'].astype('int')

#Label
df['label'] = df['critic_score'].astype(int) - df['audience_score'].astype(int)

#Genres to columns
g = pd.Series(df['Genre'])
g1 = []
    
for i in range(len(g)):
    g3 = str(g[i]).split(', ')
    for g4 in g3:
        g1.append(str(g4).strip())
    
g5 = sorted(set(g1))
    
for i in range(len(g5)):
    if g5[i]!='NaN':
        df[g5[i]]=0
    
for i in range(len(g)):
    g3 = str(g[i]).split(', ')
    for g4 in g3:
        g6 = str(g4).strip()
        if g6 in df.columns:
            df.set_value(i,g6,1)

ipd.display(df.head())


# In[276]:


def compute_rating(rating):
    if rating == 'R':
        return 26.91

    if rating == 'NR':
        return 0.82

    if rating == 'PG-13':
        return 47.77  

    if rating == 'PG':
        return 20.18

    if rating == 'G':
        return 4.28

    if rating == 'NC17':
        return 0.02

# Assingning values based on Genre of the movie
# https://www.statista.com/statistics/188658/movie-genres-in-north-america-by-box-office-revenue-since-1995/
def Action_Adventure(a):
    if a == 1:
        return 60

def Comedy(b):
    if b == 1:
        return 32
    
def Documentary(c):
    if c == 1:
        return 2  
    
def Drama(d):
    if d == 1:
        return 35
    
def Horror(e):
    if e == 1:
        return 10
    
def Musical_Arts(f):
    if f == 1:
        return 4
    
def Mystery_Suspense(g):
    if g == 1:
        return 18
    
def Romance(h):
    if h == 1:
        return 10
    
def Western(i):
    if i == 1:
        return 1


# In[280]:


#Features around Critic Ratings and Audience Ratings for Director, Studio and Actors
df['Movie_rating_value']=df['Rating'].apply(compute_rating)

df['AA_Genre_Value']=df['Action & Adventure'].apply(Action_Adventure)

df['Com_Genre_Value']=df['Comedy'].apply(Comedy)
df['Doc_Genre_Value']=df['Documentary'].apply(Documentary)
df['Dra_Genre_Value']=df['Drama'].apply(Drama)
df['Horr_Genre_Value']=df['Horror'].apply(Horror)
df['Mus_Genre_Value']=df['Musical & Performing Arts'].apply(Musical_Arts)
df['Mys_Genre_Value']=df['Mystery & Suspense'].apply(Mystery_Suspense)
df['Rom_Genre_Value']=df['Romance'].apply(Romance)
df['Wes_Genre_Value']=df['Western'].apply(Western)

df.sort_values('In Theaters',ascending=True)

df['Director_tomatometer'] = pd.DataFrame(df.groupby("Directed By")['critic_score'].apply(lambda x: x.shift().expanding(min_periods=1).mean()))
df['Director_popcorn'] = pd.DataFrame(df.groupby("Directed By")['audience_score'].apply(lambda x: x.shift().expanding(min_periods=1).mean()))
df['Studio_tomatometer'] = pd.DataFrame(df.groupby("Studio")['critic_score'].apply(lambda x: x.shift().expanding(min_periods=1).mean()))
df['Studio_popcorn'] = pd.DataFrame(df.groupby("Studio")['audience_score'].apply(lambda x: x.shift().expanding(min_periods=1).mean()))

ipd.display(df.head())


#  

# ###### Date Cleaning, Mining and manipulation..

# In[281]:


df.fillna(0,inplace=True)
df = df.drop(df[(df.critic_score <20) | (df.audience_score < 20)].index)
df.corr()


#  

# ###### Modeling Part..

# In[282]:


df.columns


# In[283]:


X = df[['Runtime', 'Movie_rating_value', 'Holiday', 'Animation', 'Anime & Manga', 'Art House & International', 'Classics',
       'Comedy', 'Cult Movies', 'Documentary', 'Faith & Spirituality',
       'Gay & Lesbian', 'Kids & Family', 'Science Fiction & Fantasy',
       'Special Interest', 'Sports & Fitness', 'Television', 'AA_Genre_Value', 'Com_Genre_Value', 'Doc_Genre_Value',
       'Dra_Genre_Value', 'Horr_Genre_Value', 'Mus_Genre_Value',
       'Mys_Genre_Value', 'Rom_Genre_Value', 'Wes_Genre_Value',
       'Director_tomatometer', 'Director_popcorn', 'Studio_tomatometer',
       'Studio_popcorn']]

y = df['label']


# In[284]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state=123)
X_copy = pd.DataFrame(X_test.copy())

scale = MinMaxScaler(feature_range=(0, 1))
X_train = scale.fit_transform(X_train)
X_test = scale.transform(X_test)
X_test


# In[285]:


test = SelectKBest(score_func=chi2, k=10)
fit = test.fit(X, y)
# summarize scores
np.set_printoptions(precision=3)
print(fit.scores_)
features = fit.transform(X)


# In[286]:


pca = PCA(n_components=20)
fit = pca.fit(X)


# In[289]:


def baseline_model():

    model = Sequential()
    model.add(Dense(120, input_dim=30,  activation='relu', kernel_initializer='normal', name='Layer_1'))
    model.add(Dropout(0.6))
    
    model.add(Dense(40, activation='relu', kernel_initializer='normal', name='Layer_2'))
    model.add(Dropout(0.6))
    
    
    model.add(Dense(1, kernel_initializer='normal', name='Output_Layer'))
    
    #sgd = optimizers.SGD(lr=0.001, decay=1e-6, momentum=0.9, nesterov=True)
    
    model.compile(loss='mean_squared_error', optimizer= 'Adadelta')
    return model

tensorboard = TensorBoard(log_dir='logs',write_graph=True,histogram_freq=0,write_images=False)

model = KerasRegressor(build_fn=baseline_model, epochs=150, batch_size=75,verbose=1, callbacks=[tensorboard])


# In[290]:

model.fit(X_train,y_train)
preds = model.predict(X_test)

# In[155]:

model_json = model.model.to_json()
model_json
model.model.save_weights('model_weights.h5')


# In[156]:


print('MAE:', metrics.mean_absolute_error(y_test, preds))
print('MSE:', metrics.mean_squared_error(y_test, preds))
print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, preds)))


# In[136]:

dff = pd.DataFrame()
dff['label'] = y_test
dff['Predictions'] = preds
dff['difference'] = dff['label'] - dff['Predictions']
#dff.eto_csv("results.csv")
print(dff.head(30))



