##Downloads dataset into a file

setwd("C:/Users/Darryl/Desktop/JHU Coursera Data Science")
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

##Read the data into R:

library(tidyverse)

hpc <- read_csv2("./data/household_power_consumption.txt", na = "?")

##Convert Date variable into date format:

hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")

##Subset the data to the 2007-02-01 and 2007-02-02 dates:

hpcdate <- filter(hpc, Date == "2007/02/01" | Date == "2007/02/02")

##Create date-time column and convert sub-metering variables to numeric:

hpcdate$DateTime <- with(hpcdate, as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M"))
hpcdate$Sub_metering_1 <- as.numeric(hpcdate$Sub_metering_1)
hpcdate$Sub_metering_2 <- as.numeric(hpcdate$Sub_metering_2)
hpcdate$Sub_metering_3 <- as.numeric(hpcdate$Sub_metering_3)

##Create the plot and add the submetering lines:

plot(hpcdate$DateTime, hpcdate$Sub_metering_1, type = "n",xlab = "", ylab ="Energy sub metering")
lines(hpcdate$DateTime, hpcdate$Sub_metering_1, col = "black")
lines(hpcdate$DateTime, hpcdate$Sub_metering_2, col = "red")
lines(hpcdate$DateTime, hpcdate$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red","blue"), lty = c(1,1,1))

## Save plot to PNG file

dev.print(png, file = "plot3.png", width = 480, height = 480, unit = "px")

