corr <- function(directory, treshold=0) {
    ## Create tmp vector for correlation
    correlation <-vector(mode="numeric", length=0)
    ## Create list files           
    mydata <-list.files(paste0("C:/Users/Teolone/Desktop/",directory),full.names = TRUE)
    ## Loop list of indexed seq of files and remove NA
    for(i in seq(mydata)) {
        csv <- read.csv(mydata[i])
        removena <- complete.cases(csv)
        csv <- csv[removena,]
        ## Check Treshold function
        if(nrow(csv) > treshold) {
            ## Noticed to put [[]] due to the need of a vector and not data.frame
            cr <- cor(csv[["sulfate"]], csv[["nitrate"]])
            correlation <- append(correlation,cr)
        } 
    }
    print(correlation)
}
corr("specdata",600)
