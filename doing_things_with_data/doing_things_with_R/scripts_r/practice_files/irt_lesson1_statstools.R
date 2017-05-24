####irt analyses via statstools.com 
library(ltm);library(psych)

####read-in data 
data_url <- "http://statstools.com/wordpress/wp-content/uploads/2015/09/m-IRT-exam.csv"
irt_df <- read.csv(data_url, header = F) #no header 
View(irt_df)

irt_df1 <- irt_df[,2:5] #reduce dataset for example

####explore data
describe(irt_df1)


####2PL model 
mod_2pl <- ltm(irt_df1 ~ z1, IRT.param = T)
coef(mod_2pl)
#item characteristic curve
plot(mod_2pl, type = "ICC")
abline(.5, 0)
#item information curve 
plot(mod_2pl, type = "IIC")
#test information curve 
plot(mod_2pl, type = "IIC", items = 0)
#factor scores 
factor.scores.ltm(mod_2pl)
#person fit 
person.fit(mod_2pl)
#item fit 
item.fit(mod_2pl)

###3PL model with guessing parameter
mod_3pl <- tpm(data = irt_df1, type = "latent.trait", IRT.param = T)
coef(mod_3pl) ## guessing parameter closer to 0 indicates it is NOT easy to guess without knowledge of the question 
#item characteristic curves 
plot(mod_3pl, type = "ICC")
abline(.5, 0)
#item information curves 
plot(mod_3pl, type = "IIC")
#test information curve 
plot(mod_3pl, type = "IIC", items = 0)
#factor scores 
factor.scores.tpm(mod_3pl)
#person fit 
person.fit(mod_3pl)
#item fit 
item.fit(mod_3pl)

###compare models 
anova(mod_2pl, mod_3pl) #look at AIC
