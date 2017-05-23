####helper function to look at percent of missing data per row in data frame 

percentNA <- function(df){
  fun1 <- function(x){sum(is.na(x))/length(x)*100}
  results <- data.frame(percent_missing = round(apply(df, 1, fun1), digits = 2))
  return(results)
}

##example data frame
set.seed(1234)
df1 <- data.frame(x = sample(x = 1:25, size = 10, replace = T), 
                 y = sample(x = c(1:10, NA, NA), size = 10, replace = T),
                 z = sample(x = c(30:35, NA, NA), size = 10, replace = T))
df1

##results
percentNA(df1)

##results added to original dataframe 
df1$percent_missing <- percentNA(df1)
df1
