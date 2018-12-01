##Downloads dataset into a file

setwd("C:/Users/Darryl/Desktop/JHU Coursera Data Science")
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

##Read the data into R

library(tidyverse)

hpc <- read_csv2("./data/household_power_consumption.txt", na = "?")

##Convert Date variable into date format; Global active power into numeric

hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)

##Subset the data to the 2007-02-01 and 2007-02-02 dates

hpcdate <- filter(hpc, Date == "2007/02/01" | Date == "2007/02/02")

##Create date-time column

hpcdate$DateTime <- with(hpcdate, as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M"))

##Create the plot:

plot(hpcdate$DateTime, hpcdate$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)",
     xlab = "", main = "Global Active Power (kilowatts)")
with(hpcdate, lines(DateTime, Global_active_power))

## Save plot to PNG file

dev.print(png, file = "plot2.png", width = 480, height = 480, unit = "px")

