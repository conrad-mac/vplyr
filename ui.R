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
        includeScript('init.js'),
        tags$link(rel = "stylesheet", type = "text/css", href = "vplyr.css")
    ))
    
    ,title = "vplyr - dplyr with voice recognition"
    
    ,theme = shinytheme("darkly")
    
    ,tabPanel("Analyse",
              fluidRow(
                  column(12,
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
                         br()
                  )
              ),
              fluidRow(
                  column(9,
                         conditionalPanel(
                             condition = "input.loadTable == 1",
                             verbatimTextOutput("table")
                         )
                         ,
                         conditionalPanel(
                             condition = "input.showPlot == 1",
                             plotlyOutput("plot")
                         )
                  ),
                  column(3,
                         bsModal("commands_modal", "Voice commands", trigger = "commands", size = "large",
                                 p("To load the dataset, say ", 
                                   strong('"load data"')),
                                 p("To hide the dataset, say ", 
                                   strong('"hide data"')),
                                 p("To filter the dataset, say ", 
                                   strong('"filter variable + variable name (e.g. "filter variable class"). '),
                                   "Then say ",strong('"filter value + variable value (e.g. "filter value compact")"') ),
                                 p("To show the plot window, say ", 
                                   strong('"show plot window"')),
                                 p("To plot a variable, say ", 
                                   strong('"plot variable + variable name (e.g. "plot variable city")"')),
                                 p("To show/hide the commands list say ",
                                   strong('"show/hide list"')),
                                 p("To reset all input paramaters say ",
                                   strong('"reset"'))
                         )
                         ,
                         
                         #Show current input paramaters
                         h4(textOutput("currentFilterVar", inline = TRUE))
                         ,h4(textOutput("currentFilterVal", inline = TRUE))
                         ,h4(textOutput("currentSelectVar", inline = TRUE))
                         ,h4(textOutput("currentPlotVar", inline = TRUE))
                         
                  )
              )
    )
    # ,tabPanel("About"
    #          
    # )
)
