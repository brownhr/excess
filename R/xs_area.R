
#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname xs_area
#' @export 
xs_area <- function(x) {
  UseMethod("xs_area")
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param sum_area PARAM_DESCRIPTION, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname xs_area.default
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



#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param baseline PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname normalize_baseline
#' @export 
normalize_baseline <- function(x, baseline) {
  x_baseline <- pmin(baseline, x) - baseline
  return(x_baseline)
}
