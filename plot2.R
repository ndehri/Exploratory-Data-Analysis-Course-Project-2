setwd("~/myR_scripts/coursera/Exploratory Data Analysis/CourseProject2")

## Load the required libraries
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
# system to make a plot answering this question.

totalEmissions <- filter(NEI, fips == "24510") %>% 
                        group_by(year) %>%
                        summarise(Emissions = sum(Emissions))

png(filename="plot2.png", width = 700, height = 700)

plot(totalEmissions$year, totalEmissions$Emissions, type = "l", col = "red", lwd = 3, 
     xlab= "years", ylab=expression("Total amount of PM"[2.5]*"emitted, in tons"), 
     main = expression("Total amount of PM"[2.5]*"emitted in Baltimore City, Maryland from 1999 to 2008"))

dev.off()

