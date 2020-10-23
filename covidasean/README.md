
# covidasean

<!-- badges: start -->
[![R build status](https://github.com/etc5523-2020/r-package-assessment-dedi0003/workflows/R-CMD-check/badge.svg)](https://github.com/etc5523-2020/r-package-assessment-dedi0003/actions)
<!-- badges: end -->

The main goal of covidasean is to provide dashboard that gives overview on covid-19 outbreak in 5 ASEAN countries comprise of **Indonesia, Malaysia, Singapore, Philippines and Thailand**. Users can check the detail by selecting one particular country to show cases trendline. They can also see summary table that contains number of cases (confirmed, recovered and deaths) related to covid-19. In addition, users can play around by themselves in exploring covid-19 cases by using provided dataset sourced from tidycovid19 R package by Joachim Gassen.

<img src = "https://i.imgur.com/VmnDSTJ.png" width = 80%>


## Installation

You can install the released version of covidasean using ```devtools``` R package:

``` r
devtools::install_github("etc5523-2020/r-package-assessment-dedi0003", subdir = "covidasean")
```

## Example

This is a basic example of the package use:

### Loading covid-19 dataset
``` r
library(covidasean)
covid_asean_df
```
### Launching shiny dashboard of covid ASEAN
``` r
library(covidasean)
launch_app()
```

### Reference
Gassen, Joachim. 2020. Tidycovid19: Download, Tidy and Visualize Covid-19 Related Data. https://joachim-gassen.github.io/tidycovid19/.
