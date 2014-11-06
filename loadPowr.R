library(plyr)                                 ## Load libraries
library(dplyr)

dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
targFileName <- "exdata_data_houshold_power_consumption.zip"
dataFileName <- "household_power_consumption.txt"

if(! file.exists("household_power_consumption.txt")) {    
  download.file( dataURL, destfile = targFileName, method = "curl")
  unzip(targFileName)
}

PowDat <- read.table( "household_power_consumption.txt", header=T, na.strings="?", sep=";")
PowDat$Date <- as.Date(as.Date(PowDat$Date, format="%d/%m/%Y"))
PowDat <- filter( PowDat, PowDat$Date == as.Date("2007-02-01") | PowDat$Date == as.Date("2007-02-02"))j

#plot 1

par(pin = c(4, 4))
hist(PowDat$Global_active_power, col = "red", freq = TRUE, main = " ", xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()