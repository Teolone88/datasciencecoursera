library(tidyverse)
setwd("...")

hd <-
    read.csv("C:/Users/Teo/Documents/R/datasciencecoursera/hospital-data.csv")
om <-
    read.csv("C:/Users/Teo/Documents/R/datasciencecoursera/outcome-of-care-measures.csv")

best <- function(iso, disease) {
    ## Set wd
    setwd("C:/Users/Teo/Documents/R/datasciencecoursera/")
    ## Store data
    om <- read.csv("outcome-of-care-measures.csv")
    iso.states <- om[, 7]
    state.iso <- FALSE
    ## Check validity iso code
    for (i in 1:length(iso.states)) {
        if (iso == iso.states[i]) {
            state.iso <- TRUE
        }
    }
    if (state.iso == FALSE) {
        stop("Please, enter a valid two charachters State")
    }
    ## Subset state
    om <- subset(om, State == iso)
    ## Check validity disease
    if (!disease %in% c("heart attack", "pneumonia", "heart failure")) {
        stop(
            "Please, enter a disease between 'heart attack', 'pneumonia' and 'heart failure'"
        )
    }
    ## Assess disease and set column
    if (disease == "heart attack") {
        col <-  11
    }
    else if (disease == "heart failure") {
        col <- 17
    }
    else if (disease == "pneumonia") {
        col <- 23
    }
    
    result <- om[om$State == "SC", ]
    result[,col] <- as.numeric(result[,col])
    min.result <- min(result[,col], na.rm = NA)
    result <- subset(result,result[,col] == min.result)
    result <- result[,2][[1]]
    print(result)
}


best("SC", "heart attack")
