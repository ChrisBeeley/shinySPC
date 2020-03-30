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
  
  file_path <- reactive({
    req(input$file)
  })
  
  spreadsheet <- reactive({
    clean_data(file_path()$datapath)
  })
  
  list(
    data = reactive(spreadsheet()),
    interface = reactive(
      renderUI({
        textInput(session$ns("firstInput"), label = "Hello", value = "")
      })
    )
  )
  
  
  # col_types <- purrr::map_chr(spreadsheet(), class)
  
  # purrr::map(session$ns(col_types), ~ textInput(.x, NULL))
  
  # textInput(inputId = session$ns("firstInput"), label = "Hello", value = "")
  
}


