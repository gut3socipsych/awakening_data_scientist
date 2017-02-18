####simple linear regression manual calculations####

###data
x = [7,10,15,23,6,23,24,17,16,2]
y = [10,12,22,27,14,28,32,27,20,10]

###descriptive statistic calculations
##mean values for predictor and outcome variables 
x_mean = sum(x)/len(x)
y_mean = sum(y)/len(y)

##deviance scores
#x deviance scores
x_dev = []
for i in x: x_dev += [i - x_mean]
#y deviance scores
y_dev = []
for i in y: y_dev += [i - y_mean]
#x deviance scores squared
x_dev2 = []
for i in x_dev: x_dev2 += [i**2]
#y deviance scores squared
y_dev2 = []
for i in y_dev: y_dev2 += [i**2]
#product of x deviance and y deviance scores
xy_dev = []
for i in range(0, len(x_dev)): xy_dev += [x_dev[i] * y_dev[i]]


###estimating the coefficients
#slope
b1 = sum(xy_dev)/sum(x_dev2)
#intercept
b0 = y_mean - (b1 * x_mean)


###evaluating the model
##predicted values and error
#predicted values based on the estimated coefficients
y_pred = []
for i in x: y_pred += [b0 + (b1 * i)]
#residuals: difference between the observed outcome scores and the predicted values
residuals = []
for i in range(0, len(y)): residuals += [y[i] - y_pred[i]]
#residuals sqaured 
residuals2 = []
for i in residuals: residuals2 += [i ** 2]
#model error
model_error = []
for i in y_pred: model_error += [i - y_mean]
#model error sqaured
model_error2 = []
for i in model_error: model_error2 += [i ** 2]

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

b0_se = rse * (((1/len(x)) + (x_mean**2/sum(x_dev2))) ** (1/2.0))
b1_se = rse/((sum(x_dev2) ** (1/2.0)))


####assessing predictive value
b0_t = (b0 - 0)/b0_se
b1_t = (b1 - 0)/b1_se


