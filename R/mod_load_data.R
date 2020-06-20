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
    uiOutput(ns("colTypes")),
    selectInput(ns("dateFormat"), "Date format",
                choices = c("DD-MM-YYYY" = "%d-%m-%Y", 
                            "MM-DD-YYYY" = "%m-%d-%Y",
                            "YYYY-MM-DD" = "%Y-%m-%d",
                            "DD/MM/YYYY" = "%d/%m/%Y", 
                            "MM/DD/YYYY" = "%m/%d/%Y",
                            "YYYY/MM/DD" = "%Y/%m/%d")
    )
  )
}

#' load_data Server Function
#'
#' @noRd 
mod_load_data_server <- function(input, output, session){
  ns <- session$ns
  
  output$colTypes <- renderUI({
    
    spreadsheet_load <- clean_data(file_path()$datapath)
    
    purrr::pmap(list(spreadsheet_load, names(spreadsheet_load)), function(data_m, names_m){
      
      selectInput(session$ns(names_m), names_m, 
                  choices = c("numeric" = "numeric", 
                              "Date" = "character_date", 
                              "character" = "character", 
                              "logical" = "logical"), 
                  selected = class(data_m))
    })
  })
  
  file_path <- reactive({
    req(input$file)
  })
  
  spreadsheet <- reactive({
    
    spreadsheet_load <- clean_data(file_path()$datapath)
    
    cols <- purrr::map_chr(names(spreadsheet_load), ~ input[[.x]])
    
    golem::cat_dev(str(cols))
    
    golem::cat_dev(str(input$dateFormat))
    
    read_data <- clean_data(file_path()$datapath,
                            col_types = class_to_reader(read_type = "readr", cols))
    
    read_data %>% 
      dplyr::mutate_at(.vars = which(cols == "character_date"),
                ~ as.Date(., format = input$dateFormat))
  })
  
  reactive({
    spreadsheet()
  })
}


