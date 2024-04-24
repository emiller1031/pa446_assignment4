library(shiny)
library(tidyverse)
library(plotly)
library(shinythemes)

# define data
movies <- read_csv("C:\\Users\\eemil\\Documents\\courses\\spr24\\pa446\\pa446_assignment4\\movieratings_a4\\movieratings.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
    # select theme
    theme = shinytheme("slate"),

    # Application title
    titlePanel("Movie Ratings"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectizeInput("yaxis",
                        "Y-Axis",
                        choice = c("IMDB rating" = "imdb_rating",
                                   "IMDB number of votes" = "imdb_num_votes",
                                   "Critics Score" = "critics_score",
                                   "Audience Score" = "audience_score",
                                   "Run time" = "runtime")),
            selectizeInput("xaxis",
                           "X-Axis",
                           choice = c("IMDB rating" = "imdb_rating",
                                      "IMDB number of votes" = "imdb_num_votes",
                                      "Critics Score" = "critics_score",
                                      "Audience Score" = "audience_score",
                                      "Run time" = "runtime")),
            selectizeInput("color",
                           "Color by:",
                           choice = c("Title Type" = "title_type",
                                      "Genre" = "genre",
                                      "MPAA Rating" = "mpaa_rating",
                                      "Critics Rating" = "critics_rating",
                                      "Run time" = "runtime")),
            sliderInput("alpha",
                        "Alpha:",
                        value = 0.5,
                        min = 0,
                        max = 1),
            sliderInput("size",
                        "Size",
                        value = 2.5,
                        min = 0,
                        max = 5),
            textInput("title",
                      "Plot Title")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("moviePlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$moviePlot <- renderPlotly({
    moviegraph <- movies %>%
      ggplot() +
      geom_point(aes_string(
        x = input$xaxis,
        y = input$yaxis,
        color = input$color
      ), alpha = input$alpha, size = input$size) +
      ggtitle(input$title)
    moviegraph <- ggplotly(moviegraph)
    print(moviegraph)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
