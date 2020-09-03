getwd()
setwd("C:/Users/Teolone/Documents/R/datasciencecoursera")

firstfunction <- function() {
  x <- rnorm(100)
  mean(x)
}
secondfunction <- function(x) {
  x + rnorm(length(x))
}

y <- data.frame(a=1,b="b")
dput(y)

x <- c("a", "b", "c", "d", "a")
x[1]
x[x > "a"]
u <- x > "a"
u
x[u]
## 5
x<- c(4,"a", TRUE)
class(x)
## 6
x <- c(1,3, 5); y <- c(3, 2, 10)
cbind(x, y)
## 8
x <- list(2, "a", "b", TRUE)
class(x[[1]])
## 9
x <- 1:4; y <- 2:3
class(x + y)
## 10
x <- c(17, 14, 4, 5, 13, 12, 10)
x[x>10] <- 4
x
## 11
csv <- read.csv("hw1_data.csv")
## 12
csv[1:2,]
## 13
totrow <- nrow(csv)
## 14
csv[152:153,]
##15
csv$Ozone[47]
##16
na.ozone <- subset(csv,is.na(csv$Ozone))
nrow(na.ozone)
##17
yes.ozone <- subset(csv,!is.na(csv$Ozone))
mean(yes.ozone$Ozone)
##18
ozone31 <- subset(yes.ozone,yes.ozone$Ozone> 31 & yes.ozone$Temp < 90)
ozone31 <- subset(ozone31, !is.na(ozone31$Solar.R))
mean(ozone31$Solar.R)
##19
month6 <- subset(csv,csv$Month == 6)
mean(month6$Temp)
##20
may <- subset(csv,csv$Month == 5)
may <- subset(may,!is.na(may$Ozone))
max(may$Ozone)







