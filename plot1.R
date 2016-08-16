setwd("~/myR_scripts/coursera/Exploratory Data Analysis/CourseProject2")

## Load the required libraries
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008 ? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

totalEmissions <- group_by(NEI, year) %>% 
                        summarise(Emissions = sum(Emissions))

png(filename="plot1.png" , width = 700, height = 700)

plot(totalEmissions$year, totalEmissions$Emissions, type = "l", col = "red", lwd = 3, 
     xlab= "years", ylab=expression("Total amount of PM"[2.5]*"emitted, in tons"), 
     main = expression("Total amount of PM"[2.5]*"emitted from 1999 to 2008"))

dev.off()


