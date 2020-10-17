#'
#'Sidebar function for user interface (called in shiny app.R)
#'
#'@noRd
#'
#'@export
#'
left_sidebar <- function(){
  # plotly preparation

mobility_trend <- c("workstations", "stations", "groceries",
                      "recreations", "parks", "residentials")

sidebarPanel(
  img(src='https://www.brproud.com/wp-content/uploads/sites/80/2020/08/giphy-2.gif', align = "center", width = "100%"),
  textOutput("text_image"),
  selectInput(
    inputId = "variable",
    label = "Select People's Mobility Trend Category",
    choices = mobility_trend,
    multiple = FALSE),

  dateRangeInput("dateRange",
                 "Select Date Range for Mobility Trend",
                 start = covid_asean_df$date[1], separator = "up to",
                 end = max(covid_asean_df$date)),
  selectInput(
    inputId = "table",
    label = "Select Country Information for Summary Table",
    choices = covid_asean_df$country,
    selected = covid_asean_df$country["Indonesia"],
    multiple = FALSE),
  textOutput("text_table"),
  tableOutput('table'),
  div(h5(icon("book-reader", lib = "font-awesome"), "Bibliography")),
  actionButton("show_button", "Show"),
  actionButton("hide_button", "Hide")
)
}
