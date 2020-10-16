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
## Aggregate the sum of Emissions per year and source
NEI$Emissions <- as.integer(NEI$Emissions)
typeNEI <- aggregate(NEI$Emissions[NEI$fips == "24510"], list(NEI$year[NEI$fips == "24510"],NEI$type[NEI$fips == "24510"]), sum, na.rm = TRUE)
## Rename properly the col names
colnames(typeNEI) <- c("Year","Type", "Tot_Emission")
typeNEI$Year <- as.factor(typeNEI$Year)
str(sumNEI)
## Plot with ggplot
png(file = "plot4.png",
    width = 480,
    height = 480)
## Barplot selected to better visualize the trend
## Measure adjusted to `Kg` from `Grams`
## Set stat to `identity` to override the the count with the value of the sum
ggplot(data = typeNEI, aes(x = Year, y = Tot_Emission/10^3, fill = Type))+
    geom_bar(stat = "identity")+
    facet_grid(.~Type)+
    labs(x="Years", y= "Emissions (Kg)")+ 
    labs(title = expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))+
    theme_bw()+
    geom_line(data = typeNEI, aes(x = Year, y = Tot_Emission/10^3, group = 1), lwd = .5, alpha = 1/3)+
    geom_text(aes(label = Tot_Emission/10^3), position = position_dodge(0.9), vjust = -.2, size = 3)+
    theme(axis.text.x = element_text(angle=45))
dev.off()
