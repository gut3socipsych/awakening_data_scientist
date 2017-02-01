##various arugment options for user-defined functions 

#function with no arguments 
basic_funct <- function(){
  return(4 * 4)
}

basic_funct()

#function with argument(s) requiring input from the call 
power_funct1 <- function(x){
  return(x * x)
}

power_funct1(x = 4)

power_funct2 <- function(x, power){
  result <- x * power
  return(result)
}

power_funct2(x = 4, power = 4)

#function with default argument(s) that can be altered 
power_funct3 <- function(x, power = 2){
  result <- x * power
  return(result)
}

power_funct3(x = 4)
power_funct3(x = 4, power = 4)

#function with unknown argument inputs of the same class (e.g. numeric)
arg_funct1 <- function(...){
  num = c(...)
  results <- 0 
  for(n in num){
    results = results + n
  }
  return(results)
}

arg_funct1(1, 4, 10, 5)

#function with unknown argument inputs of different classes (e.g. numeric and character)
arg_funct2 <- function(...){
  arg_list <- list(...)
  nums <- 0
  chr <- ""
  for(a in arg_list){
    if(is.numeric(a)==T){
      nums <- nums + a
    }
    if(is.character(a)==T){
      chr <- paste(chr, a, sep = " ")
    }
  }
  return(paste(chr, "scored", nums, sep = " "))
}

arg_funct2("Bobby", 3, 4, "Smith", 13)











