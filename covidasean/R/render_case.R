#' Server side for rendering cases plot (main plot)
#'
#'@import plotly
#'
#'@noRd
#'

render_case <- function(){

renderPlotly({
  total_case <- covid_asean_df %>%
    group_by(country) %>%
    summarise(confirmed_cases = sum(new_cases))

  total_case %>%
    plot_ly(x = ~country, y = ~confirmed_cases) %>%
    config(displayModeBar = F)
})

}
