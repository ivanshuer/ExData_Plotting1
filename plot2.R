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

png("plot2.png")

plot(power_data$Date_Time, power_data$Global_active_power, 
     type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()