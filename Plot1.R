source("DataLocator.R")

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
