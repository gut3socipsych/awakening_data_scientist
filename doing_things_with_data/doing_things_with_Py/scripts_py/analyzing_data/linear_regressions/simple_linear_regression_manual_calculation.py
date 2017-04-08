####simple linear regression manual calculations####

###data
x = [7,10,15,23,6,23,24,17,16,2]
y = [10,12,22,27,14,28,32,27,20,10]

###descriptive statistic calculations
##mean values for predictor and outcome variables 
x_mean = sum(x)/len(x)
y_mean = sum(y)/len(y)

##deviation scores
#x deviation scores
x_dev = [i - x_mean for i in x]
#y deviation scores
y_dev = [i - y_mean for i in y]
#x deviation scores squared
x_dev2 = [i**2 for i in x_dev]
#y deviation scores squared
y_dev2 = [i**2 for i in y_dev]
#product of x deviation and y deviation scores
xy_dev = [xvalue * y_dev[num] for num, xvalue in enumerate(x_dev)]

###estimating the coefficients
#slope
b1 = sum(xy_dev)/sum(x_dev2)
#intercept
b0 = y_mean - (b1 * x_mean)


###evaluating the model
##predicted values and error
#predicted values based on the estimated coefficients
y_pred = [b0 + (b1 * i) for i in x] 
#residuals: difference between the observed outcome scores and the predicted values
residuals = [yvalue - y_pred[num] for num, yvalue in enumerate(y)]
#residuals sqaured 
residuals2 = [i ** 2 for i in residuals]
#model error
model_error = [i - y_mean for i in y_pred]
#model error sqaured
model_error2 = [i ** 2 for i in model_error] 

##overall model fit
#residual sum of squares
rss = sum(residuals2)
#model sum of squares
mss = sum(model_error2)
#total sum of squares
tss = rss + mss
#residual standard error
rse = (rss/(len(y)-2)) ** (1/2.0)
#r-squared value
r_sq = (tss - rss)/tss
#standard error of intercept and slope 
b0_se = rse * (((1/len(x)) + (x_mean**2/sum(x_dev2))) ** (1/2.0))
b1_se = rse/((sum(x_dev2) ** (1/2.0)))
#f-statistic
f = (mss/1)/(rss/(len(x)-2))
#with simiple linear regressions the f-statistic can be found by squaring the t-statistic for the slope

####assessing predictive value
b0_t = (b0 - 0)/b0_se
b1_t = (b1 - 0)/b1_se


#predicted outcome based on new predictor value (e.g. 12)
new_y1 = b0 + (b1 * 12)
