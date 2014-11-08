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
  box_vert <- strptime("2007-02-02 09:30:00", format="%Y-%m-%d %H:%M:%S")
  box_h <- strptime("2007-02-03 00:00:01", format="%Y-%m-%d %H:%M:%S")
  p<-ggplot(PowDat, aes(x=fullDate, y=Sub_metering_1)) +
    geom_line() + 
    geom_line(data=PowDat, aes(y=Sub_metering_2), color="red") +
    geom_line(data=PowDat, aes(y=Sub_metering_3), color="blue") +
    ylab("Energy sub-metering") +
    xlab("") + 
    scale_x_datetime(breaks = date_breaks("1 day"), 
                     labels=date_format(format="%a")) +
    geom_segment(aes(x=x_start, xend=x_end-300, y=33, yend=33), color="blue") + 
    annotate("text", label="Sub_metering_3", y=33, x=x_end, hjust=0 ) + 
    geom_segment(aes(x=x_start, xend=x_end-300, y=35, yend=35), color="red") + 
    annotate("text", label="Sub_metering_2", y=35, x=x_end, hjust=0 ) +
    geom_segment(aes(x=x_start, xend=x_end-300, y=37, yend=37)) + 
    annotate("text", label="Sub_metering_1", y=37, x=x_end, hjust=0 ) + 
    geom_segment(aes(x=box_vert,xend=box_vert, y=40, yend=31))+
    geom_segment(aes(x=box_vert, xend=box_h, y=31, yend=31)) +
    theme(legend.position="none")+
    theme_bw()

  print(p)
  dev.copy(png, file = "plot3.png")
  dev.off()
}