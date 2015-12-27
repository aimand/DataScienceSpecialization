library(markdown)

shinyUI(navbarPage("Fastest, most powerful, or highest performing car around the block",
                   tabPanel("Table",
                            
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Change the Values of the sliders to find out the Fastest (lowest time to cover a 1/4 mile), Most Poweful (highest horsepower), or highest performance (horsepower/weight ratio)."),
                                checkboxGroupInput('cyl', 'Number of cylinders:', c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),
                                sliderInput('wt', 'Weight', min=1000, max=6000, value=6000, step=100),
                                sliderInput('hp', 'Horsepower', min=50, max=340, value=c(50,340), step=10),
                                sliderInput('qsec', '1/4 Mile Time', min = 10, max = 25, value = 25, step= 0.1),
                                checkboxGroupInput('am', 'Transmission:', c("Automatic"=0, "Manual"=1), selected = c(0,1))
                              ),
                              
                              mainPanel(
                                dataTableOutput('table')
                              )
                            )
                   ),
                   tabPanel("About",
                            mainPanel(
                              includeMarkdown("about.md")
                            )
                   )
)
) 
