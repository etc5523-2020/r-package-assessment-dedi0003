#' @title
#' Launching Shiny Dashboard of Covid ASEAN
#'
#'@description
#'This function will launch shiny app dashboard which users can select several parameters on the dashboard, i.e. country, date range and mobility trend category. Detail explanation of the use is available on the dashboard.
#'
#'@references Gassen, Joachim. 2020. Tidycovid19: Download, Tidy and Visualize Covid-19 Related Data.
#' (\href{https://joachim-gassen.github.io/tidycovid19/}{Tidycovid19}),
#'
#' Chang, Winston, Joe Cheng, JJ Allaire, Yihui Xie, and Jonathan McPherson. 2020. Shiny: Web Application Framework for R.
#' (\href{https://CRAN.R-project.org/package=shiny}{Shiny}).
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
