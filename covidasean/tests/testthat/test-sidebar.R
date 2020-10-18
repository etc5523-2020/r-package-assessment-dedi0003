#' testing for sidebar UI function
#'
#' @import
#' shiny
#'

test_that("sidebar", {

  sidebar <- left_sidebar()
  expect_length(sidebar, n = 3)

})
