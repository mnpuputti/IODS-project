#Maija Nuppunen-Puputti, 14th of November 2019, IODS week 3

#This dataset contain data on student achievements in two Portuguese schools. 
#We look mathematic (mat) and portuguese language (por) datasets in detail.
#Dateset student.zip-file can be found here: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/
#and information on dataset background here: https://archive.ics.uci.edu/ml/datasets/Student+Performance

setwd("~/Documents/MAIJA/R_IODS/IODS-project/data")

#Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data. (1 point)
#Join the two data sets using the variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers. Keep only the students present in both data sets. 
#Explore the structure and dimensions of the joined data. (1 point)

mat <- read.csv(file="student-mat.csv", sep= ";", header = TRUE)
dim(mat)
str(mat)

por <- read.csv(file = "student-por.csv", sep=";", header = TRUE)
dim(por)
str(por)

# load dplyr
library(dplyr)

#Let's join_by the datasets by these variables: "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" 
join_by = c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" )

# We can now join the two datasets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat",".por"))

#Check the dimension and structure of the joined dataset
dim(mat_por)
str(mat_por)

#or
glimpse(mat_por)

#Now we need to combine  the 'duplicated' answers in the joined data

# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# And let's check how the  new combined data looks with glimpse
glimpse(alc)

###########
#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the
#joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' 
#is greater than 2 (and FALSE otherwise). (1 point)

# Let's mutate the alc-datset and create a new column "alc_use" by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Let's specify a column for "high_use" for students with alc_use greater than 2 
alc <- mutate(alc, high_use = (alc_use > 2))

#Glimpse at the joined and modified data to make sure everything is in order. 
#The joined data should now have 382 observations of 35 variables. 
glimpse(alc)


#Save the joined and modified data set to the ‘data’ folder, using for example write.csv() or write.table() functions. (1 point)

write.csv(alc, file = "~/Documents/MAIJA/R_IODS/IODS-project/data/alc.csv")

#Let's check the csv-file
datafromcsv<-read.csv("~/Documents/MAIJA/R_IODS/IODS-project/data/alc.csv", row.names = 1)
str(datafromcsv)
head(datafromcsv)
