rm(list = ls())
setwd("/Users/SaBui/datasciencecoursera")
##Reading a subset of the data into R
time1 <- as.Date("02/01/2007", format = "%m/%d/%Y")
time2 <- as.Date("02/03/2007", format = "%m/%d/%Y")
## read.table identifies the row num by grep and skip that many lines by nrow
data<-read.table("household_power_consumption.txt",sep = ";", skip=(grep("1/2/2007", readLines("household_power_consumption.txt"))-1),nrows=(difftime(time2, time1, units = "mins")))
table(data$V1)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                 "Sub_metering_3")

##create plot 4 and save it in current directory
data$datetime <- paste(data$Date, data$Time)
lapply(data$datetime, strptime, format = "%d/%m/%Y %H:%M:%S")
data$datetime <- as.POSIXlt(data$datetime,format = "%d/%m/%Y %H:%M:%S", tz = "") 
class(data$datetime)
data$Time <- strptime(data$Time, format = "%H:%M:%S", tz = "")
class(data$Time)
png(file = "plot4.png") ##open png device
par(mfrow = c(2,2), mar = c(5,4,2,1), oma=c(0,0,0,0))
plot(data$datetime, data$Global_active_power,type= "l",xlab = "", ylab = "Global Active Power")
plot(data$datetime, data$Voltage,type= "l",xlab = "datetime", ylab = "Voltage")
plot(data$datetime, data$Sub_metering_1,type= "l",xlab = "", ylab = "Energy sub metering")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright",lty = 1, col= c("black", "blue", "red"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
plot(data$datetime, data$Global_reactive_power,type= "l",xlab = "datetime", ylab = "Global_reactive_power")
dev.off() ##close png device
