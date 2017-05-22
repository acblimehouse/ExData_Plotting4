source("DataLocator.R") ## See here: https://github.com/acblimehouse/ExData_Plotting4

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