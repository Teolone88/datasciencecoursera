library(ggplot2)

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
## Merge NEI and SIC by SCC
mergeNEI <- merge(NEI, SCC, by = "SCC")
## Isolate observations that contains Coal in SCC.Level.Four
coalNEI <- grep("[Cc]oal", mergeNEI$SCC.Level.Four)
mergeNEI1 <- mergeNEI[coalNEI,]
## Aggregate the sum of Emissions per year and source
mergeNEI1$Emissions <- as.integer(mergeNEI1$Emissions)
sumNEI <- aggregate(mergeNEI1$Emissions, list(mergeNEI1$year), sum, na.rm = TRUE)
## Rename properly the col names
colnames(sumNEI) <- c("Year","Tot_Emission")
sumNEI$Year <- as.factor(sumNEI$Year)
str(sumNEI)
## Plot with ggplot
png(file = "plot5.png",
    width = 480,
    height = 480)
## Barplot selected to better visualize the trend
## Measure adjusted to `Kg` from `Grams`
## Set stat to `identity` to override the the count with the value of the sum
ggplot(data = sumNEI, aes(x = Year, y = Tot_Emission/10^3))+
    geom_bar(stat = "identity", fill = "lightblue")+
    labs(x="Years", y= "Emissions (Kg)")+ 
    labs(title = expression("PM"[2.5]*" Emissions, in US from 1999-2008 by Coal based combustion"))+
    theme_bw()+
    geom_text(aes(label = Tot_Emission/10^3), position = position_dodge(0.9), vjust = -.3, size = 3)
dev.off()
