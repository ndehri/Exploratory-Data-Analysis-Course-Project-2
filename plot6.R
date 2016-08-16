setwd("~/myR_scripts/coursera/Exploratory Data Analysis/CourseProject2")

## Load the required libraries
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

baltcity.emissions<- filter(NEI, fips == "24510"& type == 'ON-ROAD') %>%
                        group_by(year) %>%
                        summarise(Emissions=sum(Emissions))


la.emissions<- filter(NEI, fips == "06037"& type == 'ON-ROAD') %>%
                group_by(year) %>%
                summarise(Emissions=sum(Emissions))


baltcity.emissions$County <- "Baltimore City, MD"
la.emissions$County <- "Los Angeles County, CA"
both.emissions <- rbind(baltcity.emissions, la.emissions)

png(filename="plot6.png", width = 1400, height = 700)

g <- ggplot(data = both.emissions, aes(x = year, y = Emissions, color = County))
g + geom_line() + facet_grid(County~., scales="free") + 
        labs(x = "years", 
             y = expression("Amount of PM"[2.5]*"emitted, in tons"), 
             title = "Motor vehicle emission variation in Baltimore and Los Angeles") +
        theme(
                plot.title = element_text(size=18, face="bold.italic"),
                axis.title.x = element_text(size=15),
                axis.title.y = element_text(size=15)
        )


dev.off()


