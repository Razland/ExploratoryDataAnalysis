library(plyr)                                 ## Load libraries
library(dplyr)

dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
targFileName <- "exdata_data_houshold_power_consumption.zip"
dataFileName <- "household_power_consumption.txt"

if(!file.exists(dataFileName)) {    
  print(paste0("downloading data ", dataURL))
  download.file( dataURL, destfile = targFileName, method = "curl")
  unzip(targFileName)
}

PowDat <- read.table( "household_power_consumption.txt", header=T, na.strings="?", sep=";")
PowDat$Date <- as.Date(PowDat$Date, format="%d/%m/%Y")
PowDat <- filter( PowDat, PowDat$Date == as.Date("2007-02-01") | PowDat$Date == as.Date("2007-02-02"))

PowDat<- mutate( PowDat, fullDate =format(paste(PowDat$Date, PowDat$Time), format="%Y-%m-%d %H:%M:%S"))
PowDat<- PowDat[,c(1, 2, 10, 3:9)]
PowDat$fullDate <- strptime(PowDat$fullDate, format = "%Y-%m-%d %H:%M:%S")
