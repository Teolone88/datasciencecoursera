library(zip)
library(data.table)
library(sqldf)
library(lubridate)
library(lattice)
library(ggplot2)
library(dplyr)
library(patchwork)

Sys.setlocale("LC_ALL", "English")
## Download file best practice
if (!file.exists("./downloaded_files")) {
    dir.create("./dowloaded_files")
}
## Download zip file
fileUrl <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "C:/Users/Teo/Documents/R/datasciencecoursera/exdata%2Fdata%2Fhousehold_power_consumption.zip", mode = "wb")
## Unzip file
unzip(
    "C:/Users/Teo/Documents/R/datasciencecoursera/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    exdir = "C:/Users/Teo/Documents/R/datasciencecoursera/"
)
## Read subset of table
fileDir <-
    "C:/Users/Teo/Documents/R/datasciencecoursera/household_power_consumption.txt"
fileCon <- file(fileDir)
Data <-
    sqldf(
        "select * from fileCon where Date = '1/2/2007' or Date = '2/2/2007'",
        file.format = list(header = T, sep = ";")
    )
## Close connection
close(fileCon)
## Explore sample table
head(Data)
str(head(Data))
## Replace missing values from ? to NA
replace(Data, Data == "?", "NA")
## Convert chr Date and Time in separate date variable
Data$DateTime <-
    as_datetime(paste(
        strptime(Data$Date, "%d/%m/%Y"),
        format(strptime(Data$Time, "%H:%M:%S"), "%H:%M:%S")
    ))
    
## Plot 3 with basic plot
png(file = "plot3.png",
    width = 480,
    height = 480)
plot(Data$DateTime,Data$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(Data$DateTime,Data$Sub_metering_2, col="red", type="l")
points(Data$DateTime,Data$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(Data[,7:9]))
dev.off()
