## Checks to see if data is available, if not, it loads it from the web. Subsequently, it checks to see
## if the data is in the environment, if not, it reads the data into the environment.

## Download, unzip, and read the dataset

MyWD <- "/Users/adamlimehouse/Desktop/Dropbox/03 Projects Folder/Economic and Policy Analysis/Intro to Data Science R Files/ExData_Plotting4"
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
NEIfile <- "summarySCC_PM25.rds"
SCCfile <- "Source_Classification_Code.rds"
filename <- "exdata%2Fdata%2FNEI_data"

setwd(MyWD)

if (!file.exists(filename)){
  download.file(dataURL, filename, method="curl")
}  
if (!file.exists(NEIfile) & !file.exists(SCCfile)) { 
  unzip(filename) 
}
if (!exists("NEI") & !exists("SCC")){
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Clean Up
rm(MyWD, dataURL, NEIfile, SCCfile, filename)