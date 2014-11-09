#Script plot4.R
library(ggplot2 )
library(scales )
source("multiplot.R" )

plot1 <-function(){ 
  p1<-ggplot(PowDat, aes(x=fullDate, y=Global_active_power )) +
    geom_line() + 
    ylab("Global Active Power" ) +
    xlab("" ) + 
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    theme(legend.position="none" ) +
    theme_bw(base_size=7 )
  return(p1 )
}

plot2 <-function(){  
  ann_x_start <- strptime("2007-02-02 10:00:00", format="%Y-%m-%d %H:%M:%S" )
  ann_x_end <- strptime("2007-02-02 11:40:00", format="%Y-%m-%d %H:%M:%S" ) 
  box_vert <- strptime("2007-02-02 09:30:00", format="%Y-%m-%d %H:%M:%S" )
  box_h <- strptime("2007-02-03 00:00:01", format="%Y-%m-%d %H:%M:%S" )
  p2<-ggplot(PowDat, aes(x=fullDate, y=Sub_metering_1 )) +
    geom_line(aes(xmax=box_h, ymax=38 )) +
    geom_line(data=PowDat, aes(y=Sub_metering_2 ), color="red" ) +
    geom_line(data=PowDat, aes(y=Sub_metering_3 ), color="blue" ) +
    xlab("" ) +
    coord_cartesian(ylim=c(0,40 )) +
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    scale_y_continuous("Energy sub metering" ,breaks=c(0,10,20,30 )) +
    geom_segment(aes(x=ann_x_start, 
                     xend=ann_x_end-300, 
                     y=32, 
                     yend=32 ), 
                 color="blue" ) + 
    annotate("text", 
             label="Sub_metering_3", 
             y=32, 
             x=ann_x_end, 
             hjust=0, 
             size=3 ) + 
    geom_segment(aes(x=ann_x_start, 
                     xend=ann_x_end-300, 
                     y=35, 
                     yend=35 ), 
                 color="red" ) + 
    annotate("text", 
             label="Sub_metering_2", 
             y=35, 
             x=ann_x_end, 
             hjust=0, 
             size=3 ) +
    geom_segment(aes(x=ann_x_start, xend=ann_x_end-300, y=38, yend=38 )) + 
    annotate("text", 
             label="Sub_metering_1", 
             y=38, 
             x=ann_x_end, 
             hjust=0, 
             size=3 ) + 
    geom_segment(aes(x=box_vert,xend=box_vert, y=40, yend=29 ), size=.25 ) +
    geom_segment(aes(x=box_vert, xend=box_h, y=29, yend=29 ), size=.25 ) +
    theme(legend.position="none" ) +
    theme_bw(base_size=10 )
  
    return(p2 )
}

plot3 <-function(){ 
  p3<-ggplot(PowDat, aes(x=fullDate, y=Voltage )) +
    geom_line() + 
    xlab("datetime" ) + 
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    scale_y_continuous("Voltage" ,breaks=c(234,238,242,246 )) +
    theme(legend.position="none" ) +
    theme_bw(base_size=10 )
  return(p3 )
}

plot4 <-function(){ 
  p4<-ggplot(PowDat, aes(x=fullDate, y=Global_reactive_power )) +
    geom_line() + 
    ylab("Global_reactive_power" ) +
    xlab("datetime" ) + 
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    theme(legend.position="none") +
    theme_bw(base_size=10 )
  return(p4 )
}

if(file.exists("plot4.png" )){  
  print("plot4.png already exists: plot4.R done" )
  return(TRUE )
  } else {  
  dataName <- "PowDat"
  if(!(dataName %in% ls())) { 
    print("data table not loaded: getting data" )
    source(paste0(getwd(), "/loadPowr.R" ))
  } 

  multiplot(plot1(), plot2(), plot3(), plot4(), cols=2 )
  dev.copy(png, file = "plot4.png" )
  dev.off()
}