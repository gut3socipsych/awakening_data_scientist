####helper functions for working with youtube transcripts####

###clean_and_save()
#the clean_and_save function reads, removes html elements but leaves the time index and text information 
#then saves a new clean file for a single file or folder of html code copied 
#from a youtube transcript scroll box and saved in a text file 

clean_and_save <- function(raw_file_path, clean_file_path){
  require(qdap)
  if(file.info(raw_file_path)$isdir == TRUE){
    for(f in list.files(raw_file_path)){
      text <- paste(readLines(paste(raw_file_path, f, sep = "/")), collapse = " ")
      text <- bracketX(text)
      temp_name <- sub(pattern = "_raw.txt", replacement = "_clean.txt", x = f)
      write(x = text, file = paste(clean_file_path, temp_name, sep = "/"))
    }
  }
  if(file.info(raw_file_path)$isdir == FALSE){
    text <- paste(readLines(raw_file_path), collapse = " ")
    text <- bracketX(text)
    write(x = text, file = clean_file_path)
  }
}

###speech_extract()
#takes cleaned (see save_and_clean) file or directory of files and 
#searches for desired key word(s), when file contains key word(s)
#returns a list of extracted passages where key word(s) found 

speech_extract <- function(input, key_word){
  #setClass(Class = "transcript miner", slots = c(segment_scrape = "ANY"))
  require(tm);require(stringr)
  key_word <- paste(key_word, collapse = "|")
  list1 <- list()
  list_names <- vector()
  if(file.info(input)$isdir == TRUE){
    for(f in list.files(input)){
      temp1 <- readLines(paste(input, f, sep = "/"))
      if(grepl(pattern = key_word, temp1) == TRUE){
        list_names <- append(list_names, f)
        time <- data.frame(str_extract_all(string = temp1, pattern = "[0-9]{1,2}:[0-9]{2}"), 
                           stringsAsFactors = F)
        colnames(time) <- "time"
        text <- data.frame(strsplit(x = temp1, split = "[0-9]{1,2}:[0-9]{1,2}"), 
                           stringsAsFactors = F)
        colnames(text) <- "text"
        if(length(time$time) < length(text$text)){
          time2 <- data.frame(time = rep(NA, abs(length(time$time)-length(text$text))))
          time <- rbind(time, time2)
        }
        if(length(time$time) > length(text$text)){
          text2 <- data.frame(text = rep(NA, abs(length(time$time)-length(text$text))))
          text <- rbind(text, text2)
        }
        df1 <- cbind(time, text)
        list1 <- append(list1, list(df1))
      }
    }
  }
  if(file.info(input)$isdir == FALSE){
    temp1 <- readLines(input)
    if(grepl(pattern = key_word, temp1) == TRUE){
      list_names
      time <- data.frame(str_extract_all(string = temp1, pattern = "[0-9]{1,2}:[0-9]{2}"),
                         stringsAsFactors = F)
      colnames(time) <- "time"
      text <- data.frame(strsplit(x = temp1, split = "[0-9]{1,2}:[0-9]{1,2}"), 
                         stringsAsFactors = F)
      colnames(text) <- "text"
      if(length(time$time) < length(text$text)){
        time2 <- data.frame(time = rep(NA, abs(length(time$time)-length(text$text))))
        time <- rbind(time, time2)
      }
      if(length(time$time) > length(text$text)){
        text2 <- data.frame(text = rep(NA, abs(length(time$time)-length(text$text))))
        text <- rbind(text, text2)
      }
      df1 <- cbind(time, text)
      list1 <- append(list1, list(df1))
    }
  }
  list2 <- list()
  for(i in 1:length(list1)){
    list2 <- append(list2, list(list1[[i]][grep(key_word, list1[[i]]$text),]))
  }
  names(list2) <- list_names
  #return(new("transcript miner", segment_scrape = list2))
  return(list2)
  
}
