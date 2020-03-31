#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#'
app_server <- function(input, output, session) {
  # List the first level callModules here
  res <- callModule(mod_load_data_server, "load_data_ui_1")

  callModule(mod_draw_graph_server, "draw_graph_ui_1", react = res)
  
  callModule(mod_show_data_server, "show_data_ui_1", react = res)
  
}
