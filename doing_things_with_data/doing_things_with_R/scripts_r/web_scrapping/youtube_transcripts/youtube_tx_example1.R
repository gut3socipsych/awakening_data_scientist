####youtube transcript examples 

##import helper functions from file 
source(file = "../doing_things_with_R/scripts_r/web_scrapping/youtube_transcripts/youtube_tx_functions.R")

##clean and save transcript text files copied from youtube
#path to raw data files folder 
raw_path_example <- "../example_datasets/youtube_transcript_data/youtube_transcripts_raw/youtube_trump_raw"
dir(raw_path_example)

#path to empty folder for clean files
clean_path_example <- "../example_datasets/youtube_transcript_data/youtube_transcripts_clean/youtube_trump_clean"
dir(clean_path_example)

#run clean_and_save function on raw data files 
clean_and_save(raw_file_path = raw_path_example, clean_file_path = clean_path_example)

#the following warning will be generated for each file processed (does not impact function output)::
# In readLines(paste(raw_file_path, f, sep = "/")) :
# incomplete final line found on path.file name 

#check clean file folder 
dir(clean_path_example) 

##extract segments containing key word of interest 
#example with key word "black" 
black <- speech_extract(input = clean_path_example, key_word = "black")
length(black)
names(black)
black[[1]] #or black$trump__eMK77EZO70_clean.txt

#example with more than one key word: "great" and "America"
black2 <- speech_extract(input = clean_path_example, key_word = c("black", "african"))
length(black2)
names(black2)
black2[[1]] #or black2$trump__eMK77EZO70_clean.txt
