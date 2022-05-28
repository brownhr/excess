#' @title Replace default value for `NULL`
#' @name op-null
#' @aliases %||%
#' @importFrom rlang %||%
#' @keywords internal
NULL

#' Calculate trapezoidal-rule area for two vectors
#' @param x Numeric vector
#' @param y Numeric vector
#' @return A double of the calculated area
#' @keywords internal
#'

trap_area <- function(x, y) {

  if(!is.numeric(x) || !is.numeric(y))
    stop("'x' and 'y' must be numeric vectors")

  if(length(x) != length(y))
    stop("'x' and 'y' must be vectors sof the same length")

  if(length(x) == 0 || length(y) == 0){
    warning("Length of argument 'x' or 'y' is length 0")
    return(0)}
  m <- length(x)
  n <- 2 * m
  x_doub <- c(x, x[m:1])
  y_doub <- c(numeric(m), y[m:1])

  a_1 <- sum(x_doub[1:(n-1)] * y_doub[2:n]) + x_doub[n] * y_doub[1]
  a_2 <- sum(x_doub[2:n] * y_doub[1:(n-1)]) + x_doub[1] * y_doub[n]
  area <- (0.5 * (a_1 - a_2))
  return(area)
}
