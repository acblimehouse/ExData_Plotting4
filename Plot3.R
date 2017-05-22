source("DataLocator.R")

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