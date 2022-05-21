library(shiny)



fluidPage(
  headerPanel(title = "NYC accident Data analysis"),
  navlistPanel(
    "List of the Topics",
    tabPanel("NYCDSA Shiny Project",
             tags$img(src = "twhw0Lx-free-new-york-city-wallpaper.jpg", width = "1000px", height = "800px"),
             h2("NYC Accidents Data Analysis",align = "center", style = "color:blue")
              ),
    tabPanel("Introduction",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             tags$ul(br(),br(),br(),br(),
               tags$li("Data used in this analysis",style = "font-size:50px;font-family: 'times'"),
               br(),br(),br(),
               tags$li("Goals",style = "font-size:50px;font-family: 'times'"), 
               br(),br(),br(),
               tags$li("ETL process",style = "font-size:50px;font-family: 'times'")
             )
             
             ),
    tabPanel("Yearly Accidents in NYC",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             plotOutput("second")),
    
    
    
    tabPanel("Accident trends in NYC Boroughs",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             plotOutput("first")),

    tabPanel("Accidents distribution on Weekdays",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             plotOutput("third")),
    
    tabPanel("Accidents points Destributed per Borough",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             plotOutput("fourth"),selectizeInput(inputId = "origin",
                                                                                            label = "Borough",
                                                                                            choices = unique(DF_COOR$BOROUGH))
             ),
    tabPanel("Density Distribution of Accidents",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             plotOutput("fifth"),selectizeInput(inputId = "origin1",
                                                                                            label = "Borough",
                                                                                            choices = unique(DF_COOR$BOROUGH))
             ),
    tabPanel("Density Distribution of Fatalities",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             plotOutput("sixth"),selectizeInput(inputId = "origin2",
                                                                                    label = "Borough",
                                                                                    choices = unique(DF_COOR$BOROUGH))
    ),
    tabPanel("Density Distribution of Injuries",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             plotOutput("seventh"),selectizeInput(inputId = "origin3",
                                                label = "Borough",
                                                choices = unique(DF_COOR$BOROUGH))
    ),
    tabPanel("Conclusion",
             tags$img(src = "nycbanner.jpg", width = "1200px", height = "70px"),
             tags$ul(br(),br(),br(),br(),
                     tags$li("what can be done with this information?",style = "font-size:50px;font-family: 'times'"),
                     br(),br(),br(),
                     tags$li("Using live speed data to correlate with accident and taking preemptive mesures",style = "font-size:50px;font-family: 'times'"), 
                     br(),br(),br(),
                     tags$li("Using interactive maps with better size",style = "font-size:50px;font-family: 'times'")
             )),
    widths = c(3,8)
  )
  
   
)

  


  
  
  

 
  
