###screening data for sem 
str(mtcars)
car_red <- mtcars[,c("mpg","hp","wt","qsec")]

mah <- mahalanobis(x = car_red, center = colMeans(car_red), cov = cov(car_red))
cutoff <- qchisq(p = 1-.001, df = ncol(car_red))
mah;cutoff

table(mah < cutoff)

##additivity 
car_cor <- cor(car_red)
car_cor
symnum(car_cor)

##assumption set up 
random <- rchisq(nrow(car_red), df = 7)
fake <- lm(random~., data = car_red)
standardize <- rstudent(fake)
fitted <- fake$fitted.values

#normality 
hist(standardize,breaks = 11)

#linearity 
qqnorm(standardize)
abline(0,1, col = "red")

#homegeneity and homoscedasticity 
plot(scale(fitted), standardize)
abline(h = 0, v = 0)
