# 1. Prepare data
## Download and read data 
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "Electric Power Consumption"

if (!file.exists(zipFile)) {
        download.file(zipUrl, zipFile, mode = "wb")
}


householdPowerConsumption <- read.table("household_power_consumption.txt", 
                                        header = T, sep = ";")

## Extract data for selected dates
firstFeb <- householdPowerConsumption[householdPowerConsumption$Date == "1/2/2007",]
secondFeb <- householdPowerConsumption[householdPowerConsumption$Date == "2/2/2007",]

## Create data set containing selected dates only
householdPowerConsumption <- rbind(firstFeb, secondFeb)
rm(firstFeb, secondFeb)


# 2. Plot data
## Plot 1

png(filename = "plot1.png", width = 480, height = 480)

hist(householdPowerConsumption$Global_active_power, 
     col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()


     