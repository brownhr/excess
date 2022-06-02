#' @title Cross-Sectional area
#'
#' @description Calculate area of a cross-section using the trapezoidal rule for
#'   integration. By default, uses the columns "TAPE" for measurement across xs,
#'   "InvertRod" for depth relative to y = 0, and "Bankful" for baseline
#'   measurement.
#'
#' @param data A data.frame of cross-section data
#' @param tape Either a numeric vector of tape readings ("x coordinates").
#' @param depth Either a numeric vector of rod readings ("y coordinates").
#' @param baseline Either a double representing bankfull level.
#'
#' @return A Double of the cross-sectional area compared to a baseline
#' @export
#' @examples
#' area <- xs_area(testxs)
#' print(area)
#'
xs_area <- function(data,
                    tape = NULL,
                    depth = NULL,
                    baseline = NULL) {
  # Allow for either a character vector or column name input

  tape = tape %||% data$TAPE
  depth = depth %||% data$InvertRod
  baseline = baseline %||% rep(mean(data$Bankful), nrow(data))





  z_baseline <- normalize_baseline(depth, baseline)
    Area <- trap_area(tape, z_baseline)
  return(sum(Area))
}

#' Normalize vector to baseline
#' @param x Numeric vector
#' @param baseline Number to normalize against
#' @description Calculates "normalized" vector; equivalent to \code{pmin(x, y) - y}
#' @export
#' @examples
#'   x <- rnorm(n = 20)
#'   baseline <- 0
#'   normalize_baseline(x, baseline)

normalize_baseline <- function(x, baseline) {
  x_baseline <- pmin(baseline, x) - baseline
  return(x_baseline)
}
