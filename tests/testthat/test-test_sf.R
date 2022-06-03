require(dplyr)
test_that("test_sf and st_dist_along work correctly",{
  expect_equal(test_sf %>%
    mutate(dist = st_dist_along(geometry)) %>%
    xs_area(dist, InvertRod, Bankful, sum_area = TRUE) %>%
    units::set_units(ft^2),
    units::set_units(-23.4925, ft^2), tolerance = 1e-5)
})
