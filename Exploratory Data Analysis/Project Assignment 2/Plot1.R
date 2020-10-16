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
## Aggregate the sum of Emissions per year and source
NEI$Emissions <- as.integer(NEI$Emissions)
sumNEI <- aggregate(NEI$Emissions, list(NEI$year), sum, na.rm = TRUE)
## Rename properly the col names
colnames(sumNEI) <- c("Year", "Tot_Emission")
sumNEI$Year <- as.factor(sumNEI$Year)
str(sumNEI)
## Plot with basic graphic
par(mfrow=c(1,1))
png(file = "plot1.png",
    width = 480,
    height = 480)
## Barplot selected to better visualize the trend
## Measure adjusted to `Tons` from `Grams`
barplot(
    (sumNEI$Tot_Emission)/10^6,
    names.arg= sumNEI$Year,
    xlab="Year",
    ylab="PM2.5 Emissions (Tons)",
    main="Total PM2.5 Emissions From All US Sources (Tons)")
dev.off()
