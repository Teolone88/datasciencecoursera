pollutantmean <- function(directory, pollutant, id =1:332) {
    ## Set wd
    wd <- setwd(paste0("C:/Users/Teolone/Desktop/",directory))
    ## Create list files           
    mydata <- list.files(wd)[id]
    ## Read file
    csv <- lapply(mydata, read.csv)
    ## Union files
    union <- do.call(rbind,csv)
    ## Calculate mean
    mean(union[,pollutant],na.rm = TRUE)
}
pollutantmean("specdata","sulfate",1:10)
