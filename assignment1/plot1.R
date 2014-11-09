# Script plot1.R

setwd("/media/sdb1/Projects/Rstudio/exploratory data analysis/course_assignment_1")

if(file.exists("plot1.png")){  
  print("plot1.png already exists: plot1.R done")
  return(TRUE)
}else {  
  dataName <- "PowDat"
  if(!(dataName %in% ls())) { 
    print("data table not loaded: getting data")
    source(paste0(getwd(), "/loadPowr.R"))
  } 
  par(pin = c(4, 4))
  hist(PowDat$Global_active_power, col = "red", freq = TRUE, main = " ", xlab = "Global Active Power (kilowatts)")

  dev.copy(png, width=480, height=480, file = "plot1.png")
  dev.off()
}
