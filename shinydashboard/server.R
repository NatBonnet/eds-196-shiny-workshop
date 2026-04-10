server <- function(input, output){
  output$lake_map_output <- renderLeaflet({
    
    # Filter lake data ----
    filtered_lakes_df <- reactive({
      
      lake_data %>% 
        
        filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2]) %>% 
        
        filter(AvgDepth >= input$average_depth_slider_input[1] & AvgDepth <= input$average_depth_slider_input[2]) %>% 
        
        filter(AvgTemp >= input$average_temp_slider_input[1] & AvgTemp <= input$average_temp_slider_input[2])
    })
    
    leaflet() %>% 
      
      # Add base tiles
      addProviderTiles(providers$Esri.WorldImagery) %>% 
      
      # Set view over Alaska
      setView(lng = -152.048442, lat = 70.249234, zoom = 6) %>% 
      
      # Add mini map
      addMiniMap(toggleDisplay = TRUE, minimized = FALSE) %>% 
      
      # Add markers
      addMarkers(data = filtered_lakes_df(), 
                 lng = filtered_lakes_df()$Longitude, 
                 lat = filtered_lakes_df()$Latitude,
                 popup = paste0(
                   "Site Name: ", filtered_lakes_df()$Site, "<br>",
                   "Elevation: ", filtered_lakes_df()$Elevation, " meters (above SL)", "<br>", 
                   "Avg Depth: ", filtered_lakes_df()$AvgDepth, " meters", "<br>", 
                   "Avg Lake Bed Temperature: ", filtered_lakes_df()$AvgTemp, "\u00B0C"
                   
                 )) 
    
    
  })
}