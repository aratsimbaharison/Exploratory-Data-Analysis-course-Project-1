# Dowloading the dataset from UCI Machine Learning Repository
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

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

#Code for Plot 2
plot(hpc$DateAndTime, hpc$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")

#Creation of plot 2 in png format
png(filename="plot2.png")
plot(hpc$DateAndTime, hpc$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")
dev.off()

