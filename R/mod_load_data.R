#' load_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_load_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    fileInput(ns("file"), "Upload data")
  )
}
    
#' load_data Server Function
#'
#' @noRd 
mod_load_data_server <- function(input, output, session){
  ns <- session$ns
  
  file_path <- reactive({
    req(input$file)
  })

  reactive({
    readr::read_csv(file_path()$datapath)
  })
}
