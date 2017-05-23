####EFA lesson via http://statstools.com/

###libraries
library(psych);library(GPArotation)
###read in data from website
data_url <- "http://statstools.com/wordpress/wp-content/uploads/2015/09/b-efa.csv"
efa_df <- read.csv(file = data_url)

###data screening 
##explore data
View(efa_df)
str(efa_df)
describe(efa_df)

##check missingness
#helper function 
percentNA <- function(df){
  fun1 <- function(x){sum(is.na(x))/length(x)*100}
  results <- data.frame(percent_missing = round(apply(df, 1, fun1), digits = 2))
  return(results)
}
table(percentNA(efa_df))

##omit NA cases 
efa_df_clean <- na.omit(efa_df)
table(percentNA(efa_df_clean))

##drop condition variable 
efa_df_clean <- efa_df_clean[,-grep(pattern = "condition", colnames(efa_df_clean))]
str(efa_df_clean)

###efa 
##1 number of factors 
##scree and parallel analysis 
para <- fa.parallel(efa_df_clean, fm = "ml", fa = "fa") #scree plot indicates 2; parallel indicates 5 
##eigen values (over 1 is 2 factors, over .7 is three factors)
para$fa.values
length(para$fa.values[para$fa.values>1])
length(para$fa.values[para$fa.values>.7])

##2 simple structure 
twofactor <- fa(efa_df_clean, nfactors = 2, rotate = "oblimin", fm = "ml")
twofactor #look for loading .3 on factors

twofactor2 <- fa(efa_df_clean[,-c(3,11,15,16)], nfactors = 2, rotate = "oblimin", fm = "ml")
twofactor2 #one and only one loading = simple structure 
#cfi 
1 - ((twofactor2$STATISTIC - twofactor2$dof)/(twofactor2$null.chisq - twofactor2$null.dof))

##3 reliability 
alpha(efa_df_clean[,c(1,2,14,14,18)], check.keys = T) #factor 1 .87
alpha(efa_df_clean[,c(4,5,6,7,8,9,10,13,17,19,20)], check.keys = T) #factor 2 .82

