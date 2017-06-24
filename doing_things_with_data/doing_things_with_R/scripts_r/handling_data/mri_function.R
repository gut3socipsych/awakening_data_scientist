####multiple response item function####
mri <- function(data, combined_variable_name = "combined_variable"){
  #require gtools#
  require(gtools)
  
  #function objects#
  colnum <- length(colnames(data))
  
  #categorize choices#
  choice_perm <- permutations(n = colnum, r = colnum, repeats.allowed = T)
  choice_cats <- list(code = NULL, name = NULL)
  for(n in 1:colnum){
    for(p in 1:nrow(choice_perm)){
      choice_base <- rep(x = "0", times = colnum)
      choice_base[choice_perm[p,]] <- "1"
      choice_cats$code <- append(choice_cats$code, paste(choice_base, collapse = ""))
      choice_cats$name <- append(choice_cats$name, list(sort(colnames(data)[ps[p,]])))
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
  
  data$response_factor <- response_factor
  colnames(data)[length(colnames(data))] <- combined_variable_name
  return(data)
}

