
shinyServer(function(input, output, session) {
  
  # Listings
  output$mymap <- renderLeaflet({ 
    req(input$listTime1)
    if(input$listTime1 == "list9"){
      mymap <- leaflet() %>% 
        addTiles() %>%
        addPolygons(data = area, color = "red", 
                    popup = ~paste0(neighbourhood, "<br/>", 
                                    "Number of listings: ",
                                    n_list9$n),
                    weight = 1,
                    highlightOptions = highlightOptions(color = "blue", 
                                                        bringToFront = TRUE,
                                                        weight = 4)) %>%
        addCircleMarkers(lat = list9$latitude,
                         lng = list9$longitude,
                         color = "blue",
                         label = paste0(list9$name, ", ",
                                   list9$room_type, ", ",
                                   list9$price, ", ",
                                   list9$neighbourhood_cleansed ,", ",
                                   list9$reviews_per_month),
                   clusterOptions = markerClusterOptions())
    } else if(input$listTime1 == "list6"){
      mymap <- leaflet() %>% 
        addTiles() %>%
        addPolygons(data = area, color = "red", 
                    popup = ~paste0(neighbourhood, "<br/>",
                                    "Number of listings: ",
                                    n_list6$n),
                    weight = 1,
                    highlightOptions = highlightOptions(color = "blue", 
                                                        bringToFront = TRUE,
                                                        weight = 4)) %>%
        addCircleMarkers(lat = list6$latitude, 
                         lng = list6$longitude,
                         color = "blue",
                         label = paste0(list6$name,", ",
                                         list6$room_type, ", ",
                                         list6$price, ", ",
                                         list6$neighbourhood_cleansed,", ",
                                         list6$reviews_per_month),
                         clusterOptions = markerClusterOptions())
    }
    })
  
  # Type
  
  output$type9 <- renderPlotly({
    
    type9 <- plot_ly(room9, labels = ~room_type, values = ~n, type = 'pie',
                     showlegend = FALSE,
                     textinfo = 'label+percent',
                     insidetextfont = list(color = '#FFFFFF'),
                     hoverinfo = 'text',
                     text = ~paste0(n," out of ", sum(n)))
    type9 <- type9 %>% layout(title = "September 2021",
                              xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                              yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    type9
    
  })
  
  output$type6 <- renderPlotly({
    
    type6 <- plot_ly(room6, labels = ~room_type, values = ~n, type = 'pie',
                     showlegend = FALSE,
                     textinfo = 'label+percent',
                     insidetextfont = list(color = '#FFFFFF'),
                     hoverinfo = 'text',
                     text = ~paste0(n," out of ", sum(n)))
    type6 <- type6 %>% layout(title = "June 2022",
                          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    type6
    
  })
  
  output$total9 <- renderText({
    total9 <- sum(room9$n)
    paste0("Total Number of listings: ",total9)
  })
  
  output$total6 <- renderText({
    total6 <- sum(room6$n)
    paste0("Total Number of listings: ",total6)
  })
  
  # Pricing
  output$pricePlot <- renderPlot({
    cal1 %>%
      ggplot(aes(y = price, 
                 x = as.character(date))) +
      geom_violin(aes(fill = as.character(date))) +
      geom_boxplot(width = 0.05) +
      scale_y_log10(labels = label_dollar()) +
      theme(legend.position = "none") +
      labs(x = "Date") +
      annotate("text", label = "$145.80", 
               x ="2021-09-08", y = 200, colour = "white") +
      annotate("text", label = "$201.30", 
               x ="2022-06-06", y = 280, colour = "white")
      
  })
  
  # Reviews
  output$wordcloud <- renderWordcloud2({
    req(input$selection)
    if(input$selection == "all"){
      wordcloud2(all, color = input$color)}
    else if (input$selection == "positive"){
      wordcloud2(positive, color = input$color)}
    else if (input$selection == "negative"){
      wordcloud2(negative, color = input$color)}
  })
})
