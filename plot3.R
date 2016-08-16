setwd("~/myR_scripts/coursera/Exploratory Data Analysis/CourseProject2")

## Load the required libraries
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

totalEmissions <- filter(NEI, fips == "24510") %>% 
                group_by(type, year) %>%
                summarise(Emissions = sum(Emissions))


png(filename="plot3.png", width = 1400, height = 700)

g <- ggplot(data = totalEmissions, aes(x = year, y = Emissions, color = type))
g + geom_line() + facet_grid(. ~ type) + 
        labs(x = "years", 
             y = expression("Amount of PM"[2.5]*"emitted, in tons"), 
             title = expression("Amount of PM"[2.5]*"emitted in Baltimore City from 1999 to 2008 by type")) +
        theme(
                plot.title = element_text(size=18, face="bold.italic"),
                axis.title.x = element_text(size=15),
                axis.title.y = element_text(size=15)
        )

dev.off()


