####simple linear regression (manual calculations)####

###data 
set.seed(1) #set seed for reproducibility 
x <- sample(x = 1:25, size = 10, replace = T) #predictor values 
y <- x + sample(x = 1:10, size = 10, replace = T) #outcome values 
df <- data.frame(x, y)
rm(x, y) #just cleaning up 
df

###central tendency and variability statistic calculations 
##mean values for predictor and outcome variables
x_mean <- mean(df$x)
y_mean <- mean(df$y)

##deviance scores 
df$x_dev <- df$x - x_mean #x deviance scores 
df$y_dev <- df$y - y_mean #y deviance scores 
df$x_dev2 <- df$x_dev^2 #x deviance scores sqaured 
df$y_dev2 <- df$y_dev^2 #y deviance scores sqaured
df$xy_dev <- df$x_dev * df$y_dev #product of x deviance and y deviance scores 

#plots of deviation scores #########
#helper function 
dev_plot <- function(variable, plot_title = "Deviation from the Mean"){
  variable_length <- length(variable)
  variable_mean <- mean(variable, na.rm = T)
  variable_dev <- variable - variable_mean 
  
  plot(variable, main = plot_title, xlab = "Observation", ylab = "Values")
  axis(side = 1, at = 1:variable_length)
  abline(h = variable_mean)
  segments(x0 = 1:variable_length, y0 = variable, x1 = 1:variable_length, y1 = variable_mean, col = "red")
  lab_pos <- vector()
  for(i in 1:variable_length){
    if(variable[i] < variable_mean){
      lab_pos <- append(x = lab_pos, values = variable_mean + 3)
    }else{
      lab_pos <- append(x = lab_pos, values = variable_mean - 3)
    }
  }
  text(x = 1:variable_length, y = lab_pos, labels = round(variable_dev, digits = 1), cex = .75, col = "red")
}

plot(y~x, data = df); axis(side = 1, at = 1:max(df$x))
dev_plot(df$x) #deviation from mean x values 
dev_plot(df$y) #deviation from mean y values 

######

###estimating the coefficients 
b1 <- sum(df$xy_dev)/sum(df$x_dev2)
b0 <- y_mean - (b1 * x_mean)

###evaluating the model 
##predicted values and error  
df$y_pred <- b0 + (b1 * df$x) #predicted values based on the estimated coefficients 
df$residuals <- df$y - df$y_pred #residuals: difference between the observed outcome scores and the predicted values 
df$residuals2 <- df$residuals^2 #residuals sqaured 
df$model_error <- df$y_pred - y_mean #model error 
df$model_error2 <- df$model_error^2 #model error sqaured 

##overall model fit 
rss <- sum(df$residuals2) #residual sum of sqaures 
mss <- sum(df$model_error2) #model sum of sqaures 
tss <- rss + mss #total sum of sqaures; or sum(df$y_dev2), the summ of sqaured outcome deviation scores 
rse <- sqrt(rss/(length(df$y)-2)) #residual standard error 
r_sq <- (tss - rss)/tss #r-squared value 

b0_se <- rse * sqrt((1/length(df$x)) + (x_mean^2/sum(df$x_dev2))) #standard error of the intercept
b1_se <- rse/sqrt(sum(df$x_dev2)) #standard error of the slope 

f <- (mss/1)/(rss/(length(df$x)-2)) #f-statistic 
#with simple linear regressions the f-statistic can be found by squaring the t-statistic
f_pval <- pf(q = f, df1 = 1, df2 = length(df$x)-2, lower.tail = F)

###assessing predictive value
b0_t <- (b0 - 0)/b0_se
b0_t_pval <- 2 * pt(-abs(b0_t), df = length(df$x)-2)
b1_t <- (b1 - 0)/b1_se
b1_t_pval <- 2 * pt(-abs(b1_t), df = length(df$x)-2)

#predicted outcome based on new predictor value (e.g. 12)
new_y1 <- b0 + (b1 * 12)


