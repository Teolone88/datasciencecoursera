### Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?
```{r}
library("data.table")
communities <- data.table::fread("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
## Split names on charachter "wgtp"
DataSplit <- strsplit(names(Data),"wgtp",fixed = T)
DataSplit[[123]]
```
### Question 2
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

```{R}
## Load GDP for 190 countries
setwd("C:/Users/Teo/Documents/R/courseradatascience")
if(!file.exists("./courseradatascience")){dir.create("./courseradatascience")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile = "./courseradatascience/FGDP.csv", method = "curl")
Data2 <- read.csv("./courseradatascience/FGDP.csv")
names(Data2)
## Convert in data.table for the frea function
library(data.table)
## Convert data.frame into data.table
## And reach the last row
Data2 <- fread("FGDP.csv",
               nrows = 190, 
               skip = 5, 
               col.names = c("CCode","Rank","Country","Total"),
               select = c(1,2,4,5))
               
## Load stringr library
library(stringr)
library(dplyr)
## Remove "," from values that reach the million value and average them
Data2$Total <- Data2$Total %>%
    gsub(pattern = ",",replacement = "",x = Data2$Total)
## Find average
mean(as.numeric(Data2_Mil$Total), na.rm = T)
## Different outcome from the original table!
```
Question 4
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table http://data.worldbank.org/data-catalog/ed-stats
```{r}
library(data.table)

FGDP <- fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
               nrows = 190, 
               skip = 5, 
               col.names = c("CCode","Rank","Country","Total"),
               select = c(1,2,4,5))

FEDSTATS <- fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

## Merge FGDP & FEDSTATS tables by country code
FGDPSTATS <- merge(FGDP,FEDSTATS,by.x = "CCode",by.y = "CountryCode")
FY <- grep("^fiscal year end",tolower(FGDPSTATS$`Special Notes`))
June <- grep("june",tolower(FGDPSTATS$`Special Notes`))
FYJune <- intersect(FY,June);str(FYJune)
## Found out that is also possible create a logical table where both TRUEs return matches
table(grepl("june", tolower(FGDPSTATS$Special.Notes)), grepl("fiscal year end", tolower(FGDPSTATS$Special.Notes)))
```
### Question 5
You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.
```{r}
## Load "quantmod" & "lubridade" package
library(quantmod)
library(lubridate)
library(dplyr)
## Set english sys local time as I spent a hour figuring out why was not working (was in Italian :D)
Sys.setlocale("LC_TIME", "English")

## Code pre-defined
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
## Filter 2012 data
amzn12 <- sampleTimes[grep("^2012",sampleTimes)];str(amzn12)
## Filter 2012 data by Monday and count
amznMond <- data.table(as.Date(amzn12))
amznMond <- amznMond[(weekdays(amzn12) %in% "Monday"),.N]; str(amznMond)
```
