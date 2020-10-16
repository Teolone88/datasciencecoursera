
Sys.setlocale("LC_ALL", "English")
## Download file best practice
##if (!file.exists("./downloaded_files")) {
##    dir.create("./dowloaded_files")
##}
## Download zip file
fileUrl <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./exdata%2Fdata%2FNEI_data.zip", mode = "wb")
## Unzip file
unzip(
    "./exdata%2Fdata%2FNEI_data.zip",
    exdir = "./Unzipped"
)
## Read tables from unzipped RDS files
NEI <- readRDS("./Unzipped/summarySCC_PM25.rds")
SCC <- readRDS("./Unzipped/Source_Classification_Code.rds")
## Isolate motor vehicle sources
## Identified `Mobile` word pattern for motor vehicles
unique(SCC$EI.Sector)
## Merge NEI and SCC by SCC
mergeNEI <- merge(NEI, SCC, by = "SCC")
colnames(mergeNEI)
## Isolate columns of interest
mergeNEI0 <- mergeNEI[,c(1,2,4,6,9)]
## Rename properly the col names
colnames(mergeNEI0) <- c("SCC","County", "Emission","Year","Application")
mergeNEI0$Year <- as.factor(mergeNEI0$Year)
## Isolate motor vehicles from Application with thee word `Mobile`
motorNEI <- grep("[Mm]obile", mergeNEI0$Application)
motorNEI <- mergeNEI0[motorNEI,]
## Aggregate the sum of Emissions per year and source for Baltimore in Los Angeles
motorNEI$Emission <- as.integer(motorNEI$Emission)
motorNEIagg <- aggregate(motorNEI$Emission[motorNEI$County == "06037"], list(motorNEI$Year[motorNEI$County == "06037"]), sum, na.rm = TRUE)
## Rename after aggregation
colnames(motorNEIagg) <- c("Year", "Emission")
## Plot with ggplot
par(mfrow=c(1,2))
png(file = "plot5.png",
    width = 480,
    height = 480)
## Barplot selected to better visualize the trend
## Measure adjusted to `Kg` from `Grams`
barplot(
    (motorNEIagg$Emission)/10^3,
    names.arg= motorNEIagg$Year,
    xlab="Year",
    ylab="PM2.5 Emissions (Kg)",
    main=expression("Baltimore motor vehicles")
dev.off()
