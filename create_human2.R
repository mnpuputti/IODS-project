###Week 5 Data wrangling 
#Maija Nuppunen-Puputti

#Let's load in the ready dataset to get matching names for this exercise
human <- read.table(file="http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header = TRUE, sep=",")

#check dim, should be 195&19
dim(human)

glimpse(human)

#Mutate the data: transform the Gross National Income (GNI) variable to numeric
#(Using string manipulation. Note that the mutation of 'human' was not done on DataCamp). (1 point)

#Let's load the stringr package
library(stringr)
# load dplyr
library(dplyr)

# Let's  transform the GNI variable to numeric

# remove the commas from GNI and print out a numeric version of it
GNI2 <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric 
human <- mutate(human, GNI = GNI2)
#Check if OK
str(human)

#Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above):  
#"Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)
#Pick variables to keep
picked_variables <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

#And create analysis dataset with them
human2 <- select(human, one_of(picked_variables))

#Now we can filter out all rows with NA values. First evaluate complete.cases.
complete.cases(human2)
data.frame(human2[-1], comp = complete.cases(human2))
human3 <- filter(human2, complete.cases(human2))

#Remove the observations which relate to regions instead of countries. (1 point)

#Let's check the observations in the country category
human3$Country

#All the region information is at the 7 last observations, let's check just them with
tail(human3, 7)
last <- nrow(human3) - 7
human4 <- human3[1:last, ]
human4$Country

#Define the row names of the data by the country names and remove the country name column from the data. 
rownames(human4) <- human4$Country
human5 <- select(human4, -Country)

#Let's check the dimensions of the modified human5 dataset. (The data should now have 155 observations and 8 variables.)
dim(human5)

#Save the human data in your data folder including the row names. You can overwrite your old ‘human’ data. (1 point)
write.csv(human5, file = "~/Documents/MAIJA/R_IODS/IODS-project/data/human.csv")

#Let's check the csv-file
datafromcsv<-read.csv("~/Documents/MAIJA/R_IODS/IODS-project/data/human.csv", row.names = 1)
str(datafromcsv)
dim(datafromcsv)
tail(datafromcsv)
