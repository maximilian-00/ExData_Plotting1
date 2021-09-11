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


# 3. Plot data
## Plot 3       
Sys.setlocale("LC_TIME","English") # change to English weekdays, instead of German ;)
dateTime <- strptime(paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Sub_metering_1 <- as.numeric(householdPowerConsumption$Sub_metering_1)
Sub_metering_2 <- as.numeric(householdPowerConsumption$Sub_metering_2)
Sub_metering_3 <- as.numeric(householdPowerConsumption$Sub_metering_3)

png("plot3.png", width = 480, height = 480)
plot(dateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dateTime, Sub_metering_2, col = "red")
lines(dateTime, Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, lwd = 1)
dev.off()
