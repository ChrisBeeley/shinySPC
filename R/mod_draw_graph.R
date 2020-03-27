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
    plotOutput(ns("showData"))
  )
}

#' draw_graph Server Function
#'
#' @noRd 
mod_draw_graph_server <- function(input, output, session, react){
  ns <- session$ns
  
  # look at column selection -> to THREE columns- time, measure, and small multiple
  
  output$showData <- renderPlot({
    
    df <- react()
    
    names(df) <- c("Date", "Value")

    df %>%
      qicharts2::qic(Date, Value,
          data     = .)
  })
}
