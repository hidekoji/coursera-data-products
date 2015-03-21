library(shiny)
library(dplyr)
library(tidyr)
library(ggvis)
library(nycflights13)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  flightsFiltered <- reactive({
   
    # get arrival and departure delays range values from slider input.
   arr_delay_range_low <- input$arrDelay[1]
   arr_delay_range_high <- input$arrDelay[2]
   dep_delay_range_low <- input$depDelay[1]
   dep_delay_range_high <- input$depDelay[2]
   
   # get selected carries from checkbox group input
   carriers <- input$carrier
   
   # Filter flighs data by unser inputs
   flights %>% 
     filter( carrier %in% ifelse(!is.na(carriers), carriers , flights$carrier)) %>%
     filter( arr_delay >= arr_delay_range_low & arr_delay <= arr_delay_range_high) %>%
     filter( dep_delay >= dep_delay_range_low & dep_delay <= dep_delay_range_high) 
  })
  
  kmeansData <- reactive({
    filtered <- flightsFiltered()
    kmdata <- filtered %>% select(arr_delay, dep_delay)
    clustered <- kmeans(kmdata, input$clusters)
    kmdata$cluster <- clustered$cluster
    kmdata
  })

  # render scatter plot
  flightsFiltered %>% 
    ggvis(~arr_delay, ~dep_delay, fill = ~factor(carrier)) %>% 
    layer_points(size = ~distance) %>%
    group_by(carrier) %>%
    layer_model_predictions(model ="lm") %>%
    add_axis("x", title = "Arrival Delay in minutes") %>%
    add_axis("y", title = "Departure Delay in minutes") %>%
    add_legend("fill", title = "Carrier",orient = "right") %>%
    add_legend("size", title = "Distance",orient = "left") %>%
    bind_shiny("plot","plot_ui")

  kmeansData %>% ggvis(x = ~arr_delay, y = ~ dep_delay) %>% group_by(cluster) %>%
    layer_paths(stroke = ~cluster, strokeWidth := 1) %>%
    layer_points(x = ~arr_delay, y= ~dep_delay, size := 15, fill= ~cluster) %>%
    add_axis("x", title = "Arrival Delay in minutes") %>%
    add_axis("y", title = "Departure Delay in minutes") %>%
    bind_shiny("plot_cluster","plot_ui_cluster")
})