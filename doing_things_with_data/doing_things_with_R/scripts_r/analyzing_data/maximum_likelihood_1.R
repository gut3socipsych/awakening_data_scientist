library(ggplot2)

############maximum likelihood 
lk_1 <- function(diff_level, trait_level, responses){
  r1 <- exp(trait_level-diff_level)/(1 + exp(trait_level-diff_level))
  item_results <- data.frame()
  for(i in 1:length(responses)){
    if(responses[i] == 1){
      item_results <- append(x = item_results, values = r1[i])
    }else{
      item_results <- append(x = item_results, values = 1 - r1[i])
    }
  }
  results <- list(item_results = data.frame(lk = unlist(item_results)),
                  trait_results = prod(unlist(item_results)))
  return(results)
}

####
d <- c(-2,-1,0,1,2)
resp_pattern1 <- data.frame(p1 = c(1,1,1,1,0),
                            p2 = c(1,1,0,1,0),
                            p3 = c(1,0,0,0,0), 
                            p4 = c(1,1,1,0,1))
trait_lvl <- seq(from = -3.5, to = 7, by = .5)
likh_pattern1 <- NULL
for(r in colnames(resp_pattern1)){
  for(t in trait_lvl){
    likh_pattern1 <- append(likh_pattern1, lk_1(diff_level = d, trait_level = t, responses = resp_pattern1[,r])$trait_results)
  }
}
likh_pattern1 <- data.frame(matrix(data = likh_pattern1, nrow = length(trait_lvl), byrow = F))
colnames(likh_pattern1) <- colnames(resp_pattern1)
likh_pattern1
####

ggplot(data = likh_pattern1, aes(x = trait_lvl)) + 
  geom_point(aes(y = p1), col = "red") + geom_line(aes(y = p1), col = "red") + 
  geom_vline(xintercept = trait_lvl[grep(max(likh_pattern1$p1), likh_pattern1$p1)]) +
  geom_point(aes(y = p2), col = "blue") + geom_line(aes(y = p2), col = "blue") +
  geom_vline(xintercept = trait_lvl[grep(max(likh_pattern1$p2), likh_pattern1$p2)]) +
  geom_point(aes(y = p3), col = "green") + geom_line(aes(y = p3), col = "green") +
  geom_vline(xintercept = trait_lvl[grep(max(likh_pattern1$p3), likh_pattern1$p3)]) +
  geom_point(aes(y = p4), col = "black") + geom_line(aes(y = p4), col = "black") + 
  geom_vline(xintercept = trait_lvl[grep(max(likh_pattern1$p4), likh_pattern1$p4)]) +
  scale_x_continuous(breaks = trait_lvl) + 
  labs(x = "Trait Level", y = "Response Pattern Likelihood")

