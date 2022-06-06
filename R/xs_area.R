
#' @export
xs_area <- function(x) {
  UseMethod("xs_area")
}


#' @export
xs_area.default <- function(x, sum_area = TRUE) {
  t <- attr(x, "tape")
  d <- attr(x, "depth")
  b <- attr(x, "baseline")

  depth_baseline <- normalize_baseline(d, b)
  Area <- trap_area(t, depth_baseline)
  if(sum_area) return(sum(Area)) else return(Area)
}

# xs_area.data.frame <- function(data, tape, depth, baseline, sum_area = TRUE){
#
#   # I know this is a horrible way of doing things, but I wanted to either use
#   # tidyeval (not quote column names) or pass a vector to one of the
#   # arguments.
#   A <- data %>%
#     dplyr::mutate(
#       depth_baseline = normalize_baseline({{depth}}, {{baseline}})
#       ) %>%
#     dplyr::summarize(
#       Area = trap_area({{tape}}, .data$depth_baseline)
#     ) %>%
#     `[[`(1)
#
#
#   if(sum_area) {
#     return(sum(A))
#   } else {
#     return(A)
#   }
# }

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
#
#
# Area <- function(object, ...){
#   UseMethod("Area", object)
# }
#
# Area.xs <- function(xs, units){
#
# }


