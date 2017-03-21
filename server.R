library(shiny)

function(input, output) {
    
    loadTable <- reactive({
        mpg %>% #rename variables to be better understood by speech recognition
            rename(displacement = displ, 
                   cylinder = cyl,
                   transmission = trans, 
                   drive = drv,
                   city = cty, 
                   highway = hwy, 
                   fuel = fl)
    })
    
    filterTable <- reactive({
        if(is.null(input$filterVar) | is.null(input$filterVal)){
            return(loadTable())
        }else {
            filter_(.data = loadTable(), 
                    .dots = interp(
                        ~ x == input$filterVal, 
                        x = as.name(input$filterVar)
                    )
            )
        }
        
    })
    
    output$table <- renderPrint({
        filterTable()
    })
    
    output$plot <- renderPlotly({
        
        if(is.null(input$plotvar)){
            ggplotly(
                ggplot() + 
                    geom_point() + 
                    xlim(0, 10) + 
                    ylim(0, 100)
            )
            
        } else {
            ggplotly(
                ggplot(data = filterTable()) +
                    geom_bar(aes_string(input$plotvar), alpha = 0.6)
            )
        }
    })
    
    # output$currentVerb <- renderText({
    #     paste(input$verb)
    # })
    # 
    # output$currentParam1 <- renderText({
    #     paste(input$param1)
    # })
    # 
    # output$currentVal1 <- renderText({
    #     paste(input$val1)
    # })
    # 
    # output$currentPlotVar1 <- renderText({
    #     paste(input$plotvar1)
    # })
}