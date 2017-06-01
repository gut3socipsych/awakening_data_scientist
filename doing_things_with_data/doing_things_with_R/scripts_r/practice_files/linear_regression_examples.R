####linear regression examples####

####libraries####
##datasets 
library(MASS);library(ISLR)


####slr examples####
###Boston data from MASS package as worked in ISLR book 

fit_boston1 <- lm(medv~lstat, data = Boston)
summary(fit_boston1)
names(fit_boston1)
confint(fit_boston1)
predict(fit_boston1, data.frame(lstat = c(5,10,15)), interval = "c")
predict(fit_boston1, data.frame(lstat = c(5,10,15)), interval = "p")

plot(medv~lstat, data = Boston)
abline(fit_boston1, col = "red")
