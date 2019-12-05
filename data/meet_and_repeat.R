#IODS week 6, 5th of December 2019
#Maija Nuppunen-Puputti

#Load in needed packages:
library(dplyr)
library(tidyr)

#Reading in the data in wide form:

#BPRS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = TRUE)

names(BPRS)
str (BPRS)
dim(BPRS)
summary(BPRS)

#RATS
RATS<- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep='\t', header = TRUE)

names(RATS)
str(RATS)
dim(RATS)
summary(RATS)

#Convert the categorical variables of both data sets to factors. 
#BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

#rats
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. 

#BPRS
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))

#rats
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3,4))) 

#Now, take a serious look at the new data sets and compare them with their wide form versions: 
#Check the variable names, view the data contents and structures, and create some brief summaries of the variables. 
#Make sure that you understand the point of the long form data and the crucial difference between the wide 
#and the long forms before proceeding the to Analysis exercise. (2 points)

#BPRSL
names(BPRSL)
str(BPRSL)
dim(BPRSL)
glimpse(BPRSL)
summary(BPRSL)

#RATSL
names(RATSL)
str(RATSL)
dim(RATSL)
glimpse(RATSL)
summary(RATSL)

#Let's write these into .csv files'

write.csv(BPRSL, file = "~/Documents/MAIJA/R_IODS/IODS-project/data/BPRSL.csv")
write.csv(RATSL, file = "~/Documents/MAIJA/R_IODS/IODS-project/data/RATSL.csv")

#Let's check the csv-file
datafromcsv<-read.csv("~/Documents/MAIJA/R_IODS/IODS-project/data/BPRSL.csv", row.names = 1)
str(datafromcsv)
head(datafromcsv)
