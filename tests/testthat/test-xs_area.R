test_that("multiplication works", {
  expect_equal(object = as.numeric(xs_area(testxs)),-23.4665)
})

test_that("Units in testxs carry through xs-area", {
  expect_equal(
    object = units::as_units(units(testxs$TAPE)),
    expected = units::as_units("ft"),
    ignore_attr = TRUE
  )
})
