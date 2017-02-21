##helper functions for working with LIWC output csv files

fb_post_liwc <- function(file, stop_column){
  data <- read.csv(file = file, header = T, stringsAsFactors = F) #read in liwc output csv 
  colnames(data)[1:which(colnames(data)==stop_column)-1] <- data[1,1:which(colnames(data)==stop_column)-1] #adjust colnames from first row data
  data <- data[-1,] #remove first row with colname information 
  data$created_time <- as.Date(data$created_time)
  if("type" %in% colnames(data)){data$type <- as.factor(data$type)} #if a comments dataset is used there will be no "type" variable
  for(i in grep(pattern = "_count", colnames(data))){
    data[,colnames(data[i])] <- as.numeric(data[,colnames(data[i])]) #convert reaction and comment variables to numeric class
  }
  return(data)
}


