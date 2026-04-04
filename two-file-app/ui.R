# ---- user interface ----
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           "background info will go here" # REPLACE THIS WITH CONTENT
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             # trout tabPanel ----
             tabPanel(
               
               title = "Trout",
               
               # trout sidebarlayout()
               
               sidebarLayout(
                 
                 # trout sidebarPanel ----
                 sidebarPanel(
                   
                   # channel type pickerInput
                   pickerInput(
                     inputId = "channel_type_input", 
                     label = "Select channel type(s):", 
                     choices = unique(clean_trout$channel_type),
                     selected = c("riffle", "pool"), 
                     # Allow multiple options selection
                     multiple = TRUE, 
                     options = pickerOptions(
                       actionsBox = TRUE)
                   ), # END channel type pickerInput
                   
                  # section checkboxGroupButtons
                  checkboxGroupButtons(
                    inputId = "section_input", 
                    label = "Select a sampling section(s):", 
                    choices = c("clear cut forest", "old growth forest"), 
                    selected = c("clear cut forest", "old growth forest"), 
                    justified = TRUE, 
                    checkIcon = list(yes = icon("check", lib = "font-awesome"), 
                                     no = icon("xmark", lib = "font-awesome"))
                  ) # END section checkboxGroupButtons
                   
      
                 ), # End trout sidebarPanel ----
                 
                 # trout mainPanel ----
                 
                 mainPanel(
                   plotOutput(outputId = "trout_scatterplot_output")
                 ) # End trout mainPanel
                 
               ) # End trout sidebarlayout
               
             ), # End trout tabPanel
             
             # penguin tabPanel
             tabPanel(
               title = "Penguins",
               sidebarLayout(
                 
                 # penguins sidebarPanel ----
                 sidebarPanel(
                   
                   # island pickerInput
                   pickerInput(
                     inputId = "island_input", 
                     label = "Select an island:", 
                     choices = unique(penguins$island), 
                     selected = c("Torgersen", "Dream", "Biscoe"),
                     multiple = TRUE, 
                     options = pickerOptions(
                       actionsBox = TRUE)
                     ), # END island pickerInput
                   
                   # bin sliderInput
                   sliderInput(
                     inputId = "bin_input", 
                     label = "Select number of bins", 
                     min = 1, 
                     max = 100, 
                     value = 25
                   )
                 ), # End penguins sidebarPanel ---
                 
                 # penguins mainPanel ----
                 mainPanel(
                   
                   plotOutput(outputId = "penguins_histogram_output")
                   
                 ) # End penguins mainPanel
                 
               ) # End penguins sidebarlayout
               
             ) # End penguins tabPanel
             
           ) # End tabsetPanel
           
  ) # END (Page 2) data viz tabPanel
  
) # END navbarPage