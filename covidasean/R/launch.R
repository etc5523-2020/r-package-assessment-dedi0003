#' Launch shiny covid ASEAN app
#'
#'@examples
#'launch_app()
#'
#'
#'
#' @export
launch_app <- function(){

  appDir <- system.file("app", "app.R", package = "covidasean")
  if (appDir == ""){
    stop("Could not find app directory.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")

}
