####multiple response item function####
###select one option 
mri_selectone <- function(data, response_labels = colnames(data), combined_variable_name = "new"){
  data[data!=1] <- NA 
  colnames(data) <- response_labels 
  data$new <- colnames(data)[max.col(!is.na(data))]
  colnames(data)[length(data)] <- combined_variable_name
  return(data[length(data)])
}

###select all that apply option 
selectall <- function(data){
  #inner functions
  f1 <- function(x){
    out <- NULL
    for(i in 1:length(x)){
      if(x[i] == 1){
        out <- append(x = out, values = colnames(x[i]))
      }else{
        out <- append(x = out, values = "")
      }
    }
    out <- paste(out, collapse = " ")
    return(out)
  }
  #remove na
  data[is.na(data)] <- 0
  #convert all non-1 values to 0
  data[data != 1] <- 0
  #for loop 
  results <- vector()
  for(r in 1:nrow(data)){
    results <- append(x = results, values = f1(data[r,]))
  }
  #convert to dataframe
  results <- data.frame(results, stringsAsFactors = F)
  #replace blank cells with NA
  results[-grep("[a-z]", results$results),] <- NA
  return(results)
}

###create divided ranges and convert to factor variable 
group_and_factor <- function(variable, b = 2){
  cut_var <- cut(x = variable, breaks = b, ordered_result = T) 
  cut_levels <- levels(cut_var)
  cut_labels <- vector()
  for(i in 1:length(cut_levels)){
    cut_labels <- append(x = cut_labels, 
                         values = paste(as.numeric(unlist(strsplit(gsub(x = cut_levels[i], pattern = "[(]|[]]", replacement = ""), split = ","))), collapse = " to "))
  }
  levels(cut_var) <- cut_labels
  return(cut_var)
}

###create factor variable from progressive yes/no (binary) responses 
mri_series <- function(data, response_labels){
  #process data# 
  data[data!=1] <- 2 
  colnames(data) <- response_labels
  #results 
  results <- vector()
  for(r in 1:nrow(data)){
    results <- append(x = results, values = colnames(data)[which.max(data[r,])])
  }
  return(results)
}
