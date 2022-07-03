##Script for creating Plot 3

##Read file
powerdata <- read.table("./power_consumption/household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

##Select pertinent dates
powerdata_subset <- subset(powerdata, Date %in% c("1/2/2007", "2/2/2007"))

##Transform dates and time
dateTimes <- strptime(paste(powerdata_subset$Date, powerdata_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerdata_dates <- mutate(powerdata_subset, Time=dateTimes)
powerdata_dates <- rename(powerdata_dates, Date_time = Time)
power <- select(powerdata_dates, Date_time:Sub_metering_3)

##Create plot
with(power, plot(Date_time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(power, lines(Date_time, Sub_metering_2, type="l", col="red"))
with(power, lines(Date_time, Sub_metering_3, type="l", col="blue"))
legend("topright", col = c("black", "red", "blue"), lty=1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Copy to PNG file
dev.copy(png, file="plot3.png")

##Close graphics devise
dev.off()