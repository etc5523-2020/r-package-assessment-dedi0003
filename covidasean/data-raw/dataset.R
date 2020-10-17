#' This is dataset used for producing covid ASEAN shiny dashboard
#'
#' @example
#' covid_asean_df
#'
#' noRd
#'
## code to prepare `dataset` dataset goes here

# Load all libraries
library(dplyr)
library(tidyverse)
library(tsibble)
library(lubridate)
library(zoo)
library(tidycovid19)


#load data from tidycovid19
updates <- download_merged_data(cached = TRUE)

peers <- c("IDN", "SGP", "PHL", "THA", "MYS")

# data wrangling
covid_asean_df <- updates %>%
  filter(iso3c == peers) %>%
  mutate(
    new_cases = confirmed - lag(confirmed),
    ave_new_cases = round(rollmean(new_cases, 7, na.pad=TRUE, align="right")),
    new_recovered = recovered - lag(recovered),
    ave_new_recovered = rollmean(new_recovered, 7, na.pad=TRUE, align="right"),
    new_deaths = deaths - lag(deaths),
    ave_new_deaths = rollmean(new_deaths, 7, na.pad=TRUE, align="right")
  ) %>%
  filter(!is.na(new_cases), !is.na(ave_new_cases), !is.na(new_recovered), !is.na(ave_new_recovered), !is.na(new_deaths), !is.na(ave_new_deaths)) %>%
  mutate(
    ave_work = round(rollmean(gcmr_workplaces, 7, na.pad=TRUE, align="right")),
    ave_station = round(rollmean(gcmr_transit_stations, 7, na.pad=TRUE, align="right")),
    ave_grocery = round(rollmean(gcmr_grocery_pharmacy, 7, na.pad=TRUE, align="right")),
    ave_recreation = round(rollmean(gcmr_retail_recreation, 7, na.pad=TRUE, align="right")),
    ave_parks = round(rollmean(gcmr_parks, 7, na.pad=TRUE, align="right")),
    ave_resident = round(rollmean(gcmr_residential, 7, na.pad=TRUE, align="right"))
  ) %>%
  filter(!is.na(ave_work), !is.na(ave_station), !is.na(ave_grocery), !is.na(ave_recreation),
         !is.na(ave_parks), !is.na(ave_resident)) %>%
  mutate(workstations = ave_work, stations = ave_station,
         groceries = ave_grocery, recreations = ave_recreation,
         parks = ave_parks, residentials = ave_resident)

usethis::use_data(covid_asean_df, overwrite = TRUE)
