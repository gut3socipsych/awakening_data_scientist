##helper functions for working with LIWC output csv files

fb_post_liwc <- function(file, stop_column){
  data <- read.csv(file = file, header = T, stringsAsFactors = F) 
  colnames(data)[1:which(colnames(data)==stop_column)-1] <- data[1,1:which(colnames(data)==stop_column)-1]
  data <- data[-1,]
  data$created_time <- as.Date(data$created_time)
  data$type <- as.factor(data$type)
  for(i in grep(pattern = "_count", colnames(data))){
    data[,colnames(data[i])] <- as.numeric(data[,colnames(data[i])])
  }
  return(data)
}


