library(shiny)
library(datasets)
library(dplyr)


shinyServer(function(input, output) {
  
  # Show the cars that correspond to the filters
  output$table <- renderDataTable({
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    data <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg, Horsepower = hp,
                      QuarterMileTime = qsec, CarPerformance = (hp/(wt*1000)),
                      Cylinders = cyl, Weight = wt*1000, 
                      Transmission = am)
    data <- filter(data, Cylinders %in% input$cyl, 
                   Weight <= input$wt , Horsepower %in% hp_seq, 
                   QuarterMileTime <= input$qsec, Transmission %in% input$am)
    data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    data <- arrange(data, CarPerformance)
    data
  }, options = list(lengthMenu = c(5, 25, 50), pageLength = 50))
})

