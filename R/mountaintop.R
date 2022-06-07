#' @title Normalize baseline
#' @description Calculates the parallel minimum (if \code{baseline} is
#'   \code{TRUE}) or parallel maximum, each subtracted by the baseline
#'   measurement.
#' @param x Numeric Vector
#' @param baseline Number or numeric vector to compare against.
#' @param bottom Whether or not to "chop off" the bottom or top of the vector.
#' @return Numeric vector
#' @rdname mountaintop
#' @export
mountaintop <- function(x, baseline, bottom = TRUE) {
  if (ceiling) {
    x_baseline <-
      pmin(baseline, x) - baseline
  } else {
    x_baseline <-
      pmax(baseline, x) - baseline
  }
  return(x_baseline)
}
