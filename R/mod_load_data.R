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
    fileInput(ns("file"), "Upload data"),
    uiOutput(ns("colTypes"))
  )
}
    
#' load_data Server Function
#'
#' @noRd 
mod_load_data_server <- function(input, output, session){
  ns <- session$ns
  
  output$colTypes <- renderUI({
    
    purrr::map(spreadsheet(), function(x){
      
      selectInput(session$ns(names(x)), names(x), 
                  choices = c("numeric", "date", "character", "logical"), 
                  selected = class(x))
    })
  })

  file_path <- reactive({
    req(input$file)
  })

  spreadsheet <- reactive({
    clean_data(file_path()$datapath, col_types = input$colTypes)
  })
  
  reactive({
    spreadsheet()
  })
}


