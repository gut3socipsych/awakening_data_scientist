library(ISLR)
names(Smarket)
summary(Smarket)
head(Smarket)
dim(Smarket)

cor(Smarket[,-9])
plot(Smarket$Volume)

#logistic regression 
log_fit <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data = Smarket, family = "binomial")
summary(log_fit)
contrasts(Smarket$Direction)

log_fit_probs <- predict(object = log_fit, type = "response")
log_fit_probs[1:20]

log_fit_pred <- rep("Down", 1250)
log_fit_pred[log_fit_probs > .50] <- "Up"
table(log_fit_pred)

table(log_fit_pred, Smarket$Direction)
