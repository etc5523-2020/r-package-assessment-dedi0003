## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(covidasean)

## -----------------------------------------------------------------------------
library(covidasean)
library(tibble)
covid_asean_df

## -----------------------------------------------------------------------------
library(covidasean)
library(ggplot2)
library(dplyr)
covid_asean_df %>% 
  filter(country == "Indonesia") %>% 
  ggplot(aes(x = date, y = new_cases))+
  geom_line(color = "red")+
  geom_point(aes(x = date), color = "darkred")+
  theme_minimal()

## ---- eval = FALSE------------------------------------------------------------
#  library(covidasean)
#  launch_app()

