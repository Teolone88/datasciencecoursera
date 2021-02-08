source("global.R")

shinyServer(function(input, output, session) {
    
    resultList <- reactive({
        as.character(scoreNgrams(input$userInput)$nextword)[1:10]
    })
    
    scoreList <- reactive({
        if(as.character(scoreNgrams(input$userInput)$nextword)[1:10] <10 | input$userInput == "") {
            paste(as.character(scoreNgrams(input$userInput)$score), "times")
        } else {
            paste(as.character(scoreNgrams(input$userInput)$score)[1:10],"%")
        }
        
    })
    
    output$guess <- renderTable({
        outputTable <- data.frame(resultList())
        outputTable$Order = (1:10)
        outputTable$Score = data.frame(scoreList())
        outputTable <- outputTable[c(2,1,3)]
        if(nrow(outputTable)<10 | input$userInput == "") {
            colnames(outputTable) <- c("Index", "Next Word", "Frequency")
        } else {
        colnames(outputTable) <- c("Index", "Next Word", "N-Gram Score")
        }
        outputTable
    }, 
    caption=paste("Model: Ngram + Stupid Backoff"),
    width = '400px',
    spacing = 'l',
    hover = TRUE,
    align = "c",
    striped = TRUE
    )
})
