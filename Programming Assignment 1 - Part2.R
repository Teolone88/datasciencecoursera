complete <- function(directory, id = 1:332) {
    ## Set wd
    wd <- setwd(paste0("C:/Users/Teolone/Desktop/",directory))
    ## Create list files           
    list <-list.files(wd,all.files = TRUE)
    ## Create new tmp dataframe
    df <- data.frame(id=NA, nobs=NA)
    ##Loop to index vector IDs
    for (i in 1:length(id)) {
        df[i,1] <- id[i]
        df[i,2] <- sum(complete.cases(read.csv(list[id[i]])))
    }
    df
}
complete("specdata",5:35)
