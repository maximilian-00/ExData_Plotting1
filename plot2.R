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
## Plot 2
Sys.setlocale("LC_TIME","English") # change to English weekdays, instead of German ;)
dateTime <- strptime(paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
activePower <- as.numeric(householdPowerConsumption$Global_active_power)

png("plot2.png", width = 480, height = 480)
plot(dateTime, activePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
