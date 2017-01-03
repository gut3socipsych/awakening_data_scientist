dir("../example_datasets")

test <- "../example_datasets/cog_data_1.csv"
test2 <- "../example_datasets"

a <- TRUE
a

paste("This a test", a)

check_file <- function(item){
  if(file.exists(item)==T){
    e = paste("The item", item, "does exist and is a file.")
  }
  if(dir.exists(item)==T){
    e = paste("The item", item, "does exist and is a directory.")
  }
  else{
    e = paste("The item", item, "does NOT exist")
  }
  return(e)
}

check_file <- function(item){
  if(file.exists(item)==T){
    e = paste("The item", item, "exists and is a file")
  }
  if(dir.exists(item)==T){
    e = paste("The item", item, "exists and is a directory")
  }
  else{
    e = paste("The item", item, "does NOT exist")
  }
  return(e)
}

check_file(test)
check_file(test2)
check_file("test.txt")

for(i in list.files("../example_datasets")){
  print(check_file(i))
}
