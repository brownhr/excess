test_that("null units works", {
  expect_equal(trap_area(seq(1,10), seq(1, 5, length = 10)), 27)
})
test_that("units work correctly", {
  expect_equal(
    object = units::as_units(units(xs_area(testxs))),
    expected = units::as_units("ft * ft")
  )
})
