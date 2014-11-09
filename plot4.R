#Script plot4.R
# Dave Kenny.  Exploratory Data Analysis Assignment 1, Nov 2014.

targFile <- "figure/plot4.png"

library(ggplot2 )
library(scales )
source("multiplot.R" )

plot1 <-function(){          ## Function to plot global active power for UL
  p1 <- ggplot(powDat, aes(x=fullDate, y=Global_active_power )) +
    geom_line() + 
    ylab("Global Active Power" ) +
    xlab("" ) + 
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    theme(legend.position="none" ) +
    theme_bw(base_size=7 )
  return(p1 )
}

plot2 <-function(){          ## Function to plot sub metering LL
  p2 <- ggplot(powDat, aes(x=fullDate, y=Sub_metering_1 )) +
    geom_line(aes(xmax = strptime("2007-02-03 00:00:01", 
                                  format="%Y-%m-%d %H:%M:%S" ), 
                  ymax=38 )) +
    geom_line(data=powDat, aes(y=Sub_metering_2 ), color="red" ) +
    geom_line(data=powDat, aes(y=Sub_metering_3 ), color="blue" ) +
    xlab("" ) +
    coord_cartesian(ylim=c(0,40 )) +
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    scale_y_continuous("Energy sub metering" ,breaks=c(0,10,20,30 )) +
    geom_segment(aes(x=strptime("2007-02-02 10:00:00", 
                                format="%Y-%m-%d %H:%M:%S" ), 
                     xend=strptime("2007-02-02 11:40:00", 
                                   format="%Y-%m-%d %H:%M:%S" )-300, 
                     y=32, 
                     yend=32 ), 
                 color="blue" ) + 
    annotate("text", 
             label="Sub_metering_3", 
             y=32, 
             x=strptime("2007-02-02 11:40:00", 
                        format="%Y-%m-%d %H:%M:%S" ), 
             hjust=0, 
             size=2 ) + 
    geom_segment(aes(x=strptime("2007-02-02 10:00:00", 
                                format="%Y-%m-%d %H:%M:%S" ), 
                     xend=strptime("2007-02-02 11:40:00", 
                                   format="%Y-%m-%d %H:%M:%S" )-300, 
                     y=35, 
                     yend=35 ), 
                 color="red" ) + 
    annotate("text", 
             label="Sub_metering_2", 
             y=35, 
             x=strptime("2007-02-02 11:40:00", 
                        format="%Y-%m-%d %H:%M:%S" ), 
             hjust=0, 
             size=2 ) +
    geom_segment(aes(x=strptime("2007-02-02 10:00:00", 
                                format="%Y-%m-%d %H:%M:%S" ), 
                     xend=strptime("2007-02-02 11:40:00", 
                                   format="%Y-%m-%d %H:%M:%S" )-300, 
                     y=38, 
                     yend=38 )) + 
    annotate("text", 
             label="Sub_metering_1", 
             y=38, 
             x=strptime("2007-02-02 11:40:00", 
                        format="%Y-%m-%d %H:%M:%S" ), 
             hjust=0, 
             size=2 ) + 
    geom_segment(aes(x=strptime("2007-02-02 09:30:00", 
                                format="%Y-%m-%d %H:%M:%S" ),
                     xend=strptime("2007-02-02 09:30:00", 
                                   format="%Y-%m-%d %H:%M:%S" ), 
                     y=40, 
                     yend=29 ), 
                 size=.25 ) +
    geom_segment(aes(x=strptime("2007-02-02 09:30:00", 
                                format="%Y-%m-%d %H:%M:%S" ), 
                     xend = strptime("2007-02-03 00:00:01", 
                                     format="%Y-%m-%d %H:%M:%S" ), 
                     y=29, 
                     yend=29 ), 
                 size=.25 ) +
    theme(legend.position="none" ) +
    theme_bw(base_size=10 )
  return(p2 )
}

plot3 <-function(){          ## Function to plot voltage for UR
  p3 <- ggplot(powDat, aes(x=fullDate, y=Voltage )) +
    geom_line() + 
    xlab("datetime" ) + 
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    scale_y_continuous("Voltage", breaks=c(234,238,242,246 )) +
    theme(legend.position="none" ) +
    theme_bw(base_size=10 )
  return(p3 )
}

plot4 <-function(){          ## Function to plot global reactive power for LR
  p4 <- ggplot(powDat, aes(x=fullDate, y=Global_reactive_power )) +
    geom_line() + 
    ylab("Global_reactive_power" ) +
    xlab("datetime" ) + 
    scale_x_datetime(breaks = date_breaks("1 day" ), 
                     labels=date_format(format="%a" )) +
    theme(legend.position="none") +
    theme_bw(base_size=10 )
  return(p4 )
}

if(file.exists(targFile )){            ## Quits if the png file already present
  print("plot4.png already exists: plot4.R done" )
  return(TRUE )
} else {  
  dataName <- "powDat"
  if(!(dataName %in% ls())) {                   ## If data not loaded, read
    print("data table not loaded: getting data")## from file.
    source(paste0(getwd(), "/loadPowr.R" ))
  } 
  
  multiplot(plot1(), plot2(), plot3(),           ## Plots to screen  
            plot4(), cols=2 )         
  dev.copy(png, width=480, height=480, file = targFile )
  dev.off()
  
  rm(dataName, targFile, multiplot, plot1,       ## Cleanup variables
     plot2, plot3, plot4, powDat )               ## and functions
}