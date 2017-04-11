####simple linear regression simple example####
###packages/modules 
import numpy as np
import pandas as pd 
from sklearn import linear_model
import statsmodels.api as sm 

###data
x = [7,10,15,23,6,23,24,17,16,2]
y = [10,12,22,27,14,28,32,27,20,10]
#create dataframe from lists 
data_list = [("x", x), ("y", y)]
df = pd.DataFrame.from_items(data_list)

###SLR with sci-kit learn 
##create linear model object
lm = linear_model.LinearRegression()
##fit data to the model 
#df.drop removes outcome variable from the df
predictors1 = df.drop("y", axis = 1)
lm.fit(X = predictors1, y = df.y)

###SLS with statsmodel 
##add constant to x variables 
predictors2 = sm.add_constant(df.x) 
##create model object
model = sm.OLS(df.y, predictors2) 
##fit the model 
results = model.fit()
##model summary 
results.summary()

