
library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
    archivoCarga1 <- reactive({
        if ( is.null(input$uploadFile1)){
            return(NULL)
        }
        ext<-strsplit(input$uploadFile1$name, split="[.]")[[1]][2]
        if ( ext == 'csv') {
            file_data <- readr::read_csv(input$uploadFile1$datapath)
            return(file_data)
        }
        if ( ext == 'tsv') {
            file_data <- readr::read_tsv(input$uploadFile1$datapath)
            return(file_data)
        }
        return(NULL)
    })
    
    output$contenidoArchivo1 <- renderTable({
        archivoCarga1()
    })
    archivoCarga2 <- reactive({
        if ( is.null(input$uploadFile2)){
            return(NULL)
        }
        ext<-strsplit(input$uploadFile2$name, split="[.]")[[1]][2]
        if ( ext == 'csv') {
            file_data <- readr::read_csv(input$uploadFile2$datapath)
            return(file_data)
        }
        if ( ext == 'tsv') {
            file_data <- readr::read_tsv(input$uploadFile2$datapath)
            return(file_data)
        }
        return(NULL)
    })
    
    output$contenidoArchivo2 <- DT::renderDataTable({
        archivoCarga2() %>%DT::datatable( filter="bottom")
    })
    
    output$tabla1 <- DT::renderDataTable({
        diamonds %>%  
                datatable() %>% 
                formatCurrency("price") %>% 
                formatString(c("x","y", "z"), suffix = " mm")
    })
    
    output$tabla2 <- DT::renderDataTable({
        mtcars %>%  
            datatable(
                options = list(
                    pageLength = 5,
                    lengthMenu = c(5,10,15)
                ),
                filter = "top"
            )
    })
    
    output$tabla3 <- DT::renderDataTable({
        iris %>%  
            datatable(
                extensions = 'Buttons',
                options = list(
                    dom="Bfrtip",
                    buttons = c('csv')
                )
            )
    })
    output$tabla4 <- renderDataTable({
        mtcars %>% datatable(selection ='single')
    })
    output$tabla4singleclick <- renderText({
        input$tabla4_rows_selected
    })
    output$tabla5 <- renderDataTable({
        mtcars %>% datatable()
    })
    output$tabla5singleclick <- renderText({
        input$tabla5_rows_selected
    })
    
    
    output$tabla6 <- renderDataTable({
        mtcars %>% datatable(
            selection = list(mode="single", target="column")
        )
    })
    output$tabla6singleclick <- renderText({
        input$tabla6_columns_selected
    })
    
    
    output$tabla7 <- renderDataTable({
        mtcars %>% datatable(
            selection = list(mode="multiple", target="column"))
    })
    output$tabla7singleclick <- renderText({
        input$tabla7_columns_selected
    })
    
    output$tabla8 <- renderDataTable({
        mtcars %>% datatable(
            selection = list(mode="single", target="cell"))
    })
    output$tabla8singleclick <- renderText({
        input$tabla8_cells_selected
    })
    
    output$tabla9 <- renderDataTable({
        mtcars %>% datatable(
            selection = list(mode="multiple", target="cell"))
    })
    output$tabla9singleclick <- renderPrint({
        input$tabla9_cells_selected
    })
})
