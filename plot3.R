#Script plot3.R
# Dave Kenny.  Exploratory Data Analysis Assignment 1, Nov 2014.

targFile <- "figure/plot3.png"

library(ggplot2)
library(scales)

if(file.exists(targFile)){       ## Quits if the png file already present
  print("plot3.png already exists: plot3.R done")
  return(TRUE)
} else {  
  dataName <- "powDat"
  if(!(dataName %in% ls())) {    ## loads table from data file
    print("data table not loaded: getting data")
    source(paste0(getwd(), "/loadPowr.R"))
  } ## use ggplot2 functions to create output graphic.
  ann_x_start <- strptime("2007-02-02 10:00:00", format="%Y-%m-%d %H:%M:%S")
  ann_x_end <- strptime("2007-02-02 11:40:00", format="%Y-%m-%d %H:%M:%S") 
  box_vert <- strptime("2007-02-02 09:30:00", format="%Y-%m-%d %H:%M:%S")
  box_h <- strptime("2007-02-03 00:00:01", format="%Y-%m-%d %H:%M:%S")
  p<-ggplot(powDat, aes(x=fullDate, y=Sub_metering_1)) +
    geom_line(aes(xmax=box_h, ymax=38)) +
    geom_line(data=powDat, aes(y=Sub_metering_2), color="red") +
    geom_line(data=powDat, aes(y=Sub_metering_3), color="blue") +
    xlab("") +
    coord_cartesian(ylim=c(0,40) ) +
    scale_x_datetime(breaks = date_breaks("1 day"), 
                     labels=date_format(format="%a")) +
    scale_y_continuous("Energy sub metering" ,breaks=c(0,10,20,30)) +
    geom_segment(aes(x=ann_x_start, 
                     xend=ann_x_end-300, 
                     y=32, 
                     yend=32), 
                 color="blue") + 
    annotate("text", label="Sub_metering_3", y=32, x=ann_x_end, hjust=0 ) + 
    geom_segment(aes(x=ann_x_start, 
                     xend=ann_x_end-300, 
                     y=34, 
                     yend=34), 
                 color="red") + 
    annotate("text", label="Sub_metering_2", y=34, x=ann_x_end, hjust=0 ) +
    geom_segment(aes(x=ann_x_start, xend=ann_x_end-300, y=36, yend=36)) + 
    annotate("text", label="Sub_metering_1", y=36, x=ann_x_end, hjust=0 ) + 
    geom_segment(aes(x=box_vert,xend=box_vert, y=40, yend=29)) +
    geom_segment(aes(x=box_vert, xend=box_h, y=29, yend=29)) +
    theme(legend.position="none") +
    theme_bw()

  print(p)
  dev.copy(png, width=480, height=480, file = targFile)  ## output to file
  dev.off()
  rm(dataName, targFile, p, ann_x_start,    ## cleanup variables
      ann_x_end, box_vert, box_h ) 
}
