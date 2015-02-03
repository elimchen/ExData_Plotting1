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
  DT$DateTime <- as.POSIXct(paste(DT$Date, DT$Time), format="%Y-%m-%d %H:%M:%S")   
  
  png(filename = "plot2.png",
      width = 480, height = 480, units = "px", pointsize = 12,
      bg = "transparent", res = NA, family = "", restoreConsole = TRUE)
  
  
  
  attach(DT)
  par(mar = c(4, 3.8, 3, 1)) 
  plot(DT$DateTime,Global_active_power,xlab = "", col = "gray32",
       ylab = "Global Active Power (kilowatts)",type = "l",lwd = 1.75)
  
  box(col = "grey" ,lwd = 2)
  axis(2, col = "bisque4",lwd = 2)
   
 
  detach(DT)
  dev.off()


