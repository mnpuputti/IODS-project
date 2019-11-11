#Write your name, date and a one sentence file description as a comment on the top of the script file. 

#Maija Nuppunen-Puputti, 7th of Noverber 2019, IODS week 2: Data Wrangling script
#Data available in: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt


#PART 1.
#Read the full learning2014 data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt into R 
#(the separator is a tab ("\t") and the file includes a header) and explore the structure and dimensions of the data. 
#Write short code comments describing the output of these explorations. (1 point)

#Bringing "Learning2014" data into R
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#Checking dimensions of the data
dim(learning2014)

#Checking the structure of the data
str(learning2014)

##############

#PART 2.

#Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions
#in the learning2014 data, as defined in the datacamp exercises and also on the bottom part of the following page 
#(only the top part of the page is in Finnish). http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt.
#Scale all combination variables to the original scales (by taking the mean). 
#Exclude observations where the exam points variable is zero. 
#(The data should then have 166 observations and 7 variables) (1 point)


#Lets use dplyr
library(dplyr)

# 1. You need to pull deep, surf and stra variables from the dataset

#Create variable "deep".
#First pull all starting with letter D, then check the columns and
#pick the number-coded for variable deep.  Pull the names and scale with mean values.
D<- select(learning2014, starts_with("D"))
head(D)
deep <- D[1:12]
deep
names(deep)

#Create variable "surf" 
SU<- select(learning2014, starts_with("SU"))
head(SU)
surf <- SU[1:12]
surf
names(surf)

#Create variable "stra"
ST<- select(learning2014, starts_with("ST"))
head(ST)
stra <- ST[1:8]
stra
names(stra)

#"Scale all combination variable (deep, surf and stra) with mean values
deepM<- rowMeans(deep)
deepM

surfM<- rowMeans(surf)
surfM

straM<- rowMeans(stra)
straM


# Create deep, surf and stra columns to Learning2014 with mean values created earlier

learning2014$deep <- deepM
learning2014$surf <- surfM
learning2014$stra <- straM

#Check the dimension and structure of the new combined dataset
dim(learning2014)
str(learning2014)
head(learning2014)

#Pick variables to keep
picked_variables <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

#And create analysis dataset with them
analysis_dataset <- select(learning2014, one_of(picked_variables))

#We'll check the column names 
colnames(analysis_dataset)

# change the name ofthe columns with Big letters to small letters
colnames(analysis_dataset)[2] <- "age"
colnames(analysis_dataset)[3] <- "attitude"
colnames(analysis_dataset)[7] <- "points"

#Check the column names again to see, if the transformation was successfull
colnames(analysis_dataset)

#Exclude observations where the exam points variable is zero. 
#Filter all 0 point values out of the analysis dataset
analysis_dataset <- filter(analysis_dataset, points>0)

#Check, if the dataset now matches the given dimension "#The data should then have 166 observations and 7 variables"
dim(analysis_dataset)

#############

#PART3.
head(analysis_dataset)

#Set the working directory
setwd("~/Documents/MAIJA/R_IODS/IODS-project/")

#Save the analysis dataset to the ‘data’ folder, using for example write.csv() or write.table() functions. 
#You can name the data set for example as learning2014(.txt or .csv). 
#See ?write.csv for help or search the web for pointers and examples. 
#Demonstrate that you can also read the data again by using read.table() or read.csv().  
#(Use `str()` and `head()` to make sure that the structure of the data is correct).  (3 points)

write.table(analysis_dataset, "~/Documents/MAIJA/R_IODS/IODS-project/data/learning2014.txt", header = FALSE, sep = " ", dec = ".")
datafromtxt<-read.table("~/Documents/MAIJA/R_IODS/IODS-project/data/learning2014.txt", header = TRUE, sep = " ", row.names = 1)

str(datafromtxt)
head(datafromtxt)

write.csv(analysis_dataset, file = "~/Documents/MAIJA/R_IODS/IODS-project/data/learning2014.csv", sep = " ")
datafromcsv<-read.csv("~/Documents/MAIJA/R_IODS/IODS-project/data/learning2014.csv", row.names = 1)
str(datafromcsv)
head(datafromcsv)
