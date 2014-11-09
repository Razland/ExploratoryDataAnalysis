# Script loadPowr.R
# Dave Kenny.  Exploratory Data Analysis Assignment 1, Nov 2014.
# Utility script to get files and load into data structure.

library(plyr) ## Load libraries
library(dplyr)

dataURL <- paste0("https://d396qusza40orc.cloudfront.net/",
                  "exdata%2Fdata%2Fhousehold_power_consumption.zip")
targFileName <- "exdata_data_houshold_power_consumption.zip"
dataFileName <- "household_power_consumption.txt"

if(!file.exists(dataFileName)) {                          ## if not present,
print(paste0("downloading data ", dataURL))               ## download file
download.file(dataURL,                                    ## from web and  
              destfile = targFileName, method = "curl")   ## decompress
unzip(targFileName)
}
powDat <- read.table("household_power_consumption.txt",   ## Read data
                     header=T, na.strings="?", 
                     sep=";")
powDat$Date <- as.Date(powDat$Date,                       ## Change date
                       format="%d/%m/%Y")                 ## to POSIX
powDat <- filter(powDat,                                  ## Discard un-
                 powDat$Date == as.Date("2007-02-01") |   ## interesting 
                 powDat$Date == as.Date("2007-02-02"))    ## variables
powDat<- mutate(powDat,                                   ## Create new var-
                fullDate=format(paste(powDat$Date,        ## iable from date 
                                      powDat$Time),       ## and time fields
                format="%Y-%m-%d %H:%M:%S"))
powDat<- powDat[,c(1, 2, 10, 3:9)]                        ## Order variables
powDat$fullDate <- strptime(powDat$fullDate,              ## Change variable to 
                            format = "%Y-%m-%d %H:%M:%S") ## date type
rm(dataURL, targFileName, dataFileName)                   ## Cleanup
return(powDat)                                            ## Return data table.
