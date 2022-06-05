test_that("null units works", {
  expect_equal(sum(trap_area(seq(1, 10), seq(1, 5, length = 10))), 27)
})
test_that("units work correctly", {
  expect_equal(object = units::as_units(units(
    xs_area(
      data = testxs,
      tape = TAPE,
      depth = InvertRod,
      baseline =  Bankful,
      sum_area =  TRUE
    )
  )),
  expected = units::as_units("ft * ft"))
})
