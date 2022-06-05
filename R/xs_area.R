#' @title Cross-Sectional area
#'
#' @description Calculate area of a cross-section using the trapezoidal rule for
#'   integration. By default, uses the columns "TAPE" for measurement across xs,
#'   "InvertRod" for depth relative to y = 0, and "Bankful" for baseline
#'   measurement.
#'
#' @importFrom dplyr mutate summarize
#' @importFrom rlang .data
#' @param data A data.frame of cross-section data
#' @param tape A column from \code{data} or a numeric vector of tape readings
#'   ("x coordinates").
#' @param depth A column from \code{data} or a numeric vector of rod readings
#'   ("y coordinates").
#' @param baseline A column from \code{data} or vector representing bankfull
#'   level.
#' @param sum_area A logical (default \code{TRUE}) indicating whether to return
#'   a single summary of the trapezoidal area or a tibble indicating the area at
#'   each section.
#'
#' @return A Double of the cross-sectional area compared to a baseline
#' @export
#'


xs_area <- function(data, tape, depth, baseline, sum_area = TRUE){

  # I know this is a horrible way of doing things, but I wanted to either use
  # tidyeval (not quote column names) or pass a vector to one of the
  # arguments.
  A <- data %>%
    dplyr::mutate(
      depth_baseline = normalize_baseline({{depth}}, {{baseline}})
      ) %>%
    dplyr::summarize(
      Area = trap_area({{tape}}, .data$depth_baseline)
    ) %>%
    `[[`(1)


  if(sum_area) {
    return(sum(A))
  } else {
    return(A)
  }
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
