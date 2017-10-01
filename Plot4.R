
# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Reading the file:
library(readr)
library(dplyr)
HPC <- read_delim("./data/household_power_consumption.txt", ";", escape_double = FALSE, trim_ws = TRUE)
HPC$Date <- as.Date(HPC$Date, "%d/%m/%Y")

#subsetting the needed data for 2007-02-01 and 2007-02-02
hpc <- HPC[HPC$Date == "2007-02-01" | HPC$Date == "2007-02-02",]
head(hpc)

#combining Date and Time as a single variable
hpc$DateAndTime <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S")

#Setting the parameter
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1))

#Plot 4a: Global Active Power
plot(hpc$DateAndTime, hpc$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")

#Plot 4b: Energy sub meter
plot(hpc$DateAndTime, hpc$Sub_metering_1, type = "l", ylab = "Energy sub meter", xlab = " ")
lines(hpc$DateAndTime, hpc$Sub_metering_2, col= "red")
lines(hpc$DateAndTime, hpc$Sub_metering_3, col= "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1:2, cex = 0.75)

#Plot 4c: voltage and daytime
plot(hpc$DateAndTime, hpc$Voltage, type = "l", ylab = "Voltage", xlab = "daytime")

#Plot 4d: Global Reactive Power
plot(hpc$DateAndTime, hpc$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "daytime")
