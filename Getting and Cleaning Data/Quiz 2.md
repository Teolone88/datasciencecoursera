### Question 1
Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

```{r}
library(httr)
library(httpuv)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("Coursera - Week 2 Quiz - Teo Lo Piparo",
                   key = "Iv1.be92d61bd5ea9f4e",
                   secret = "237ccb5dbdd015757bd13e7d4a865c8a6870dcd2")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))
names(json2)
json2 <- as_tibble(json2)
str(json2[json2$name == "datasharing","created_at"])
```
### Question 2
The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.

Download the American Community Survey data and load it into an R object called
```{r}
acs
```
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
```{r}
## RMySQL
library(RMySQL)
library(sqldf)
## Set default DB driver
options(sqldf.driver = "SQLite")
## Or silently detach package -> detach("package:RMySQL", unload=TRUE)

setwd("./R/datasciencecoursera/")
wd <- getwd()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "C:/Users/Teo/Documents/R/datasciencecoursera/getdata%2Fdata%2Fss06pid.csv"))
acs <- data.table::data.table(read.csv("./getdata%2Fdata%2Fss06pid.csv", header = T, sep = ","))
sqldf("select pwgtp from acs where AGEP < 50")
```
### Question 3

Using the same data frame you created in the previous problem, what is the equivalent function to
```{r}
unique(acs$AGEP)
```
```{r}
unique(acs$AGEP)
## is equal to
sqldf("select distinct AGEP from acs")
```
### Question 4

How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)
```{r}
## Web Scraping HTML
library(XML)
library(RCurl)
library(httr)

## Web scraping with readLines
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
paste(nchar(htmlCode[[10]]),nchar(htmlCode[[20]]),nchar(htmlCode[[30]]),nchar(htmlCode[[100]]))
```
### Question 5

Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

(Hint this is a fixed width file format)
```{r}
## importing fwf file format
setwd("./R/datasciencecoursera/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",destfile = "C:/Users/Teo/Documents/R/datasciencecoursera/2Fwksst8110.for")
## After several attempts I have managed to skip and sum up the right char per each column
acs <- read.fwf("./2Fwksst8110.for",skip = 4, header = F,widths = c(14,5,9,4,9,4,9,4,9),sep = "\t")
head(acs)
sum(acs[,4])
```
