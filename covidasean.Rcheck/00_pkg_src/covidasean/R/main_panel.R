#'Show a plot of the generated distribution
#'
#'@noRd
#'
main_panel <- function(){
  mainPanel(
  fluidRow(tags$style(".fa-heart {color:#E87722}", ".fa-wrench {color:#E87722}"),
           span(h4(
             "Welcome to my shiny dashboard!", icon("heart", lib = "font-awesome"))),
           br(),
           span("This shiny dashboard is created with love by Dea Avega Editya. The dashboard is useful for showing comparison of covid-19's development between 5 ASEAN countries comprises of "), strong("Indonesia, Malaysia, Singapore, Thailand, and Phillipines"), span("and people's responses related to the cases development, which reflected in Google's mobility trend in 6 categories (groceries, parks, workstations, stations, recreationals, and residentials).", align = "justify"),br(),
  ),
  br(),
  span("This chart below shows total cases in the 5 ASEAN countries. We can click on a particular country to check their trend line (average) of new cases, recovered and deaths.", align = "justify"),
  plotlyOutput("case"),
  plotlyOutput("trendchart"),
  textOutput("text_case"),
  plotlyOutput("mobility"),
  textOutput("text_mobility"),
  includeCSS("mystyle.css"),
  htmlOutput("bib")
  )
  }
