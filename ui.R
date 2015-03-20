library(shiny)
library(ggvis)
library(nycflights13)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Airline on-time data for all flights departing NYC in 2013"),
  p("This App allows you to perform exploratory data analysis for airline delays for all flights departing NYC in 2013.", style = "font-family: 'Helvetica Neue'; font-si16pt"),
  p("By chaning arrival and departure delay range sliders on left hanside bar, you can dynamically filter data.Also you can include/exclude carriers by checking/unchecking checkboxes on the same side bar.The scatter plots automatically shows regression lines for you. ", style = "font-family: 'Helvetica Neue'; font-si16pt"),
  
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
      uiOutput("plot_ui")
    ),
    
    # Show a scatter plot
    mainPanel(
      ggvisOutput("plot")
    )
  )
))