
# Load all libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(plotly)
library(tsibble)
library(lubridate)
library(zoo)
library(kableExtra)
library(tidycovid19)

#load data from tidycovid19
updates <- download_merged_data(cached = TRUE)

peers <- c("IDN", "SGP", "PHL", "THA", "MYS")


# create table
mytable <- covid_asean_df %>%
    mutate(month = month(date, label = TRUE)) %>%
    group_by(country, month) %>%
    summarise("total cases" = sum(new_cases), "total deaths" = sum(new_deaths),
              "total recovered" = sum(new_recovered))

# plotly preparation
mobility_trend <- c("workstations", "stations", "groceries",
                    "recreations", "parks", "residentials")

# Bibliography function
toggleView <- function(input, output_name){
    observeEvent(input$show_button, {show("bib")})
    observeEvent(input$show_button, {hide("bib")})
}
getPage <- function() {
    return(includeHTML("bibliography.html"))
}

hidePage <- function() {
    return("")
}

# Define UI for application that draws a histogram
ui <- fluidPage(br(),

    # Application title
    titlePanel(
        span(h1(icon("dove", lib = "font-awesome"),
                "Covid-19 & People's Mobility in the 5 ASEAN Countries",
           align = "center"
           ))
        ),

    # Sidebar layout
    sidebarLayout(
        covidasean:::left_sidebar(),

        covidasean:::main_panel()
        ),
    br())


# Define server logic required to draw a histogram
server <- function(input, output, session) {
    output$text_image <- renderText(
        "image source: BRProud.com"
    )

    output$case <- covidasean:::render_case()

    output$trendchart <- renderPlotly({
        d <- event_data("plotly_click")
            if (is.null(d)) return(
                case_plot <- covid_asean_df %>%
                    filter(country == "Indonesia") %>%
                    ggplot(aes(x = date)) +
                    geom_line(aes(y = ave_new_cases, color ="avg cases"), size = 1) +
                    geom_line(aes(y = ave_new_deaths, color ="avg deaths"), size = 1, alpha = 0.5) +
                    # geom_line(aes(y = ave_work, color ="Workplaces"), size = 1.2) +
                    # geom_line(aes(y = ave_station, color ="Stations"), size = 1.2)+
                    geom_line(aes(y = ave_new_recovered, color ="avg recovered"), size = 1, alpha =0.5) +
                    theme_minimal() +
                    ylab("Count")+
                    ggtitle(paste0("Covid-19 Cases in Indonesia", d$x))+
                    # facet_wrap(.~ country, nrow = 1)+
                    theme(panel.grid.major.x = element_line(),
                          panel.grid.minor = element_blank(),
                          legend.position="top", legend.box = "horizontal")
            )

        case_plot <- covid_asean_df %>%
            filter(country %in% d$x) %>%
            ggplot(aes(x = date)) +
            geom_line(aes(y = ave_new_cases, color ="avg cases"), size = 1) +
            geom_line(aes(y = ave_new_deaths, color ="avg deaths"), size = 1, alpha = 0.5) +
            # geom_line(aes(y = ave_work, color ="Workplaces"), size = 1.2) +
            # geom_line(aes(y = ave_station, color ="Stations"), size = 1.2)+
            geom_line(aes(y = ave_new_recovered, color ="avg recovered"), size = 1, alpha =0.5) +
            theme_minimal() +
            ylab("Count")+
            ggtitle(paste0("Covid-19 Cases in ", d$x))+
            # facet_wrap(.~ country, nrow = 1)+
            theme(panel.grid.major.x = element_line(),
                  panel.grid.minor = element_blank(),
                  legend.position="top", legend.box = "horizontal")

            return(ggplotly(case_plot)) %>%
                config(displayModeBar = F)  %>%
                layout(legend = list(orientation = "h", x = 0.2, y = -0.1))
    })


    output$text_case <- renderText("We can hover on the plot above to see detail information on 7-day rolling average of new cases, recovered and deaths in the countries hence can compare the development of cases between these countries.")

    output$text_mobility <- renderText("Tips: We can change category of mobility trend by selecting the category on the sidebar panel. The plot will display corresponding mobility trend in these five countries. In addition we can also subset the period by choosing specific date range from the sidebar panel.")

    datasetInput <- reactive({
        df_range <- covid_asean_df %>%
            filter(date >= date(input$dateRange[1]) &
                       date <= date(input$dateRange[2]))

        switch(input$variable,
        "workstations" = df_range$ave_work,
        "groceries" = df_range$ave_grocery,
        "stations" = df_range$ave_station,
        "recreations" = df_range$ave_recreation,
        "parks" = df_range$ave_parks,
        "residentials" = df_range$ave_resident)

    })


    # Mobility Trend
    output$mobility <- renderPlotly({
    selected <- datasetInput()


        covid_asean_df %>%
        filter(date >= date(input$dateRange[1]) &
                       date <= date(input$dateRange[2])) %>%
        ggplot(aes(x = date)) +
        geom_line(aes(y = selected),color ="red", size = 1.2, alpha = 0.7) +
        theme_minimal() +
        ggtitle(paste0("Trend of People's Mobility at ",
                       toupper(substr(input$variable, 1,1)),
                       substr(input$variable, 2, nchar(input$variable)))) +
        ylab("Count")+
        facet_wrap(.~ country, nrow = 1)+
        theme(panel.grid.major.x = element_line(),  panel.grid.minor = element_blank())


            })

    # render table
    output$table <- function() {
            req(input$table)
            mytable %>%
                filter(country == input$table) %>%
                kable() %>%
                kableExtra::kable_styling(bootstrap_options = "striped",
                              stripe_color = "green", font_size = 11) %>%
                row_spec(0, align = "c")

        }
    output$text_table <- renderText("This table below shows summary information on covid-19 cases in a selected country. We can choose country name in the dropdown menu above.")

    observeEvent(input$show_button, {

    output$bib <-renderUI({getPage()})
    })

    observeEvent(input$hide_button, {

    output$bib <-renderUI({hidePage()})
    })

    }



# Run the application
shinyApp(ui = ui, server = server)


# span("The comparison plot covers 7-day rolling average new cases, recovered and deaths for each country. Moreover, this app also try to show corresponding responses of people in the Mobility plot. In addition, users can select a time period (date range) to check some interesting periods that maybe can answer some intriguing questions i.e. when is the actual time that people are starting to return working from their offices (workstations) despite the cases development? As an example, we can check that from the end of April workers in all countries (except Singapore) already started to work from offices again although cases were still soaring high (especially in Indonesia and Phillipines). To complement the analysis, this app also provides a simple table on the sidebar panel to show readers summary information about monthly covid-19 cases for each individual country. Lastly, interested users can read some references used by the author to build this shiny app by clicking on showing bibliography-button", align = "justify")),
