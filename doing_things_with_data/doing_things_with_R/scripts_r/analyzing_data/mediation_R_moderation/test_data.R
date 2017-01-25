####librarys needed 
library(foreign)

####data set example 
file1 <- "http://www.guilford.com/add/jose/mediation_example.sav"
jose_example_1 <- read.spss(file = file1, to.data.frame = T)

file2 <- "http://www.guilford.com/add/jose/experimental_mediation_example.sav"
jose_example_2 <- read.spss(file = file2, to.data.frame = T)
str(jose_example_2)
colnames(jose_example_2) <- tolower(colnames(jose_example_2))
jose_example_2$treatment_dummy <- as.numeric(jose_example_2$treatment)
jose_example_2$treatment_dummy[jose_example_2$treatment_dummy==1] <- 0
jose_example_2$treatment_dummy[jose_example_2$treatment_dummy==2] <- 1

