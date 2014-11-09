ExploratoryDataAnalysis
=======================

Coursera Exploratory Data Course 

R programming files for generating various plots for assignment 1.

Directory named "figure" contains graphics files 1-4 in png format.

R files are

loadPowr.R -- As needed, downloads file from internet location, unzips archive 
              and reads into data structure.  Modifies structure, and loads 
              R libraries.

mulitiplot.R -- Copied from internet source, script creates multiple ggplot2 
                graphics on a single display device.

plot[1-4].R -- Scripts do not execute if designated plot[1-4].png file is 
               already present.  If data structure is not loaded in environment
               or if data file is not in present directory, uses loadPowr.R to
               get them.  plot1 and plot2 use basic plotting functions.  plot3
               and plot4 use ggplot2 functions.  
