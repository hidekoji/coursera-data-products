library(shiny)
library(ggvis)
library(nycflights13)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Airline on-time data for all flights departing NYC in 2013"),
  p("This App allows you to perform Exploratory Data Analysis (EDA) for airline delays for all flights departing NYC in 2013 with a scatter plot.", style = "font-family: 'Helvetica Neue'; font-si16pt"),
  p("By chaning arrival and departure delay range sliders on left hanside bar, you can dynamically filter data and see the change in chart accordingly.You can also include/exclude carriers by checking/unchecking checkboxes on the same side bar.The scatter plots automatically shows regression lines for you. ", style = "font-family: 'Helvetica Neue'; font-si16pt"),
  p("On top of the scatter plot for EDA, there is one more chart that shows K-means for the same data. You can change number of cluster by changing cluster number input.",style = "font-family: 'Helvetica Neue'; font-si16pt"),
  
  # Sidebar with a slider input for the arrival/depart delay
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("carrier", label = h4("Carrier"), 
                         choices = unique(flights$carrier),
                         selected = unique(flights$carrier)),
      sliderInput("arrDelay",
                  "Arrival Delay:",
                  min = min(flights$arr_delay, na.rm = TRUE),
                  max = max(flights$arr_delay, na.rm = TRUE),
                  value = c(300,1000)),
      sliderInput("depDelay",
                  "Departure Delay:",
                  min = min(flights$dep_delay, na.rm = TRUE),
                  max = max(flights$dep_delay, na.rm = TRUE),
                  value = c(300,1000)),
      numericInput('clusters', 'Cluster count', 3,
                   min = 1, max = 9),
      uiOutput("plot_ui"),
      uiOutput("plot_ui_cluster")
      
    ),
    
    # Show a scatter plot
    mainPanel(
      h4('EDA Scatter Plot'),
      ggvisOutput("plot"),
      h4('k-means plot'),
      ggvisOutput('plot_cluster')
    )
  )
))