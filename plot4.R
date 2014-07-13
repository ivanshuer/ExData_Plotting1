# Reading data
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))

power_data <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, 
                         nrows = 300000, header = TRUE, sep = ";", 
                         colClasses = c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                         na.strings = c("NA", "", "?"))

date_time <- paste(power_data$Date , power_data$Time)
date_time <- strptime(date_time, "%Y-%m-%d %H:%M:%S")

power_data$Date <- date_time
power_data$Time <- NULL
colnames(power_data) <- c("Date_Time", colnames(power_data)[-1])

startDate <- strptime(c("2007-02-01 00:00:00"), "%Y-%m-%d %H:%M:%S")
endDate <- strptime(c("2007-02-03 00:00:00"), "%Y-%m-%d %H:%M:%S")

power_data <- subset(power_data, Date_Time >= startDate & Date_Time < endDate)

# Generating Plot

png("plot4.png")

par(mfrow=c(2,2))

plot(power_data$Date_Time, power_data$Global_active_power,
     type = "l", ylab = "Global Active Power", xlab = "")

plot(power_data$Date_Time, power_data$Voltage,
     type = "l", ylab = "Voltage", xlab = "datetime")
     
plot(power_data$Date_Time, power_data$Sub_metering_1, 
     type = "l", ylab = "Energy sub metering", xlab = "")
lines(power_data$Date_Time, power_data$Sub_metering_2, col="red")
lines(power_data$Date_Time, power_data$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, box.lty = 0, bg = "transparent", col = c("black", "red", "blue"))

plot(power_data$Date_Time, power_data$Global_reactive_power,
     type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
