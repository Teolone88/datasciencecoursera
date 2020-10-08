library(zip)
library(sqldf)
library(lubridate)
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

##*************************************************************************************************
## I had to use the basic plot system as ggplot2 doesn't respond well with preserving in multiplot
##*************************************************************************************************

## Plot 1 with basic plot
png(file = "plot1.png",
    width = 480,
    height = 480)
hist(Data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

## Plot 2 with basic plot
png(file = "plot2.png",
    width = 480,
    height = 480)
plot(Data$DateTime, Data$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", type="l")
dev.off()

## Plot 3 with basic plot
png(file = "plot3.png",
    width = 480,
    height = 480)
plot(Data$DateTime,Data$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(Data$DateTime,Data$Sub_metering_2, col="red", type="l")
points(Data$DateTime,Data$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(Data[,7:9]))
dev.off()
## Plot 4a with basic plot
png(file = "plot4a.png",
    width = 480,
    height = 480)
plot(Data$DateTime,Data$Voltage, ylab="Voltage", xlab="datetime", type="l")
dev.off()
# Plot 4b with basic plot
png(file = "plot4b.png",
    width = 480,
    height = 480)
plot(Data$DateTime,Data$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
dev.off()
# Multiple plot 2,3,4a,4b
png(file = "plot4.png",
    width = 480,
    height = 480)
par(mfcol=c(2,2), mar=c(4.5,5,2,2))
## 2nd
plot(Data$DateTime, Data$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", type="l")
## 3rd
plot(Data$DateTime,Data$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(Data$DateTime,Data$Sub_metering_2, col="red", type="l")
points(Data$DateTime,Data$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(Data[,7:9]))
## 4th (a,b)
plot(Data$DateTime,Data$Voltage, ylab="Voltage", xlab="datetime", type="l")
plot(Data$DateTime,Data$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
dev.off()

##*******************************************************************************************************
## Below code execute the same, however, for the multiplot the legenda is not resizing due to ggplot2 bug
##*******************************************************************************************************

## Plot 1 with ggplot2
png(file = "plot1.png",
    width = 480,
    height = 480)
plot1 <- with(
    Data,
    hist(
        Global_active_power,
        main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)",
        col = "red"
    )
)
dev.off()

## Plot 2 with ggplo2
png(file = "plot2.png",
    width = 480,
    height = 480)
plot2 <- ggplot(data = Data, aes(x = DateTime,
                        y = Global_active_power)) +
    geom_line() +
    labs(x = "", y = "Global Active Power (Kilowatts)") +
    scale_x_datetime(date_breaks = 'day',
                     date_labels = '%a') +
    theme(panel.border = element_rect(
        colour = "black",
        fill = NA,
        size = 1),
        panel.background = element_rect(fill = "transparent"))
dev.off()

## Plot 3 with ggplot2
png(file = "plot2.png",
    width = 480,
    height = 480)
plot3 <- ggplot(data = Data[, 7:10] , aes(x = DateTime)) +
    geom_line(mapping = aes(y = Sub_metering_1, col = "black")) +
    geom_line(mapping = aes(y = Sub_metering_2, col = "red")) +
    geom_line(mapping = aes(y = Sub_metering_3, col = "blue")) +
    labs(x = "", y = "Energy sub metering") +
    scale_x_datetime(date_breaks = 'day',
                     date_labels = '%a') +
    scale_colour_manual(
        values = c("black", "red", "blue"),
        labels = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    ) +
    theme(
        panel.background = element_rect(fill = "transparent"),
        # bg of the panel
        ##plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
        panel.grid.major = element_blank(),
        # get rid of major grid
        ##panel.grid.minor = element_blank(), # get rid of minor grid
        legend.background = element_rect(fill = "transparent"),
        # get rid of legend bg
        ##legend.box.background = element_rect(fill = "transparent"),
        # get rid of legend panel bg
        legend.position = c(1, 1),
        legend.justification = c("right", "top"),
        ##legend.box.just = "right",
        ##legend.margin = margin(1, 1, 1, 3),
        panel.border = element_rect(
            colour = "black",
            fill = NA,
            size = 1),
        legend.title = element_blank(),
        ##legend.text = element_text(size = 6),
        ##legend.spacing.y = unit(1, 'cm') +
        ##guides(shape = guide_legend(override.aes = list(size = 1)))    
    )
dev.off()

## Plot 4a with ggplot2
png(file = "plot2.png",
    width = 480,
    height = 480)
plot4a <- ggplot(data = Data, aes(x = DateTime,
                                 y = Global_reactive_power)) +
    geom_line() +
    labs(x = "datetime", y = "Global Reactive Power") +
    scale_x_datetime(date_breaks = 'day',
                     date_labels = '%a') +
    theme(panel.border = element_rect(
        colour = "black",
        fill = NA,
        size = 1),
        panel.background = element_rect(fill = "transparent"))
dev.off()

## Plot 4b with ggplot2
png(file = "plot2.png",
    width = 480,
    height = 480)
plot4b <- ggplot(data = Data, aes(x = DateTime,
                                   y = Voltage)) +
    geom_line() +
    labs(x = "datetime", y = "Voltage") +
    scale_x_datetime(date_breaks = 'day',
                     date_labels = '%a') +
    theme(panel.border = element_rect(
        colour = "black",
        fill = NA,
        size = 1),
        panel.background = element_rect(fill = "transparent"))
dev.off()

