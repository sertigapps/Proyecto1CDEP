
library(shiny)
library(DT)
shinyUI(fluidPage(

    titlePanel("Cargar Archivos y Dataframes"),
    tabsetPanel(
        tabPanel("Cargar Archivo",
                 sidebarLayout(
                     sidebarPanel(
                         h2("Subir Archivo"),
                         fileInput("uploadFile1", 
                                   label = "Seleccione un Archivo",
                                   buttonLabel =  "Cargar",
                                   accept = c("csv", "tsv"))
                         ),
                     mainPanel(
                         tableOutput("contenidoArchivo1")
                     )
                 )
                 ),
        tabPanel("Cargar Archivo",
                 sidebarLayout(
                     sidebarPanel(
                         h2("Subir Archivo"),
                         fileInput("uploadFile2", 
                                   label = "Seleccione un Archivo",
                                   buttonLabel =  "Cargar",
                                   accept = c("csv", "tsv"))
                         ),
                     mainPanel(
                         DT::dataTableOutput("contenidoArchivo2")
                     )
                 )
                 ),
        tabPanel( "Dt option",
                  h2("Formato Columna"),
                  hr(),
                  fluidRow(
                      column(width=12,
                             DT::dataTableOutput("tabla1"))
                  ),
                  h2("Opciones"),
                  hr(),
                  fluidRow(
                      column(width=12,
                             DT::dataTableOutput("tabla2"))
                  ),
                  fluidRow(
                      column(width=12,
                             DT::dataTableOutput("tabla3"))
                  )
                  ),
        tabPanel(
            "Clicks en tabla",
            fluidRow(
                column(width=12,
                       h2("Click en una fila"),
                       dataTableOutput("tabla4"),
                       verbatimTextOutput("tabla4singleclick"))
            ),
            fluidRow(
                column(width=12,
                       h2("Click en varias fila"),
                       dataTableOutput("tabla5"),
                       verbatimTextOutput("tabla5singleclick"))
            ),
            fluidRow(
                column(width=12,
                       h2("Click en una columna"),
                       dataTableOutput("tabla6"),
                       verbatimTextOutput("tabla6singleclick"))
            ),
            fluidRow(
                column(width=12,
                       h2("Click en varias columnas"),
                       dataTableOutput("tabla7"),
                       verbatimTextOutput("tabla7singleclick"))
            ),
            fluidRow(
                column(width=12,
                       h2("Click en una celda"),
                       dataTableOutput("tabla8"),
                       verbatimTextOutput("tabla8singleclick"))
            ),
            fluidRow(
                column(width=12,
                       h2("Click en varias celdas"),
                       dataTableOutput("tabla9"),
                       verbatimTextOutput("tabla9singleclick"))
            )
        )
    )
))
