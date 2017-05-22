## Necessary Packages
install.packages("ggplot")
library(ggplot2)

## Download, unzip, and read the dataset:
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
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##              Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##              sources for each of the years 1999, 2002, 2005, and 2008.

  ## Aggregate the data by year
  EmissionsbyYear <- aggregate(Emissions ~ year, NEI, sum)
  
  ## Plot the visualization using the Base plotting system
  png("plot1.png",width=480,height=480,units="px")
  barplot(
    (EmissionsbyYear$Emissions)/10^6,
    names.arg=EmissionsbyYear$year,
    xlab="Year",
    ylab="PM2.5 Emissions (10^6 Tons)",
    main="Total PM2.5 Emissions From All US Sources"
  )
  dev.off()
  
  ## Clean Up
  rm(EmissionsbyYear)
  
## Question 2 - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##              (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot 
##              answering this question.
  
  ## Aggregate the data by year for Baltimore City, MD
  EmissionsbyYearBMD <- aggregate(Emissions ~ year, subset(NEI, fips == 24510), sum)
  
  ## Plot the question using the Base plotting system.
  png("plot2.png",width=480,height=480,units="px")
  barplot(
    (EmissionsbyYearBMD$Emissions),
    names.arg=EmissionsbyYearBMD$year,
    xlab="Year",
    ylab="PM2.5 Emissions for Baltimore, MD",
    main="Total PM2.5 Emissions in tons"
  )
  dev.off()
  
  ## Clean up
  rm(EmissionsbyYearBMD)
  
## Question 3 - Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad)
##              variable, which of these four sources have seen decreases in emissions from 1999–2008 for 
##              Baltimore City? Which have seen increases in emissions from 1999–2008? 
##              Use the ggplot2 plotting system to make a plot answer this question.
  
  ## Aggregate the data by type and by year
  EmYandTforBMD <- aggregate(Emissions ~ year + type, subset(NEI, fips == 24510), sum)
  
  ## Use ggplot2 to display an answer to the question
  png("plot3.png",width=480,height=480,units="px")
  plot3 <- ggplot(EmYandTforBMD, aes(year, Emissions, color = type))
  plot3 <- plot3 + geom_line() +
           xlab ("Year")
           ylab (expression("Total PM"[2.5]*" Emission"))
           ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
  print(plot3)
  dev.off()
  
  ## Clean Up
  rm(EmYandTforBMD,plot3)

## Question 4 - Across the United States, how have emissions from coal combustion-related sources changed 
##              from 1999–2008?
  
  ## Segment the data by coal combustion-related sources
  combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
  coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
  coalCombustion <- (combustionRelated & coalRelated)
  combustionSCC <- SCC[coalCombustion,]$SCC
  combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]
  
  ## Plot using ggplot2
  png("plot4.png",width=480,height=480,units="px")
  plot4 <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
    geom_bar(stat="identity",aes(fill=year),width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("US PM"[2.5]*" Coal Combustion Source Emissions"),
         subtitle = "During years 1999 - 2008")
  print(plot4)
  dev.off()
  
  ## Clean Up
  rm(combustionRelated,coalRelated,coalCombustion,
     combustionSCC, combustionNEI, plot4)

## Question 5 - How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
  
  ## Segment the data by motor vehicle sources
  vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
  vehiclesSCC <- SCC[vehicles,]$SCC
  vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
  
  ## Plot using ggplot2
  png("plot5.png",width=480,height=480,units="px")
  plot5 <- ggplot(subset(vehiclesNEI,fips==24510),aes(factor(year),Emissions)) +
    geom_bar(stat="identity",aes(fill=year),width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore"),
         subtitle = "From 1999-2008")
  print(plot5)
  dev.off()
  
  ## Clean Up
  rm(vehicles, vehiclesSCC, vehiclesNEI, plot5)
  
## Question 6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
##              vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽")
##              Which city has seen greater changes over time in motor vehicle emissions?
  
  ## Segment the data by motor vehicle sources
  vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
  vehiclesSCC <- SCC[vehicles,]$SCC
  vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
  
  # Subset the vehicles NEI data by each city's fip and add city name.
  BaltimoreMD.Veh.NEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
  BaltimoreMD.Veh.NEI$city <- "Baltimore City"
  
  LosAngelesCA.Veh.NEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
  LosAngelesCA.Veh.NEI$city <- "Los Angeles County"
  
  # Combine the two subsets with city name into one data frame
  Veh.NEI <- rbind(BaltimoreMD.Veh.NEI,LosAngelesCA.Veh.NEI)
  
  ## Plot using ggplot2
  png("plot6.png",width=480,height=480,units="px")
  plot6 <- ggplot(Veh.NEI, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions"),
         subtitle = "Baltimore & LA, 1999-2008")
  print(plot6)
  dev.off()
  
  ## Clean Up
  rm(vehicles, vehiclesSCC, vehiclesNEI, BaltimoreMD.Veh.NEI, LosAngelesCA.Veh.NEI, Veh.NEI, plot6)

## Final Clean Up  
rm(dataURL,filename,MyWD,NEIfile,SCCfile)