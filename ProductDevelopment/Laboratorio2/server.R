#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(shinyjs)
out_click<- NULL
out_hover<-NULL

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$gbr <- renderPlot({
        plot(mtcars$wt,mtcars$mpg,xlab="Weight",ylab="Miles per Gal")
    })
    output$gggp <- renderPlot({
        diamonds %>%
            sample_n(10000) %>%
            ggplot(aes(x=carat,y=price,color=color))+
            geom_point()+
            ylab("Price")+
            xlab("Carat")+ggtitle("Diamod Price per Carat")
    })
    output$pco <- renderPlot({
        plot(mtcars$wt,mtcars$mpg,xlab="Weight",ylab="Miles per Gal")
        #diamonds %>%
            #sample_n(10000) %>%
            #ggplot(aes(x=carat,y=price,color=color))+
            #geom_point()+
            #ylab("Price")+
            #xlab("Carat")+ggtitle("Diamod Price per Carat")
    })
    output$click_data <- renderPrint({
        if(!is.null(input$clk$x)){
            print(paste0("Click coordenada X = ", round(input$clk$x,2)," ",
                         "Click coordenada Y = ", round(input$clk$y,2)," "))
        }
        if(!is.null(input$dclk$x)){
            print(paste0("Doble Click coordenada X = ", round(input$dclk$x,2)," ",
                         "Doble Click coordenada Y = ", round(input$dclk$y,2)," "))
        }
        if(!is.null(input$mhover$x)){
            print(paste0("Hover coordenada X = ", round(input$mhover$x,2)," ",
                         "Hover coordenada Y = ", round(input$mhover$y,2)," "))
        }
        if(!is.null(input$mbrush$xmin)){
            print(paste0("Cordenadas Rect ", round(input$mbrush$xmin,2)," "
                         , round(input$mbrush$xmax,2)," ", round(input$mbrush$ymin,2)," ",
                         round(input$mbrush$ymax,2)," "))
        }
    })
    output$mtct <- renderTable({
        mtcars_df <- cbind(row.names(mtcars),mtcars)
        df <- nearPoints(mtcars_df,input$clk,xvar = 'wt', yvar='mpg')
        if ( nrow(df) != 0){
            df
        } else {
            NULL
        }
    })
    output$mtctb <- renderTable({
        mtcars_df <- cbind(row.names(mtcars),mtcars)
        df <- brushedPoints(mtcars_df,input$mbrush,xvar = 'wt', yvar='mpg')
        if ( nrow(df) != 0){
            df
        } else {
            NULL
        }
    })
    puntos <- reactive({
        if(!is.null(input$clk$x)){
            df<-nearPoints(mtcars,input$clk,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- rbind(out_click,out) %>% distinct()
            return(out)
        }
        if(!is.null(input$mhover$x)){
            df<-nearPoints(mtcars,input$mhover,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_hover <<- out
            return(out_hover)
        }
        
        if(!is.null(input$dclk$x)){
            df<-nearPoints(mtcars,input$dclk,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- setdiff(out_click,out)
            return(out_hover)
        }
        
        if(!is.null(input$mbrush)){
            df<-brushedPoints(mtcars,input$mbrush,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- rbind(out_click,out) %>% dplyr::distinct()
            return(out_hover)
        }
        
        
        
    })
    mtcars_plot <- reactive({
        plot(mtcars$wt,mtcars$mpg,xlab="wt",ylab="Miles per Galon")
        puntos <-puntos()
        if(!is.null(out_hover)){
            points(out_hover[,1],out_hover[,2],
                   col='gray',
                   pch=16,
                   cex=2)}
        if(!is.null(out_click)){
            points(out_click[,1],out_click[,2],
                   col='green',
                   pch=16,
                   cex=2)}
        
        
        
        
        
        
    })
    output$pco <- renderPlot({
        
        mtcars_plot()
    })
})
