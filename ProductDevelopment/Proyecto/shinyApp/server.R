
library(shiny)
library(RMariaDB)
library(dplyr)
con_sql <- dbConnect(RMariaDB::MariaDB(), user='user', password='PD2020GALILEO', dbname='db', host='127.0.0.1')
casos <- dbReadTable(conn = con_sql, name = 'casos')
muertes <- dbReadTable(conn = con_sql, name = 'muertes')
recuperados <- dbReadTable(conn = con_sql, name = 'recuperados')
geoloc <- dbReadTable(conn = con_sql, name = 'geoloc')
paises <- unique(geoloc['pais'])
geo <- geoloc[!duplicated(geoloc[,c('pais')]),]
shinyServer(function(input, output){
    
    #Assign output$distPlot with renderLeaflet object
    output$distPlot <- renderLeaflet({
        datos <- casos
        if(input$mapavar=="Muertes") {
            datos <- muertes
        }
        if(input$mapavar=="Recuperados") {
            datos <- recuperados
        }
        daten <- datos[datos$fecha == input$date, 2:4 ]
        daten <- daten %>%
            group_by(pais, fecha) %>%
            summarise(count=sum(count))
        daten$fecha <- NULL
        X <- data.frame(t(daten$count))
        colnames(X) <- daten$pais
        basemap= leaflet()  %>%
            addProviderTiles(providers$Stamen.TonerLite,
                             options = providerTileOptions(noWrap = TRUE)) 
        chartcolors = rep("black",191)
        print("Changed")
        basemap %>%
            addMinicharts(
                geo$lon, geo$lat,
                chartdata = as.numeric(X[1,c(2:8)]),
                showLabels = TRUE,
                fillColor = chartcolors,
                labelMinSize = 5,
                width = 45,
                transitionTime = 1
            ) 
    })

    output$Plotcountry <- renderPlot({
        datos <- casos
        
        if(input$selectedhistoricwindow=="Muertes Totales") {
            datos <- muertes
        }
        if(input$selectedhistoricwindow=="Recuperaciones Totales") {
            datos <- recuperados
        }
        chosencountry = input$selectedcountry
        today = as.Date("2020/12/11")
        daten <- datos[datos$pais == chosencountry, 2:4 ]
        daten <- daten %>%
            group_by(pais, fecha) %>%
            summarise(count=max(count))
        pastdays=60
        startday = today-pastdays-1
        print(daten)
        daten$fecha=as.Date(daten$fecha,"%Y-%m-%d")
        print(daten)
        selecteddata = daten[(daten$fecha>startday)&(daten$fecha<(today+1)),2:3]
        print(selecteddata)
        
        #assign the upperbound of the y-aches (maximum+100)
        upperboundylim = max(selecteddata[,2])+100
        
        #the case if the daily new confirmed cases are also
        #plotted
        if (input$dailynew == TRUE){
            
            plot(selecteddata$fecha, selecteddata$count, type = "b", 
                 col = "blue", xlab = "Fecha", 
                 ylab = "Numero de Infectados", lwd = 3, 
                 ylim = c(0, upperboundylim))
            par(new = TRUE)
            plot(selecteddata$fecha, c(0, diff(selecteddata$count)), 
                 type = "b", col = "red", xlab = "", ylab = 
                     "", lwd = 3,ylim = c(0,upperboundylim))
            legend(selecteddata$fecha[1], upperboundylim*0.95, 
                   legend=c("Casos Nuevos", "Casos Totales"), 
                   col=c("red", "blue"), lty = c(1,1), cex=1)
        }
        
        if (input$dailynew == FALSE){
            plot(selecteddata$fecha, selecteddata$count, type = "b", 
                 col = "blue", xlab = "Fecha", 
                 ylab = "Numero de Infectados", lwd = 3,
                 ylim = c(0, upperboundylim))
            par(new = TRUE)
            legend(selecteddata$fecha[1], upperboundylim*0.95, 
                   legend=c("Casos Totales"), col=c("blue"), 
                   lty = c(1), cex=1)
        }
        
    })
    
})
