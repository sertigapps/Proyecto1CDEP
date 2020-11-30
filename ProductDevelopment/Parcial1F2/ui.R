#
#
# Shiny app publicado en 
# https://lrglm16.shinyapps.io/parcial1f2
#

library(shiny)
library(datasets)
library(dplyr)
shinyUI(fluidPage(
    titlePanel("Regresion lineal de Mpg para uno o mas predictores"),
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("checkPredictores", 
                               label = h3("Predictor/es"), 
                               choices=names(select(mtcars,-mpg)),
                               selected = "cyl"
            ),
            width=3
        ),
        mainPanel(
            DT::dataTableOutput("tblSumm"),
            plotOutput("mpgPlot"),
            verbatimTextOutput("params")
        )
    )
))
