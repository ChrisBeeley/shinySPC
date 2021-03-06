#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          h1("shinySPC"),
          mod_load_data_ui("load_data_ui_1")
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Preview data",
                     p("Ensure that you have the correct data types on the left"),
                     mod_show_data_ui("show_data_ui_1")),
            tabPanel("SPC", 
                     mod_draw_graph_ui("draw_graph_ui_1")
            )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'shinySPC'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

