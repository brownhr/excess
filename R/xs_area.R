
#' @title Calculate cross-sectional area
#' @description This function calculates the area of a cross section object
#'   (\code{xs})
#' @param x Object of class \code{xs}
#' @return Numeric indicating cross-sectional area, or object of class
#'   \code{"units"} if the \code{xs} object has units.
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'
#'  }
#' }
#' @rdname xs_area
#' @export
xs_area <- function(x) {
  UseMethod("xs_area")
}


#' @method xs_area xs
#' @param sum_area Logical indicating whether to return a summarized total of
#'   the area (default) or a vector of the area at each interval.
#' @export
xs_area.xs <- function(x, sum_area = TRUE) {
  t <- attr(x, "tape")
  d <- attr(x, "depth")
  b <- attr(x, "baseline")

  depth_baseline <- mountaintop(d, b)
  Area <- trap_area(t, depth_baseline)
  if(sum_area) return(sum(Area)) else return(Area)
}

#' @method xs_area default
#' @importFrom rlang abort
#' @export

xs_area.default <- function(x) {
  rlang::abort("Class of `x` is not `xs`; consider coercing with the `xs()` function.")
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




