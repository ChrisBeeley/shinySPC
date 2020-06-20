#' show_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_show_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    DT::dataTableOutput(ns("table"))
  )
}
    
#' show_data Server Function
#'
#' @noRd 
mod_show_data_server <- function(input, output, session, react){
  ns <- session$ns
  
  output$table <- DT::renderDataTable({
    
    df <- react()

    DT::datatable(df, rownames = FALSE)
  })
}
