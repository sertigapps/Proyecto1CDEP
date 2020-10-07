#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
    output$`slider-io`<-renderText({
        paste0(c('Output Slider input: ', input$`Slider-Input`), collapse='')
    })
    
    output$`slider-io2`<-renderText({
        input$`Slider-Input2`
    })
    
    output$`selectinput`<-renderText({
        input$`SelectInput`
    })
    
    output$`selectinputm`<-renderText({
        input$`SelectInputm`
    })
    
    output$`dinput`<-renderText({
        input$`DateInput`
    })
    
    output$`drinput`<-renderText({
        input$`DateRangeInput`
    })
    
    output$`ninput`<-renderText({
        input$`NumericInput`
    })
    
    output$`sbinput`<-renderText({
        input$`SingleBox`
    })
    
    output$`gbinput`<-renderText({
        input$`GroupBox`
    })
    
    output$`tinput`<-renderText({
        input$`TextInput`
    })
    
    output$`tainput`<-renderText({
        input$`TextArea`
    })
    
    
    output$`abutton`<-renderText({
        input$`ActionButton`
    })
    
    
    output$`lbutton`<-renderText({
        input$`ActionLink`
    })
    
    
    output$`rbinput`<-renderText({
        input$`RadioButton`
    })
    output$`pinput`<-renderText({
        input$`Password`
    })
    
})
