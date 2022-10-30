
shinyUI(
  navbarPage(
    includeCSS("www/style.css"),
    theme = bs_theme(bootswatch = "litera"),
    title = "Airbnb in Melbourne 🏘",
                   tabPanel("Introduction",
                            tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/9/91/Melbourne_as_viewed_from_the_Shrine%2C_January_2019.png", 
                                     height="300px", width="100%"),
                            tags$div(class = "intro",
                                     br(),
                                     p("Melbourne is one of the most popular cities in Australia, visited by domestic and interational tourist.
                                     One of the favorite accomodation for tourist is Airbnb. A budget-friendly, convenient,
                                     great to share with friends and family and, most importantly,
                                       the various option of accomodation for your personal preferences."),
                                     p("Since the COVID-19 pandemic hits globally, Australia commenced a border restriction for travelers.
                                     This restriction has impacted the tourism industry, including Airbnb in Melbourne in term of 
                                     the number of listings, pricing, available type of accomodation and the overall reviews. 
                                     However, On 21 February 2022, the travel border was fully lifted and tourist domestically and 
                                     internationally started to come and visit melbourne."),
                                     p("Through this application, I would like to share my findings about how the Airbnb in 
                                     Melbourne have changed before and after the travel restriction. There are 4 tabs 
                                     that you can explore, feel free to choose which one you are interested in!"),
                                     tags$div(id="cite",
                                              "Image source:", tags$a('https://upload.wikimedia.org/wikipedia/commons/9/91/Melbourne_as_viewed_from_the_Shrine%2C_January_2019.png'))
                            ),
                            ),
                   
                   tabPanel("Listings",
                            h5("Total number of listings decreased comparing before and after the border restriction, but number of entire house type listings increases."),
                            p("As the pandemic hits, the number of listings decreases and even after the restriction was lifted. Looking into the types of rooms,
                              the Entire house or Apartment type seems to be increasing, which is because people would prefer to have the place for their own,
                              to prevent getting affected by other people."),
                            fixedRow(column(width = 6,
                                            h5("Before"),
                                            plotlyOutput("type9"),
                                            h5(textOutput("total9"))),
                                     column(width = 6,
                                            h5("After"),
                                            plotlyOutput("type6", width = "70%"),
                                            h5(textOutput("total6")))
                                     )
                            ),
    
                    tabPanel("Map",
                             div(class = "mymap",
                                 leafletOutput("mymap", width=1300, height=700),
                                 absolutePanel(id = "timeselect", class = "panel panel-default",
                                               fixed = TRUE, draggable = TRUE,
                                               top = "auto", left = 20, right = "auto", bottom = 20,
                                               width = 250, height = 150,
                                               radioButtons("listTime1",
                                                            "Choose the time period:",
                                                            c("September 2021" = "list9",
                                                              "June 2022" = "list6"),
                                                            selected = "list9")))
                            ),
    
                   tabPanel("Pricing",
                            fixedRow(column(width = 8,
                                            plotOutput("pricePlot", height = 600)),
                                     column(width = 4,
                                            br(),
                                            br(),
                                            h5("Price of The Listings Increased"),
                                            br(),
                                            p("Since the pandemic, the tourism industry in Melbourne
                                              has not been well and with the border opened, there is an increasing 
                                              demand for accomodations. Overall, the price of the listings 
                                              increasesed on average by 38%. This might be the result of the lack 
                                              of number of listings yet a rising demand of accomonadtions causing 
                                              the price to increase."),
                                            p("The price for most of the listings, however, did not change much, which
                                              is within the range of approximately $60-$200. Additionally, we can see a lot of outliers, 
                                              which are listings that are targeted for long-term and for luxurious listings.")
                                            
                                            )
                            )
                            ),
    
                   tabPanel("Reviews",
                            h5("Airbnb has a POSITIVE overall reviews! Let's see what are common words used in the reviews!"),
                            br(),
                            br(),
                            div(class = "outer",
                                wordcloud2Output("wordcloud"),
                                absolutePanel(id = "controls", class = "panel panel-default", 
                                              fixed = TRUE, draggable = TRUE, 
                                              top = "auto", left = 20, right = "auto", bottom = 20,
                                              width = 250, height = 250,
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
                                                           selected = "random-light"))
                                )
                           )
)
)
