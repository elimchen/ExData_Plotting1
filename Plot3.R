  File <- "./data/household_power_consumption.txt"
  
  require(data.table)
   
  DayRange <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
  num_Row <- as.numeric(DayRange)
  
  system.time(DT <- fread(File, sep=";", nrows=num_Row, header=F, na.strings=c("?"," "),
        skip="1/2/2007"))
  
  setnames(DT,c("V1", "V2","V3","V4","V5", "V6","V7", "V8","V9"),
           c("Date", "Time","Global_active_power", 
    "Global_reactive_power","Voltage", "Global_intensity",
    "Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
    
  DT$Date <- as.Date(DT$Date,format = '%d/%m/%Y')
    
  head(DT)
 
  png(filename = "plot3.png",
      width = 480, height = 480, units = "px", pointsize = 12,
      bg = "transparent", res = NA, family = "", restoreConsole = TRUE)
  
  library(datasets)
  
  DT$DateTime <- as.POSIXct(paste(DT$Date, DT$Time), format="%Y-%m-%d %H:%M:%S") 
  
  attach(DT)
  
  par(mar = c(4, 4, 3, 1))
  
  plot(DateTime,Sub_metering_1,xlab = "",ylab = "Energy Sub Metering",type = "l",col = "black",
       lwd = 1,ylim = range(Sub_metering_1,Sub_metering_2,Sub_metering_3),
       cex.lab = 1,cex.axis = 1, bg="black")
  
  par(new=TRUE)
  plot(DateTime,Sub_metering_3,axes = FALSE, xlab = "", ylab = "",type = "l",col = "blue",
  lwd = 1,ylim = range(Sub_metering_1,Sub_metering_2,Sub_metering_3))
  
  par(new=TRUE)
  plot(DateTime,Sub_metering_2,axes = FALSE, xlab = "", ylab = "",type = "l",
  col = "red",lwd = 1,ylim = range(Sub_metering_1,Sub_metering_2,Sub_metering_3))
       
  legend("topright",col=c("black","red","blue"),lty=1,
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex = 1)
  
   
  detach(DT)
  dev.off()


  