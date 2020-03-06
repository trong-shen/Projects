# -*- coding: utf-8 -*-
"""
This is for Trong's Data Science Project
"""

"""
loading the data
"""

import pandas as pd
import math
data=pd.read_csv(r'C:\Users\trong\Desktop\Final Challenge\2014 Indictors\Normalized Data.csv')
column_titles=data.columns;

for col in column_titles:
    if col !='Neighbourhood':
        data[col]=pd.to_numeric(data[col], downcast='float')

R={};
for x in column_titles:
    for y in column_titles:
        pair=x+'-'+y;
        trans_pair=y+'-'+x;
        if (x in y) | (x in 'Neighbourhood Id') | (y in 'Neighbourhood Id')|(x in 'Neighbourhood') | (y in 'Neighbourhood'):
            continue
        elif pair in R:
            continue
        elif trans_pair in R:
            continue
        else:
            '''Calculate R Between All Combinations'''     
            data_pair=data[[x,y]]
            correlation=data_pair.corr(method='pearson')
            corr=correlation.iloc[0,1]
            R.update({pair:corr})
weak_corr={};
strong_corr={};
no_corr={};

for key in R.keys():
    if abs(R[key])>=0.7:
        strong_corr.update({key:R[key]})
    elif abs(R[key])>=0.3:
        weak_corr.update({key:R[key]})
    else:
        no_corr.update({key:R[key]}) 
        
print(len(strong_corr))
print(len(weak_corr))
print(len(no_corr))


