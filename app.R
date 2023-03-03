#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

UAH <- read_delim("UAH-lower-troposphere-long (1).csv.bz2")

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("PS06-shiny"),
  
  sidebarLayout(
    sidebarPanel(
      "Some words yeah"
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("About"),
        tabPanel("Plots"),
        tabPanel("Tables"),
      ),
    )
  )
)

titlePanel("PS06-shiny"),

mainPanel((
  tabsetPanel(
    tabPanel("About"),
    tabPanel("Plots",
             sidebarLayout((
               sidebarPanel(
                 checkboxGroupInput("regions", label = "Choose regions",
                                    choices = c("globe", "globe_land", "globe_ocean"),
                                    selected = c("globe", "globe_land", "globe_ocean"))
               ),
               mainPanel(plotOutput("plot"))
             )),
             
             tabPanel("Tables",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("year_range", label = "choose the year range",
                                      min = min(data$year),
                                      max = max(data$year),
                                      value = c(1978, 2023))
                        ),
                        mainPanel(
                          dataTableOutput("dataTable")
                        )
                      ))
  )
))



# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
