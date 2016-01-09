rm(list = ls())
##Set directory
setwd("/Users/SaBui/datasciencecoursera")
##Reading a subset of the data into R
time1 <- as.Date("02/01/2007", format = "%m/%d/%Y")
time2 <- as.Date("02/03/2007", format = "%m/%d/%Y")
## read.table identifies the row num by grep and skip that many lines by nrow
data<-read.table("household_power_consumption.txt",sep = ";", skip=(grep("1/2/2007", readLines("household_power_consumption.txt"))-1),nrows=(difftime(time2, time1, units = "mins")))
table(data$V1)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2”, 
		  “Sub_metering_3)

##create plot 1 and save it in current directory
png(file = "plot1.png") ##open png device
with(data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)"))
dev.off() ##close png device
