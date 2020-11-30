
library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))
mpgData$cyl<-as.factor(mpgData$cyl)
mpgData$gear<-as.factor(mpgData$gear)
mpgData$carb<-as.factor(mpgData$carb)
mpgData$vs<-as.factor(mpgData$vs)

shinyServer(function(input, output, session) {
    
    checkedVal <- reactive({
        perm.vector <- as.vector(input$checkPredictores)
        predForm<-ifelse(length(perm.vector)>0,
                         predictors<-paste(perm.vector,collapse="+"),
                         "1")
        lmForm<-paste("mpg~",predForm,sep="") 
        
    }) 
    
    fitModel<-reactive({
        fitFormula<-as.formula(checkedVal())
        lm(fitFormula,data=mpgData)
    })
    
    output$caption <- renderText({
        checkedVal()
    })
    
    output$fit <- renderPrint({
        summary(fitModel())$coef
    })
    
    output$mpgPlot<-renderPlot({
        par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
        plot(fitModel(),sub.caption="Graficas de Diagnostico")
        
    })
    output$tblSumm <- DT::renderDataTable({
        DT::datatable(summary(fitModel())$coef,
                      extensions = "Buttons",
                      options = list(
                          lengthChange = FALSE,
                          dom = "Blfrtip",
                          buttons = c("copy", "csv", "excel", "pdf", "print")
                      )
        )
    })
    observe({
        query <- parseQueryString(session$clientData$url_search)
        if (!is.null(query[['predictor']])) {
            output$caption <- renderText({
                "Predictor Enviado por Parametros"
            })
        }
    })
})

