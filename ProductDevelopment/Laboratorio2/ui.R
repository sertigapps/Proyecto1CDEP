#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Graficas en Shiny"),
    tabsetPanel(
        tabPanel(
            "Plot",
            h1("Graficas Base de R"),
            plotOutput("gbr"),
            h1("Graficas con GGPLOT"),
            plotOutput("gggp")
            ),
        tabPanel(
            "Plot User Interactions",
            plotOutput("pco",
                       click= "clk",
                       dblclick = "dclk",
                       hover = "mhover",
                       brush = "mbrush",
                       ),
            verbatimTextOutput("click_data"),
            tableOutput("mtct"            ),
            tableOutput("mtctb"            ),
            useShinyjs()
            )
    )
))
