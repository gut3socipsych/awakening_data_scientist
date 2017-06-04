####linear regression examples####

####libraries####
##datasets 
library(MASS);library(ISLR)


####slr examples####
###Boston data from MASS package as worked in ISLR book 
##model fit
fit_boston1 <- lm(medv~lstat, data = Boston)
##summary
summary(fit_boston1)
##inference
confint(fit_boston1)
predict(fit_boston1, data.frame(lstat = c(5,10,15)), interval = "c")
predict(fit_boston1, data.frame(lstat = c(5,10,15)), interval = "p")
##plots 
#variable plot 
plot(medv~lstat, data = Boston)
abline(fit_boston1, col = "red")
#diagonostic plots 
par(mfrow = c(2,2))
plot(fit_boston1)
par(mfrow = c(1,1))
#diagnotics plot manual 
par(mfrow = c(2,2))
#residuals v fitted 
plot(fit_boston1$residuals~fit_boston1$fitted.values, xlab = "Fitted Values", ylab = "Residuals", main = "Residuals vs Fitted")
abline(h = 0, lty = "dashed")
lines(lowess(fit_boston1$fitted.values, fit_boston1$residuals), col = "red")
#normal q-q
qqnorm(rstudent(fit_boston1))
qqline(rstudent(fit_boston1), lty = "dashed")
#scale-location 
plot(rstudent(fit_boston1)~fit_boston1$fitted.values, xlab = "Fitted Values", ylab = "Standardized Residuals", main = "Scale-Location")
lines(lowess(fit_boston1$fitted.values, rstudent(fit_boston1)), col = "red")
#residuals v leverage 
plot(rstudent(fit_boston1)~hatvalues(fit_boston1), xlab = "Leverage", ylab = "Standardized Residuals", main = "Residuals vs Leverage")
abline(h = 0, lty = "dashed")
lines(lowess(hatvalues(fit_boston1), rstudent(fit_boston1)), col = "red")
par(mfrow = c(1,1))

