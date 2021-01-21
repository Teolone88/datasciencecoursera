library(shiny)
library(shinydashboard)
library(shinythemes)
library(plotly)
library(leaflet)
dashboardPage(skin="blue",
              dashboardHeader(title="PDF Analyzer",titleWidth=300),
              dashboardSidebar(width=250,
                               sidebarMenu(
                                   br(),
                                   menuItem(tags$em("Upload PDFs",style="font-size:150%"),icon=icon("upload"),tabName="data"),
                                   menuItem(tags$em("Summaries",style="font-size:150%"),icon=icon("bar-chart-o"),tabName="summary"),
                                   menuItem(tags$em("Search n Filter",style="font-size:150%"),icon=icon("search"),tabName="search")
                               )
              ),
              dashboardBody(
                  tabItems(
                      tabItem(tabName="data",
                              br(),
                              br(),
                              tags$h4("A PDF document is not so great in terms of searching and indexing, especially if you
                                      are a collector of eBooks."),
                              tags$h4("This application helps to get useful insights from PDF documents 
                           by creating visualizations and summarizations. It also enables searching, sorting and filtering."),
                              
                              tags$h4("I personally use it for reviewing eBooks previews from the open library (https://openlibrary.org/)
                                       or for review my CVs or cover letters but go wild."),
                              
                              tags$h4("Upload PDF documents (books, journals, surveys, etc.), then go to the", tags$span("Summaries",style="color:red"), tags$span("section in the sidebar to get summaries of the uploaded documents.
                              We can search one or more terms and see their distribution across the uploaded documents in 
                              the" , tags$span("Search n Filter",style="color:red"), tags$span("menu item. We can also filter to display words with certain frequency range only."))),
                              br(),
                              br(),
                              br(),
                              
                              column(width = 4,
                                     fileInput('file1', em('Choose PDF File',style="text-align:center;color:red;font-size:120%"),multiple = TRUE,
                                               accept=c('.pdf')),
                                     
                                     br(),
                                     br(),
                                     br(),
                                     br()
                              ),
                              br()
                      ),
                      tabItem(tabName="summary",
                              fluidRow(
                                  tabBox(width=12,
                                         tabPanel(tags$em("Word Cloud",style="font-size:150%"),
                                                  
                                                  column(width = 8,
                                                         plotOutput("wordcloud", height = "700px")),
                                                  column(width = 4,
                                                         br(),
                                                         uiOutput("minfreq"),
                                                         br(),
                                                         uiOutput("maxwords"),
                                                         br(),
                                                         uiOutput("forEach")) 
                                         ),
                                         tabPanel(tags$em("Plotly Bar graph",style="font-size:150%"),
                                                  
                                                  plotlyOutput("myplot",height = "700px"),
                                                  br(),
                                                  uiOutput("numwords")     
                                         ),
                                         tabPanel(tags$em("Sentiments",style="font-size:150%"),
                                                  
                                                  plotlyOutput("mysentiment",height = "700px")
                                         ),
                                         tabPanel(tags$em("Locations",style="font-size:150%"),
                                                  DT::dataTableOutput("DataTable2")
                                         )
                                  ))),
                      tabItem(tabName="search",
                              DT::dataTableOutput("DataTable"),
                              br(),
                              uiOutput("text"),
                              uiOutput('forsearch'),
                              uiOutput('searchbutton'),
                              plotlyOutput("searched",height = '600px')  
                      )
                  )))
