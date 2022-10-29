
shinyUI(navbarPage(title = "Airbnb in Melbourne",
                   tabPanel("Introduction", "Introduction"),
                   tabPanel("Listings",
                            sidebarPanel(
                              radioButtons("listTime", 
                                           "Choose the time period:", 
                                           c("September 2021" = "list9", 
                                             "June 2022" = "list6"),
                                           selected = "list9")
                                         ),
                            mainPanel(leafletOutput("mymap"))
                            ),
                   tabPanel("Types",
                            splitLayout(plotlyOutput("type9"),
                                        plotlyOutput("type6"))),
                   tabPanel("Pricing",
                            plotOutput("pricePlot")),
                   tabPanel("Reviews",
                            sidebarPanel(
                              selectInput("selection",
                                          "Choose Rating Type:",
                                          c("Overall" = "all",
                                            "Positive" = "positive",
                                            "Negative" = "negative"),
                                          selected = "all"),
                              radioButtons("color", 
                                           "Word Color:", 
                                           c("Light" = "random-light", 
                                             "Dark" = "random-dark"),
                                           selected = "random-light")),
                            mainPanel(
                              wordcloud2Output("wordcloud")
                              ))
))
