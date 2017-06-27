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
mri_selectall <- function(data, response_labels = colnames(data), combined_variable_name = "combined_variable"){
  #require gtools#
  require(gtools)
  
  #function objects#
  data[data!=1] <- 0
  colnames(data) <- response_labels
  colnum <- length(colnames(data))
  
  #categorize choices#
  choice_perm <- permutations(n = colnum, r = colnum, repeats.allowed = T)
  choice_cats <- list(code = NULL, name = NULL)
  for(n in 1:colnum){
    for(p in 1:nrow(choice_perm)){
      choice_base <- rep(x = "0", times = colnum)
      choice_base[choice_perm[p,]] <- "1"
      choice_cats$code <- append(choice_cats$code, paste(choice_base, collapse = ""))
      choice_cats$name <- append(choice_cats$name, list(sort(colnames(data)[choice_perm[p,]])))
    }
  }
  for(choice_name in 1:length(choice_cats$name)){
    choice_cats$name[[choice_name]] <- paste(unique(choice_cats$name[[choice_name]]), collapse = " & ")
  }
  choice_cats <- data.frame(code = unique(choice_cats$code), 
                            name = unique(unlist(choice_cats$name)), stringsAsFactors = F)
  #results#
  response_code <- vector()
  for(r in 1:nrow(data)){
    choice_code <- vector()
    for(i in data[r,]){
      choice_code <- paste(append(x = choice_code, values = i), collapse = "")
    }
    response_code <- append(x = response_code, values = choice_code)
  }
  response_factor <- vector()
  for(i in 1:length(response_code)){
    response_factor <- append(x = response_factor,
                              values = choice_cats$name[which(response_code[i] == choice_cats$code)])
  }
  
  data$new <- response_factor
  colnames(data)[length(colnames(data))] <- combined_variable_name
  return(data[length(data)])
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


