#Script to convert factor data to numeric data without loss or alterations of values

#Samlpe data frame with factor variables represented by numbers 
factor.vector1<-factor(x=c(111,222,333,444,555))
thousands<-c("1,000","2,000","3,000","4,000","5,000")
factor.vector2<-factor(x=thousands)
df<-data.frame(factor.vector1, factor.vector2)

str(df)

#Numbers as factors without comma place holders
#1st convert dataset to character data type
df[,1]<-as.character(df[,1])
#2nd convert dataset to numeric data type
df[,1]<-as.numeric(df[,1])

#Numbers as factors WITH comma place holders 
#If data contains commas in the numbers (e.g. 2,000) use gsub to remove commas
#If commas are not removed before conversion, the value containing commas will become NA
df[,2]<-gsub(",", "", df[,2])
#1st convert dataset to character data type
df[,2]<-as.character(df[,2])
#2nd convert dataset to numeric data type
df[,2]<-as.numeric(df[,2])

str(df)
