best <- function(iso, disease) {
    ## Set wd
    setwd("C:/Users/Teo/Documents/R/datasciencecoursera/")
    ## Store data
    om <- read.csv("outcome-of-care-measures.csv")
    iso.states <- om[, 7]
    state.iso <- FALSE
    ## Check validity iso code through a for loop, indexing TRUE matches or returning a stop function in case there are no matches
    for (i in 1:length(iso.states)) {
        if (iso == iso.states[i]) {
            state.iso <- TRUE
        }
    }
    if (state.iso == FALSE) {
        stop("Please, enter a valid two charachters State")
    }
    ## Check validity disease looking for negative matching of the argument disease
    if (!disease %in% c("heart attack", "pneumonia", "heart failure")) {
        stop(
            "Please, enter a disease between 'heart attack', 'pneumonia' and 'heart failure'"
        )
    }
    ## Assess disease type and set column number if the disease is an accepted one
    if (disease == "heart attack") {
        col <-  11
    }
    else if (disease == "heart failure") {
        col <- 17
    }
    else if (disease == "pneumonia") {
        col <- 23
    }
    ## Subset result with the state argument
    result <- om[om$State == "SC", ]
    ## Convert column number of the disease in numerical from character
    result[,col] <- as.numeric(result[,col])
    ## Assign a variable with the min value for the mortal rate, removing NAs
    min.result <- min(result[,col], na.rm = NA)
    ## Subset from the result the min value, previously determined to isolate the requirement
    result <- subset(result,result[,col] == min.result)
    ## Assign result
    result <- result[,2][[1]]
    ## Print result
    print(result)
}

## Test function
best("SC", "heart attack")
