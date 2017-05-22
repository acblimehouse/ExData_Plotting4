source("DataLocator.R")

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