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
#' @import units
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
                    baseline = NULL,
                    units = "ft") {
  # Allow for either a character vector or column name input

  tape <- tape %||% data$TAPE
  depth <- depth %||% data$InvertRod
  baseline <- baseline %||% mean(data$Bankful)

  depth_baseline <- pmin(baseline, depth) - baseline

  area <- trap_area(x = tape,
                            y = depth_baseline)
  return(abs(area))
}




