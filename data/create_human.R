#Maija Nuppunen-Puputti, 22nd of November, 2019.
#Data wrangling for week 5: Create a new R script called create_human.R

#Read the “Human development” and “Gender inequality” datas into R. Here are the links to the datasets:
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

#and
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Let's explore the structure, dimensions and summary of the variables from both datasets:

##Human development dimension
str(hd)
dim(hd)
summary(hd)

##Gender inequality dimensions
str(gii)
dim(gii)
summary(gii)

#change the names of the columns to shorter descriptive ones

#hd dataset variables
names(hd)
colnames(hd)[1] <- "HRank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "life"
colnames(hd)[5] <- "edu"
colnames(hd)[6] <- "edumean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNIsub"

#gii dataset variables
names (gii)

colnames(gii)[1] <- "GRank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "Mort"
colnames(gii)[5] <- "BR"
colnames(gii)[6] <- "Rep"
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
colnames(gii)[9] <- "laboF"
colnames(gii)[10] <- "laboM"

#Mutate the “Gender inequality” data and create two new variables edu2rat and labo2rat
gii <- mutate(gii, edu2rat = (edu2F/edu2M))
gii <- mutate(gii, labo2rat = (laboF/laboM))
glimpse(gii)

#Let's join_by the datasets by variable "country"
join_by = c("country")

# We can now join the two datasets by the selected identifiers
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd",".gii"))

#Check the dimension and structure of the joined dataset, should be 195 observations and 19 variables
dim(human)
str(human)

#Save the joined and modified data set to the ‘data’ folder
write.csv(human, file = "~/Documents/MAIJA/R_IODS/IODS-project/data/human.csv")

#Let's check the csv-file
datafromcsv<-read.csv("~/Documents/MAIJA/R_IODS/IODS-project/data/human.csv", row.names = 1)
dim(datafromcsv)
names(datafromcsv)