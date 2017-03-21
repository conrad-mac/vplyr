library(shiny)
library(tidyverse)
library(lazyeval)
library(plotly)
library(dplyr)
library(shinythemes)
library(shinyBS)

navbarPage(
    
    header = singleton(tags$head(
        tags$script(src="//cdnjs.cloudflare.com/ajax/libs/annyang/2.6.0/annyang.min.js"),
        tags$link(href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css", rel="stylesheet"),
        includeScript('init.js')
    ))
    
    ,title = "vplyr - dplyr with voice recognition"
    
    ,theme = shinytheme("superhero")
    
    ,tabPanel("Data Analysis",
              fluidRow(
                  column(9,
                         div(class="message",
                             HTML(
                                 '<p><i class="fa fa-fw fa-microphone"></i>
                                    Welcome to vplyr!
                                    To load the <b>mpg</b> dataset, say "load data". For
                                    more commands say "show list".
                                  </p>'
                             )
                         ),
                         div(class="userSpeech"),
                         conditionalPanel(
                             condition = "input.loadTable == 1",
                             verbatimTextOutput("table")
                         ),
                         conditionalPanel(
                             condition = "input.showPlot == 1",
                             plotlyOutput("plot")
                         )
                  ),
                  column(3,
                         bsModal("commands_modal", "Voice commands", trigger = "commands", size = "large",
                                 p("To load the dataset, say ", 
                                   strong('"load data"')),
                                 p("To filter the dataset, say ", 
                                   strong('"filter variable + variable name (e.g. "filter variable class"). '),
                                   "Then say ",strong('"filter value + variable value (e.g. "filter value compact")"') ),
                                 p("To show the plot, say ", 
                                   strong('"show plot"')),
                                 p("To show/hide commands list say ",
                                   strong('"show/hide list"')),
                                 p("To reset all input paramaters say ",
                                   strong('"reset"'))
                         )
                         # ,
                         
                         # br(),
                         
                         # h3("Current inputs..."),
                         # h4("The current verb is ", 
                         #    strong(textOutput("currentVerb", inline = TRUE))),
                         # h4("The current parameter is ", 
                         #    strong(textOutput("currentParam1", inline = TRUE))),
                         # h4("The current value is ", 
                         #    strong(textOutput("currentVal1", inline = TRUE))),
                         # h4("The current graph variable is ", 
                         #    strong(textOutput("currentPlotVar1", inline = TRUE)))
                         
                  )
              )
    ),
    tabPanel("About"
             
    )
)
