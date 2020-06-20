#' draw_graph UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_draw_graph_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("axisSelection")),
    plotOutput(ns("showData"))
  )
}

#' draw_graph Server Function
#'
#' @noRd 
mod_draw_graph_server <- function(input, output, session, react){
  ns <- session$ns
  
  output$axisSelection <- renderUI({
    
    tagList(
      fluidRow(
        column(2, 
               selectInput(ns("xAxis"), "X- axis", choices = names(react()),
                           selected = names(react())[1])),
        column(2, 
               selectInput(ns("yAxis"), "Y- axis", choices = names(react()),
                           selected = names(react())[2]))
      )
    )
  })
  
  # look at column selection -> to THREE columns- time, measure, and small multiple
  
  output$showData <- renderPlot({
    
    df <- react() %>% 
      dplyr::select(input$xAxis, input$yAxis)
    
    names(df) <- c("Time", "Value")
    
    df %>%
      qicharts2::qic(Time, Value,
                     data     = .)
  })
}
