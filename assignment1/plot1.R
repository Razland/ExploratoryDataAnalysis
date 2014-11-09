# Script plot1.R
# Dave Kenny.  Exploratory Data Analysis Assignment 1, Nov 2014.

targFile <- "figure/plot1.png"
if(file.exists(targFile)){     ## Quits if the png file already present
  print("plot1.png already exists: plot1.R done")
  return(TRUE)
} else {  
  dataName <- "powDat"
  if(!(dataName %in% ls())) {   ## loads table from data file 
    print("data table not loaded: getting data")
    source(paste0(getwd(), "/loadPowr.R"))
  } 
  par(pin = c(4, 4))                 ## Sets display device default proportions
  hist(powDat$Global_active_power,   ## Basic R plotting histogram
       col = "red", 
       freq = TRUE, 
       main = " ", 
       xlab = "Global Active Power (kilowatts)")

  dev.copy(png, width=480, height=480, file = targFile)  ## output to file
  dev.off()
  rm(dataName, targFile )  ## cleanup variables
}
