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
fipsNEI <- aggregate(NEI$Emissions[NEI$fips == "24510"], list(NEI$year[NEI$fips == "24510"]), sum, na.rm = TRUE)
## Rename properly the col names
colnames(fipsNEI) <- c("Year", "Tot_Emission")
fipsNEI$Year <- fipsNEI$Year[order(fipsNEI$Year)]
str(sumNEI)
## Plot with basic graphic
par(mfrow=c(1,1))
png(file = "plot2.png",
    width = 480,
    height = 480)
## Barplot selected to better visualize the trend
## Measure adjusted to `Kg` from `Grams`
barplot(
    (fipsNEI$Tot_Emission)/10^3,
    names.arg= fipsNEI$Year,
    xlab="Year",
    ylab=expressions("PM"[2.5]*" Emissions (Kg)"),
    ylim=c(0.0,3.5),
    main=expression("Total PM"[2.5]*" Emissions From Baltimore City, Maryland"))
dev.off()
