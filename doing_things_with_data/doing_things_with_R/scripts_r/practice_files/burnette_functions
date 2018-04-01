set.seed(1234)
test_df <- data.frame(
  race = factor(x = sample(x = 1:2, size = 20, replace = T, prob = c(.8, .2)),
                labels = c("White","Black")),
  score = sample(x = seq.int(from = 3.0, to = 5.0, by = 0.1), size = 20, replace = T)
)

test_df2 <- test_df[1:5,]
test_df2

set.seed(1234)
test_df3 <- data.frame(
  race = factor(x = sample(x = 1:4, size = 1000, replace = T, prob = c(.6, .1, .2, .1)),
                labels = c("White","Black", "Hispanic", "Asian")),
  score = sample(x = seq.int(from = 3.0, to = 5.0, by = 0.1), size = 1000, replace = T)
)

summary(test_df3)

burnette_bvr_function <- function(target_group, comparison_group, grouping_variable, scoring_variable, data){
  setClass("burnette", slots = c(rank_table = "data.frame", rank_biserial_correlation = "numeric", u_value = "ANY"))
  
  
  data <- data[grep(pattern = paste(target_group, comparison_group, sep = "|"),
                    x = data[,grouping_variable]),]
  
  result <- data.frame(win = 0, tie = 0, loss = 0)
  
  for(t in which(data[,grouping_variable] == target_group)){
    for(g in 1:length(data[,grouping_variable])){
      if(data[,grouping_variable][t] != data[,grouping_variable][g]){
        if(data[,scoring_variable][t] > data[,scoring_variable][g]){
          result$win <- result$win + 1
        }
        if(data[,scoring_variable][t] == data[,scoring_variable][g]){
          result$tie <- result$tie + 1
        }
        if(data[,scoring_variable][t] < data[,scoring_variable][g]){
          result$loss <- result$loss + 1
        }
      }
    }
  }
  
  result <- rbind(result, round(prop.table(result), digits = 3)*100)
  row.names(result) <- c("Rank Sums", "Common Language Effect Size")
  
  rank_biserial_correlation <- (result["Common Language Effect Size","win"]-result["Common Language Effect Size","loss"])/100
  u_value <- wilcox.test(x = data[grep(pattern = target_group, x = data[,grouping_variable]),scoring_variable],
                         y = data[grep(pattern = comparison_group, x = data[,grouping_variable]), scoring_variable])
  
  out <- new("burnette", rank_table = result, rank_biserial_correlation = rank_biserial_correlation, u_value = u_value)
  
  return(out)
}


x <- burnette_bvr_function(target_group = "Black", 
                      comparison_group = "White", 
                      grouping_variable = "race", scoring_variable = "score", data = test_df3)

x

y <- burnette_bvr_function(target_group = "Black", 
                           comparison_group = "White", 
                           grouping_variable = "race", 
                           scoring_variable = "score", 
                           data = test_df)

y

z <- burnette_bvr_function(target_group = "Asian", 
                           comparison_group = "White", 
                           grouping_variable = "race", 
                           scoring_variable = "score",
                           data = test_df3)
z


