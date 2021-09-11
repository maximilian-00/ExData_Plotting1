# 1. Prepare data
## Download and read data 
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "Electric Power Consumption"

if (!file.exists(zipFile)) {
        download.file(zipUrl, zipFile, mode = "wb")
}


householdPowerConsumption <- read.table("household_power_consumption.txt", 
                                        header = T, sep = ";", 
                                        stringsAsFactors = F, dec = ".")

## Extract data for selected dates
firstFeb <- householdPowerConsumption[householdPowerConsumption$Date == "1/2/2007",]
secondFeb <- householdPowerConsumption[householdPowerConsumption$Date == "2/2/2007",]

## Create data set containing selected dates only
householdPowerConsumption <- rbind(firstFeb, secondFeb)
rm(firstFeb, secondFeb)


# 2. Plot data
## Plot 4
Sys.setlocale("LC_TIME","English") # change to English weekdays, instead of German ;)
dateTime <- strptime(paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
## data for plot 1
activePower <- as.numeric(householdPowerConsumption$Global_active_power)

## data for plot 2
Sub_metering_1 <- as.numeric(householdPowerConsumption$Sub_metering_1)
Sub_metering_2 <- as.numeric(householdPowerConsumption$Sub_metering_2)
Sub_metering_3 <- as.numeric(householdPowerConsumption$Sub_metering_3)

## data for plot 3
voltage <- as.numeric(householdPowerConsumption$Voltage)

## data for plot 4
reactivePower <- as.numeric(householdPowerConsumption$Global_reactive_power)


## Create PNG
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2), mar = c(4,4,2,2))
## plot 1
plot(dateTime, activePower, type="l", xlab="", ylab="Global Active Power")
## plot 2
plot(dateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dateTime, Sub_metering_2, col = "red")
lines(dateTime, Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, lwd = 1, cex = 0.9)
## plot 3
plot(dateTime, voltage, type="l", xlab="", ylab="Voltage")
## plot 4
plot(dateTime, reactivePower, type = "l", xlab = "", ylab = "Global_reactive_power")
dev.off()
