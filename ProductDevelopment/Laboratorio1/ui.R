library(shiny)
library(lubridate)

shinyUI(fluidPage(
    titlePanel("Inputs en Shiny"),
    tabsetPanel(tabPanel("Inputs Examples",
                         sidebarLayout(
                            sidebarPanel(
                                sliderInput(
                                  "Slider-Input",
                                  "Seleccione Valor",
                                  value=50,
                                  min = 0,max =100,
                                  step = 10, post='%',animate=TRUE
                                ),
                                sliderInput(
                                    "Slider-Input2",
                                    "Seleccione un rango",
                                    value=c(0,200),
                                    min = 0,max =200,
                                    step = 10,animate=TRUE
                                )
                                ,
                                selectInput(
                                    "SelectInput",
                                    "Seleccione un Auto",
                                    choices=rownames(mtcars),
                                    selected = "Camaro Z28",
                                    multiple= FALSE
                                )
                                ,
                                selectizeInput(
                                    "SelectInputm",
                                    "Seleccione Multiples Auto",
                                    choices=rownames(mtcars),
                                    selected = "Camaro Z28",
                                    multiple= TRUE
                                )
                                
                                ,
                                dateInput(
                                    "DateInput",
                                    "Ingrese la Fecha",
                                    value= today(),
                                    min = today()-60,
                                    max=today()+30,
                                    language = 'es',
                                    weekstart = 1),
                                dateRangeInput("DateRangeInput", "Ingrese Fechas",
                                               start=today()-7,
                                               end=today(),separator='a' 
                                ),
                                numericInput("NumericInput","Ingrese un numero",
                                             value = 10, min = 0, max = 100, step = 1),
                                checkboxInput("SingleBox", "Seleccione si Verdadero", value= FALSE),
                                checkboxGroupInput("GroupBox", "Seleccione Opciones :",
                                                   choices = LETTERS[1:5]),
                                radioButtons("RadioButton", "Seleccione Genero",
                                             choices = c("Masculino", "Femenino")
                                             ),
                                textInput("TextInput", "Ingrese Texto"),
                                passwordInput("Password", "Password"),
                                textAreaInput("TextArea", "Ingrese Parrafo"),
                                actionButton("ActionButton","ok"),
                                actionLink("ActionLink", "Siguiente")
                            ),
                            mainPanel(
                                h2("Slide Input Secillo"),
                                verbatimTextOutput("slider-io"), 
                                h2("Slide Input Rango"),
                                verbatimTextOutput("slider-io2"),
                                h2("Select Input"),
                                verbatimTextOutput("selectinput"),
                                h2("Select Input Multiple"),
                                verbatimTextOutput("selectinputm"),
                                h2("Date Input"),
                                verbatimTextOutput("dinput"),
                                h2("DateRangeInput"),
                                verbatimTextOutput("drinput"),
                                h2("Numeric Input"),
                                verbatimTextOutput("ninput"),
                                h2("Single Box"),
                                verbatimTextOutput("sbinput"),
                                h2("Group Box"),
                                verbatimTextOutput("gbinput"),
                                h2("Radio Buttons"),
                                verbatimTextOutput("rbinput"),
                                h2("Text Input"),
                                verbatimTextOutput("tinput"),
                                h2("Password Input"),
                                verbatimTextOutput("pinput"),
                                h2("Text Area"),
                                verbatimTextOutput("tainput"),
                                h2("Action button"),
                                verbatimTextOutput("abutton"),
                                h2("Action Link"),
                                verbatimTextOutput("lbutton")
                            )
                         )
        )
    )
   
))
