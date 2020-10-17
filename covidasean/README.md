
# covidasean

<!-- badges: start -->
<!-- badges: end -->

The goal of covidasean is to provide dashboard that gives overview on covid-19 outbreak in 5 ASEAN countries comprise of **Indonesia, Malaysia, Singapore, Philippines and Thailand**. Users can check the detail by selecting one particular country to show cases trendline. They can also see summary table that contains number of cases (confirmed, recovered and deaths) related to covid-19. 

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

