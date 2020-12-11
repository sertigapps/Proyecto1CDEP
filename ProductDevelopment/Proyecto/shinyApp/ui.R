library(shiny)
library(leaflet.minicharts)
library(leaflet)
library(RMariaDB)
con_sql <- dbConnect(RMariaDB::MariaDB(), user='user', password='PD2020GALILEO', dbname='db', host='127.0.0.1')

geoloc <- dbReadTable(conn = con_sql, name = 'geoloc')
paises <- unique(geoloc['pais'])
shinyUI(
    fluidPage(
        titlePanel("COVID19 DASHBOARD - PROYECTO"),
        tabsetPanel(
            tabPanel(
                "Mapa Interactivo",
                sliderInput(inputId = "date", "Fecha:", min = 
                                as.Date("2020-01-20"), max = as.Date("2020-12-30"), 
                            value = as.Date("2020-06-11"), width = "600px"),
                selectInput("mapavar", h4("Estadistico"), choices 
                            =c("Casos","Muertes","Recuperados"), selected = "Casos"),
                
                leafletOutput(outputId = "distPlot", width = "700px", 
                              height = "300px")
            ),
            tabPanel(
                "Grafica por pais",sidebarLayout(
                    
                    sidebarPanel(
                        h3("Informacion ultimo mes"),
                        selectInput("selectedcountry", h4("Pais"), choices 
                                    =paises, selected = "US"),
                        selectInput("selectedhistoricwindow", h4("Estadistico"), 
                                    choices = list("Casos Totales", "Recuperaciones Totales", "Muertes Totales"), selected = "Casos Totales"),
                        checkboxInput("dailynew", "Mostrar nuevos diarios", 
                                      value = FALSE),
                        width = 3  
                    ),
                    
                    mainPanel (
                        plotOutput(outputId = "Plotcountry", width = "500px", 
                                   height = "300px")
                    )
                )
            )
        )
    )
)
