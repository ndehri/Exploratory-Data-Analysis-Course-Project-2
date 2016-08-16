setwd("~/myR_scripts/coursera/Exploratory Data Analysis/CourseProject2")

## Load the required libraries
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector) # returns a logical vector
combustion.coal.sources <- SCC[combustion.coal,]

emissions.coal.combustion <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

emissions.coal <- group_by(emissions.coal.combustion, year) %>%
                        summarise(Emissions=sum(Emissions))

png(filename="plot4.png", width = 1400, height = 700)

g <- ggplot(data = emissions.coal, aes(x = year, y = Emissions))
g + geom_line() + 
        labs(x = "years", 
             y = expression("Amount of PM"[2.5]*"emitted, in tons"), 
             title = expression("Emissions from coal combustion-related sources from 1999-2008")) +
        theme(
                plot.title = element_text(size=18, face="bold.italic"),
                axis.title.x = element_text(size=15),
                axis.title.y = element_text(size=15)
        )


dev.off()


