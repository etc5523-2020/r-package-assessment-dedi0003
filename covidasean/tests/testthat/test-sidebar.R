# testing for sidebar UI function

test_that("sidebar", {

  res <- left_sidebar()
  expect_length(n = 3)

})
