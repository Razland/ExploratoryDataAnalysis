#Script plot2.R

if(file.exists("plot2.png")){  
  print("plot2.png already exists: plot2.R done")
  return(TRUE)
}else {  
  dataName <- "PowDat"
  if(!(dataName %in% ls())) { 
    print("data table not loaded: getting data")
    source(paste0(getwd(), "/loadPowr.R"))
  } 
  par(pin = c(4, 4))
  plot(PowDat$fullDate, 
       PowDat$Global_active_power, 
       ylab = "Global Active Power (kilowatts)",
       xlab = "",
       type = "l")

  dev.copy(png, file = "plot2.png")
  dev.off()
}