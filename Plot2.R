source("DataLocator.R")

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