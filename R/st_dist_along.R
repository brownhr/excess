#' @import sf
#' @importFrom dplyr lag
#'

st_dist_along <- function(sf) {
  dist_mat <- sf::st_distance(sf, dplyr::lag(sf))
  d <- diag(dist_mat) %>%
    units::set_units(units(dist_mat), mode = "standard")
  d[[1]] <- 0
  return(d)
}
