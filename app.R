library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("USA Census Visualization"),
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with information from the 2010 census"),
      selectInput(inputId = "var", 
                  label = "chose a variable", 
                  choices = list("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White")
    ),
    mainPanel(
      plotOutput(outputId = "map")
    )
  )
)

server <- function(input, output){
  
  output$map = renderPlot({
    counties <-reactive({
      race = readRDS("data/counties.rds")
      counties_map = map_data("county")
      
      counties_map = counties_map %>%
        mutate(name = paste(region, subregion, sep = ","))
      
      left_join(counties_map, race, by = "name")
    })
    #output of the last line is saved in counties
    myrace = switch(input$var,
                    "Percent White" = counties()$white,
                    "Percent Black" = counties()$black, 
                    "Percent Hispanic" = counties()$hispanic,
                    "Percent Asian" = counties()$asian
    )
  ggplot(counties(), aes(x = long, 
                       y = lat,
                       group = group,
                       fill = myrace)) +
    geom_polygon() +
    scale_fill_gradient(low = "white", high = "darkred") +
    theme_void()
  })
  

}

shinyApp(ui,server)

#paste is to contatenate
#usually we do explanary 
#switch
##reactive data: the last line is the output given the name. change all the others with ()