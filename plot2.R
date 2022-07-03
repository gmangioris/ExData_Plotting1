##Script for creating Plot 2

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
with(power, plot(Date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

##Copy to PNG file
dev.copy(png, file="plot2.png")

##Close graphics devise
dev.off()