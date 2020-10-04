## Getting and Cleaning Data Quiz 3 (JHU) Coursera

### Quiz 3

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical)

What are the first 3 values that result?

```{r}
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
              , 'ACS.csv'
              , method='curl' )

# Read data into data.frame
ACS <- read.csv('ACS.csv')

agricultureLogical <- ACS$ACR == 3 & ACS$AGS == 6
head(which(agricultureLogical), 3)
```

### Question 2

Using the jpeg package read in the following picture of your instructor into R

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?

```{r}
library(jpeg)

# Download the file
## Mode "wb" to avoid corrupted JPEG
jpg1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(jpg1,destfile = "./jeff.jpg", mode = "wb")

## Read jpeg file
jpg <- readJPEG("./jeff.jpg",native = T)

## Return 30th and 80th quantile probability
quantile(jpg, probs = c(0.3,0.8))
```

### Question 3

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank. What is the 13th country in the resulting data frame?

Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table http://data.worldbank.org/data-catalog/ed-stats

```{r}
library("data.table")

## Download files
download.file(csv1,destfile = "./FGDP.csv", mode = "wb")
download.file(csv2, destfile = "./FEDSTATS_Country.csv", mode = "wb")

# Read gdp data into data.table starting from 5th row and for 190 rows as per n. of countries
gdp <- fread("FGDP.csv",
                skip = 5,
                nrows = 190,
                select = c(1,2,4,5),
                col.names = c("CountryCode", "Rank", "Country", "Total"))

# Read edu stats data into data.table
edu <- fread("FEDSTATS_Country.csv")
                                      
## Merge data tables by 'CountryCode'
gdp.edu <- merge(gdp,edu,by = 'CountryCode')
nrow(gdp.edu)

# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
gdp.edu[order(-Rank)][13,.(Country)]
```
### Question 4
What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
```{r}
library(dplyr)

## Pipe the filtering of table, then summarising the mean of subset of OECD & nonOECD
gdp.edu %>%
    filter(`Income Group` == "High income: OECD" | `Income Group` == "High income: nonOECD") %>%
    summarize(OECD=mean(Rank[`Income Group`== "High income: OECD"]),
              nonOECD=mean(Rank[`Income Group`== "High income: nonOECD"]))
              
### Question 5
Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?             
```{r}
library('dplyr')

## Create vector of quantile probabilities from the 'Rank' variable, removing NAs
quantiles <- quantile(gdp.edu[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)

## Create new variable and cutting the 'Rank' with the quantile vector
gdp.edu$gdp.quantile <- cut(gdp.edu[, Rank], breaks = quantiles)

## Subset the 'Lower middle income, add the count and group by income and quantile
gdp.edu[`Income Group` == "Lower middle income", .N, by = c("Income Group", "gdp.quantile")]
```













