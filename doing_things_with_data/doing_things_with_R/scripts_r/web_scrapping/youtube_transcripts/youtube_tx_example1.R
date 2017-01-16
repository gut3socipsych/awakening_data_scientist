####youtube transcript examples 

##import functions from file 
source(file = "../doing_things_with_R/scripts_r/web_scrapping/youtube_transcripts/youtube_tx_functions.R")

##clean and save transcript text files copied from youtube
#path to raw data files folder 
raw_path_example <- "../example_datasets/youtube_transcript_data/youtube_transcripts_raw/youtube_trump_speeches_raw"
dir(raw_path_example)

#path to empty folder for clean files
clean_path_example <- "../example_datasets/youtube_transcript_data/youtube_transcripts_clean/youtube_trump_speeches_clean"
dir(clean_path_example)

#run clean_and_save function on raw data files 
clean_and_save(raw_file_path = raw_path_example, clean_file_path = clean_path_example)
#check clean file folder 
dir(clean_path_example) 

##extract speech segments that contains key word(s) of interest 
