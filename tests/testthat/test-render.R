#' server function test
#'
#'@import
#'plotly
#'
test_that("render", {

  render <- render_case()
  expect_length(render, 1)

})
