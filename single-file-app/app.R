# Load packages
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)

# Create user interface
ui <- fluidPage(#Established user interface 
  
  # App title
  tags$h1("Penguin Attributes"), 
  
  # App subtitle
  tags$h2(strong("Exploring Antarctic Penguin Data")), 
  
  # Body mass slider input
  sliderInput(
    inputId = "body_mass_input", 
    label = "Select a range of body masses (g)", 
    min = 2700, #min(penguins$body_mass_g)
    max = 6300, #max(penguins$body_mass_g)
    value = c(3000, 4000)
  ),
  
  
  # Body mass plot output
  plotOutput(
    outputId = "body_mass_scatterplot_output"),
  
  # DataTable input
  checkboxGroupInput(
    inputId = "table_input", 
    label = "Select year to filter observations", 
    choices = c(2007, 2008, 2009),
    selected = c(2007, 2008)
  ), 
  
  # DataTable output
  DT::dataTableOutput(outputId = "data_frame_filtered_output"),
)

# Set up server
server <- function(input, output){
  
  # Filter body masses
  body_mass_df <- reactive({
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
             })
  
  
  output$body_mass_scatterplot_output <- renderPlot(
    # Curly brackets allow stacking of code
    {# create scatterplot ----
      ggplot(na.omit(body_mass_df()), 
             aes(x = flipper_length_mm, y = bill_length_mm, 
                 color = species, shape = species)) +
        geom_point() +
        scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
        scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
        labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
             color = "Penguin species", shape = "Penguin species") +
        guides(color = guide_legend(position = "inside"),
               size = guide_legend(position = "inside")) +
        theme_minimal() +
        theme(legend.position.inside = c(0.85, 0.2), 
              legend.background = element_rect(color = "white"))}
    )
  
  
  
  # Render DataTable 
  penguins_year <- reactive({penguins %>% 
    filter(year %in% c(input$table_input))
  })
  
  output$data_frame_filtered_output <- renderDT({datatable(penguins_year())
})
  
}

# Combine UI and server into an app
shinyApp(ui = ui, server = server)
  
