
library(shiny)
library(shinyjs)
library(RMariaDB)
con_sql <- dbConnect(RMariaDB::MariaDB(), user='user', password='PD2020GALILEO', dbname='db', host='127.0.0.1')
academatica_video_stats <- dbReadTable(conn = con_sql, name = 'academatica_video_stats')
academatica_videos_metadata <- dbReadTable(conn = con_sql, name = 'academatica_videos_metadata')
academatica_videos <- dbReadTable(conn = con_sql, name = 'academatica_videos')
opciones_est <- c('Vistas', 'Likes', 'Dislike', 'Favoritos', 'Comentarios')
shinyUI(fluidPage(
    titlePanel("Parcial 1"),
    tabsetPanel(
        tabPanel(
            "Informacion Videos",
            selectInput(
                "SelectInputM",
                "Seleccione un Video",
                choices=academatica_videos$id,
                selected = "",
                multiple= FALSE
            ),
            h2('Id Video'),
            verbatimTextOutput("id_movie"),
            h2('Titulo Video'),
            verbatimTextOutput("title_movie"),
            h2('Descripcion Video'),
            verbatimTextOutput("desc_movie"),
            h2('Link Video'),
            verbatimTextOutput("link_movie"),
        ),
        tabPanel(
            "Estadisticas Globales",
            selectInput(
                "SelectInputSt",
                "Seleccionar Estadistica",
                choices=opciones_est,
                selected = "",
                multiple= FALSE
            ),
            plotOutput(outputId = "distPlot"),
            h2('Minimo'),
            verbatimTextOutput("min"),
            h2('Maximo'),
            verbatimTextOutput("max"),
            h2('Media'),
            verbatimTextOutput("med"),
            h2('Mediana'),
            verbatimTextOutput("median"),
        )
    )
))
