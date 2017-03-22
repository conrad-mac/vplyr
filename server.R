library(shiny)

function(input, output) {
    
    loadTable <- reactive({
        mpg %>% #rename variables so they are better understood by speech recognition
            rename(displacement = displ, 
                   cylinder = cyl,
                   transmission = trans, 
                   drive = drv,
                   city = cty, 
                   highway = hwy, 
                   fuel = fl)
    })
    
    # modifyTable <- reactive({
    #     if(is.null(input$filterVar) | is.null(input$filterVal)){
    #         return(loadTable())
    #     }else {
    #         filter_(.data = loadTable(), 
    #                 .dots = interp(
    #                     ~ x == input$filterVal, 
    #                     x = as.name(input$filterVar)
    #                 )
    #         )
    #     }
    #     
    # })
    
    modifyTable <- reactive({
        
        #Load table in to object
        dset <- loadTable()
        
        #Create switches for dplyr verbs
        filter_switch <- !is.null(input$filterVar) & !is.null(input$filterVal)
        select_switch <- !is.null(input$selectVar)
        
        #Pipe dataset through verbs
        dset %>%
        {if(filter_switch == TRUE) filter_(.data = ., .dots = interp(~x == y, x = as.name(input$filterVar), y = input$filterVal)) else .} %>%
        {if(select_switch == TRUE) select_(.data = ., input$selectVar) else .} 
        
    })
    
    output$table <- renderPrint({
        modifyTable()
    })
    
    output$plot <- renderPlotly({
        
        if(is.null(input$plotVar)){
            ggplotly(
                ggplot() + 
                    geom_bar() + 
                    xlim(0, 10) + 
                    ylim(0, 100)
            )
            
        } else {
            ggplotly(
                ggplot(data = modifyTable()) +
                    geom_bar(aes_string(input$plotVar), alpha = 0.8)
            )
        }
    })
    
    output$currentFilterVar <- renderText({
        if(is.null(input$filterVar)){return()}
        
        paste("Current filter variable:", input$filterVar)
    })
    
    output$currentFilterVal <- renderText({
        if(is.null(input$filterVal)){return()}
        
        paste("Current filter value:", input$filterVal)
    })
    
    output$currentSelectVar <- renderText({
        if(is.null(input$selectVar)){return()}
        
        paste("Current select variable:", input$selectVar)
    })
    
    output$currentPlotVar <- renderText({
        if(is.null(input$plotVar)){return()}
        
        paste("Current plot variable:", input$plotVar)
    })
}