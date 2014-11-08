#Script plot3.R
library(ggplot2)
library(scales)

if(file.exists("plot3.png")){  
  print("plot3.png already exists: plot3.R done")
  return(TRUE)
}else {  
  dataName <- "PowDat"
  if(!(dataName %in% ls())) { 
    print("data table not loaded: getting data")
    source(paste0(getwd(), "/loadPowr.R"))
  } 

  x_start <- strptime("2007-02-02 10:00:00", format="%Y-%m-%d %H:%M:%S")
  x_end <- strptime("2007-02-02 11:40:00", format="%Y-%m-%d %H:%M:%S") 
  p<-ggplot(PowDat, aes(x=fullDate, y=Sub_metering_1)) +
    geom_line() + 
    geom_line(data=PowDat, aes(y=Sub_metering_2), color="red") +
    geom_line(data=PowDat, aes(y=Sub_metering_3), color="blue") +
    ylab("Energy sub-metering") +
    xlab("") + 
    scale_x_datetime(breaks = date_breaks("1 day"), 
                     labels=date_format(format="%a")) +
    geom_segment(aes(xend=x_end, y=33, yend=33, x=x_start), color="blue") + 
    annotate("text", label="Sub_metering_3", y=33, x=x_end, hjust=0 ) + 
    geom_segment(aes(xend=x_end, y=35, yend=35, x=x_start), color="red") + 
    annotate("text", label="Sub_metering_2", y=35, x=x_end, hjust=0 ) +
    geom_segment(aes(xend=x_end, y=37, yend=37, x=x_start)) + 
    annotate("text", label="Sub_metering_1", y=37, x=x_end, hjust=0 ) +
    theme(legend.position="none")

  print(p)
  dev.copy(png, file = "plot3.png")
  dev.off()
}