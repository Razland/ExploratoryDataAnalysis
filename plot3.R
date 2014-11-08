#Script plot3.R
library(ggplot2)

if(file.exists("plot3.png")){  
  print("plot3.png already exists: plot3.R done")
  return(TRUE)
}else {  
  dataName <- "PowDat"
  if(!(dataName %in% ls())) { 
    print("data table not loaded: getting data")
    source(paste0(getwd(), "/loadPowr.R"))
  } 
#  par(pin = c(4, 4))
#  qplot(PowDat$fullDate, PowDat$Sub_metering_1 + PowDat$Sub_metering_2 + PowDat$Sub_metering_3, geom = "line" )
 
p<-ggplot(PowDat, aes(x=fullDate, y=Sub_metering_1)) +
  geom_line() + geom_line(data=PowDat, aes(y=Sub_metering_2), color="red") +
  geom_line(data=PowDat, aes(y=Sub_metering_3), color="blue")
  
  print(p)
  dev.copy(png, file = "plot3.png")
  dev.off()
}