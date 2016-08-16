setwd("~/myR_scripts/coursera/Exploratory Data Analysis/CourseProject2")

## Load the required libraries
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

baltcity.emissions<-NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
emissions.by.year <- group_by(baltcity.emissions, year) %>%
                        summarise(Emissions=sum(Emissions))


png(filename="plot5.png", width = 1400, height = 700)

g <- ggplot(data = emissions.by.year, aes(x = year, y = Emissions))
g + geom_line() + 
        labs(x = "years", 
             y = expression("Amount of PM"[2.5]*"emitted, in tons"), 
             title = "Emissions from motor vehicle sources in Baltimore City from 1999-2008") +
        theme(
                plot.title = element_text(size=18, face="bold.italic"),
                axis.title.x = element_text(size=15),
                axis.title.y = element_text(size=15)
        )


dev.off()


