source("DataLocator.R") ## See here: https://github.com/acblimehouse/ExData_Plotting4

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