####simple linear regression simple example####

###data 
set.seed(1) #set seed for reproducibility 
x <- sample(x = 1:25, size = 10, replace = T) #predictor values 
y <- x + sample(x = 1:10, size = 10, replace = T) #outcome values 
df <- data.frame(x, y)
rm(x, y) #just cleaning up 
df

###fitting the model 
fit1 <- lm(y ~ x, data = df) 
summary(fit1)

