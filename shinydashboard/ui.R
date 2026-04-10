# dashboardHeader ----
header <- dashboardHeader(
  # title 
  title = "Fish Creek Watershed Lake Monitoring", 
  titleWidth = 400
)

# dashboardSidebar ----
sidebar <- dashboardSidebar(
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")), 
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon ("gauge"))
    
  ) #END sidebarMenu
) #END dashbaordSidebar

# dashboardBody ----
body <- dashboardBody(
  
  #tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(
      tabName = "welcome", 
      
      # lefthand column ----
      column(width = 6, 
             
             # background box ----
             box(
               width = NULL,
               title = tagList(icon("water"), strong("Monitoring Fish Creek Watershed")),
               includeMarkdown("text/intro.md"),
               tags$img(src = "FishCreekWatershedSiteMap_2020.jpg", alt = "A map of northern Alaska, showing Fish Creek Watershed located within the National Petroleum Reserve.", 
                        style = "max-width: 100%"
               ), 
               tags$p(
                 tags$em("Map Source: ", tags$a(href = "http://www.fishcreekwatershed.org/images/FishCreekWatershedSiteMap_2020.jpg", "FCWO")
               ), 
               
               style = "text-align: center;")
                 
                 ) #END background box
             
             ), #END lefthand column
      
      # righthand column ----
      column(width = 6,
             
             #data source box ----
             box(width = NULL, 
                 title = tagList(icon("table"), strong("Data Source")), 
                 includeMarkdown("text/citation.md")
                 ), #END datasource box
             
             # disclaimer box ----
             box(width = NULL, 
                 title = tagList(icon("triangle-exclamation"), strong("Disclaimer")), 
                 includeMarkdown("text/disclaimer.md")
                 ) #END disclaimer box
        
        
      )# END righthand column
    ), #END welcome tabItem
    
    # dashboard tabItem ----
    tabItem(
      tabName = "dashboard", 
      
      # input box ----
      box(width = 4, 
          
          title = tags$strong("Adjust lake parameter ranges:"), 
          
          # sliderInputs ----
          
          # elevation sliderInput ----
          sliderInput(
            inputId = "elevation_slider_input",
            label = "Elevation (meters above SL):",
            min = min(lake_data$Elevation),
            max = max(lake_data$Elevation),
            value = c(min(lake_data$Elevation), max(lake_data$Elevation))
          ), #END elevation sliderInput
          
          # depth sliderInput ----
          sliderInput(
            inputId = "average_depth_slider_input",
            label = "Depth (meters)",
            min = min(lake_data$AvgDepth),
            max = max(lake_data$AvgDepth),
            value = c(min(lake_data$AvgDepth), max(lake_data$AvgDepth))
          ), #END depth sliderInput
          
          # temp sliderInput ----
          sliderInput(
            inputId = "average_temp_slider_input",
            label = "Temp (\u00B0C)",
            min = min(lake_data$AvgTemp),
            max = max(lake_data$AvgTemp),
            value = c(min(lake_data$AvgTemp), max(lake_data$AvgTemp))
          ) #END temp sliderInput
          
          
          ), #END input box
      
      # leaflet box ----
      box(width = 8, 
          leafletOutput(outputId = "lake_map_output") %>% 
            withSpinner(type = 1, color = "blue")
          ) #END leaflet box
      
    ) #END dashboard tabItem
    
  ) #END tabItems
  
) #END dashboardBody



# Combine all into dashboardPage
dashboardPage(
  header, 
  sidebar, 
  body
)


