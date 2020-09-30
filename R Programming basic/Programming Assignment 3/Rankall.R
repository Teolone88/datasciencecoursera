library(dplyr)

rankall <- function(outcome, num = "best") {
    ## Set wd
    setwd("C:/Users/Teo/Documents/R/datasciencecoursera/")
    ## Store data
    om <- read.csv("outcome-of-care-measures.csv")
    ## Check that outcome is valid
    if (!outcome %in% c("heart attack", "pneumonia", "heart failure")) {
        stop(
            "Please, enter an outcome between 'heart attack', 'pneumonia' and 'heart failure'"
        )
    }
    ## Return hospital name in that state with the given rank 30-day death rate
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
    ## Set data with alias for convinience
    result <- om
    ## Convert outcome to numeric
    result[,col] <- as.numeric(result[,col])
    ## Set ranking by outcome
    rank.result <- rank(result[,col], na.last = TRUE, ties.method = "max")
    ## Create col with ranking by the previous created vector
    result$rank <- rank.result
    ## Select col for hospital names, states and outcome values
    result <- result %>% select(2,7,col)
    ## Order Asc by rank
    order <- order(result[,3],result[,2], decreasing = FALSE, na.last = TRUE)
    result <- result[order,]
    ## Select only hospital names and states
    result <- result %>% select(1,2)
    ## Loop index of length of State vector and check if tot. hospitals fit within num input and if "best" && "worst" are used
    for(i in 1:length(result$State)) {
        if (num == "best" || num == "worst"){
            break
        }
        else if (num > length(result$State)) {
            stop("There are not enough hospitals, change the number.")
        }
    }
    ## Execute if "best" && "worst" are used or numeric input
    if(num == "best") {
        head(result,5)
    } else if (num == "worst") {
        tail(na.omit(result),5)
        
    } else if(is.numeric(num)) {
        head(result,num)
    }
}
## Execution test
rankall("heart attack", 500)
