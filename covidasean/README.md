
# covidasean

<!-- badges: start -->
<!-- badges: end -->

The goal of covidasean is to provide dashboard that gives overview on covid-19 outbreak in 5 ASEAN countries comprise of Indonesia, Malaysia, Singapore, Philippines and Thailand. Users can check the detail by selecting one particular country to show cases trendline. They can also see summary table that contains number of cases (confirmed, recovered and deaths) related to covid-19. 

## Installation

You can install the released version of covidasean from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("covidasean")
```

## Example

This is a basic example of the package use:

### Loading dataset
``` r
library(covidasean)
covid_asean_df
```
### Launching shiny dashboard of covid ASEAN
``` r
library(covidasean)
launch_app()
```

