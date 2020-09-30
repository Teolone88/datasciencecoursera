library(dplyr)

rankhospital <- function(iso, outcome, num = "best") {
    ## Set wd
    setwd("C:/Users/Teo/Documents/R/datasciencecoursera/")
    ## Store data
    om <- read.csv("outcome-of-care-measures.csv")
    ## Check that state is valid
    iso.states <- om[, 7]
    state.iso <- FALSE
    for (i in 1:length(iso.states)) {
        if (iso == iso.states[i]) {
            state.iso <- TRUE
        }
    }
    if (state.iso == FALSE) {
        stop("Please, enter a valid two charachters State")
    }
    ## Check that outcome is valid
if (!outcome %in% c("heart attack", "pneumonia", "heart failure")) {
    stop(
        "Please, enter an outcome between 'heart attack', 'pneumonia' and 'heart failure'"
    )
}
## Assess outcome and set column
if (outcome == "heart attack") {
    col <-  11
}
else if (outcome == "heart failure") {
    col <- 17
}
else if (outcome == "pneumonia") {
    col <- 23
}
## Subset at the state input
result <- om[om$State == iso, ]
## Convert as numeric the character vector of the outcome input
result[,col] <- as.numeric(result[,col])
## Rank the outcome results
rank.result <- rank(result[,col], na.last = TRUE, ties.method = "max")
## Assign rank to a new vector & add a new column with that vector
result$rank <- rank.result
result <- result %>% select(1,2,col,rank)
## Order the results by outcome and name of hospital
order <- order(result[,3],result[,2], decreasing = FALSE, na.last = TRUE)
result <- result[order,]
## Index by for loop the length of a vector and loop if the num contains the word "worst" or "best", or if the number contains a an amount that is within the vector length
for(i in 1:length(result$rank)) {
    if (num == "best" || num == "worst"){
        break
    }
    else if (num > length(result$rank)) {
        stop("There are not enough hospitals, change the number.")
    }
}
## Assign a value to the word "best" and "worst" or just a number
if(num == "best") {
    head(result,5)
} else if (num == "worst") {
    tail(na.omit(result),5)
    
} else if(is.numeric(num)) {
    head(result,num)
}
}
## Execute function
rankhospital("TX","pneumonia", "worst")
