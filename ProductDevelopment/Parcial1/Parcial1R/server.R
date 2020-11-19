

library(shiny)
library(RMariaDB)
con_sql <- dbConnect(RMariaDB::MariaDB(), user='user', password='PD2020GALILEO', dbname='db', host='127.0.0.1')
academatica_video_stats <- dbReadTable(conn = con_sql, name = 'academatica_video_stats')
academatica_videos_metadata <- dbReadTable(conn = con_sql, name = 'academatica_videos_metadata')
academatica_videos <- dbReadTable(conn = con_sql, name = 'academatica_videos')
selectedvideo<- NULL
dataStats<- NULL
# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    observeEvent(input$SelectInputM, {
        selectedvideo <- subset(academatica_videos_metadata, video_id == input$SelectInputM)
        output$id_movie <- renderPrint({
            if(!is.null(selectedvideo)){
                print(selectedvideo$video_id)
            }
        })
        output$title_movie <- renderPrint({
            if(!is.null(selectedvideo)){
                print(selectedvideo$title)
            }
        })
        output$desc_movie <- renderPrint({
            if(!is.null(selectedvideo)){
                print(selectedvideo$description)
            }
        })
        output$link_movie <- renderPrint({
            if(!is.null(selectedvideo)){
                print(selectedvideo$link)
            }
        })
    })
    
    observeEvent(input$SelectInputSt, {
        if ( input$SelectInputSt == 'Vistas') {
            dataStats <-academatica_video_stats$viewCount
        }
        if ( input$SelectInputSt == 'Likes') {
            dataStats <-academatica_video_stats$likeCount
            
        }
        if ( input$SelectInputSt == 'Dislike') {
            dataStats <-academatica_video_stats$dislikeCount
            
        }
        if ( input$SelectInputSt == 'Favoritos') {
            dataStats <-academatica_video_stats$favoriteCount
            
        }
        if ( input$SelectInputSt == 'Comentarios') {
            dataStats <-academatica_video_stats$commentCount
            
        }
        output$min <- renderPrint({
            min(dataStats)
        })
        output$max <- renderPrint({
            max(dataStats)
        })
        output$med <- renderPrint({
            mean(dataStats)
        })
        output$median <- renderPrint({
            median(dataStats)
        })
        output$distPlot <- renderPlot({
            x<- dataStats
            bins <- seq(min(x), max(x), length.out = 10 + 1)
            hist(x, breaks = bins, col = "#75AADB", border = "white",
                 xlab = "Histograma")
        })
    })
    
})
