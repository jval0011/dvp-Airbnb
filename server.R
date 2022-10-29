
shinyServer(function(input, output, session) {
  
  # Listings
  output$mymap <- renderLeaflet({ 
    req(input$listTime)
    if(input$listTime == "list9"){
      mymap <- leaflet() %>% 
        addTiles() %>%
        addPolygons(data = area, color = "red", 
                    label = ~paste0(neighbourhood),
                    weight = 1,
                    highlightOptions = highlightOptions(color = "blue", 
                                                        bringToFront = TRUE,
                                                        weight = 2)) %>%
        addCircles(lat = list9$latitude, 
                   lng = list9$longitude, 
                   label = list9$name,
                   color = "blue")
    } else if(input$listTime == "list6"){
      mymap <- leaflet() %>% 
        addTiles() %>%
        addPolygons(data = area, color = "red", 
                    label = ~paste0(neighbourhood),
                    weight = 1,
                    highlightOptions = highlightOptions(color = "blue", 
                                                        bringToFront = TRUE,
                                                        weight = 2)) %>%
        addCircles(lat = list6$latitude, 
                   lng = list6$longitude, 
                   color = "green")
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
  
  # Pricing
  output$pricePlot <- renderPlot({
    cal1 %>%
      ggplot(aes(y = price, 
                 x = as.character(date))) +
      geom_violin(aes(fill = as.character(date))) +
      geom_boxplot(width = 0.05) +
      scale_y_log10(labels = label_dollar()) +
      theme(legend.position = "none") +
      labs(x = "Date")
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


