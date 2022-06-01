#' Calculate trapezoidal-rule area for two vectors
#' @param x Numeric vector
#' @param y Numeric vector
#' @return A double of the calculated area, with proper units of measurement
#'   (e.g., ft^2)
#'
#' @examples
#'  trap_area(x = seq(1, 10), y = runif(n = 10))
#'

trap_area <- function(x, y) {

  units <- null_units(x)


  units(y) <- units(x) <- units
  if(!is.numeric(x) || !is.numeric(y))
    stop("'x' and 'y' must be numeric vectors")

  if(length(x) != length(y))
    stop("'x' and 'y' must be vectors of the same length")

  if(length(x) == 0 || length(y) == 0){
    warning("Length of argument 'x' or 'y' is length 0")
    return(0)}




  # Ensures that the x- and y-units are in the same measurement system (e.g. US
  # ft.). This shouldn't come up often, as `xs_area` sets units, but just to be
  # sure, it's done again here. If the units are different, it converts between
  # e.g. meters and ft.



  m <- length(x)
  seq_m <- numeric(m)
  units(seq_m) <- units
  n <- 2 * m
  x_doub <- c(x, x[m:1])
  y_doub <- c(seq_m, y[m:1])

  a_1 <- sum(x_doub[1:(n-1)] * y_doub[2:n]) + x_doub[n] * y_doub[1]
  a_2 <- sum(x_doub[2:n] * y_doub[1:(n-1)]) + x_doub[1] * y_doub[n]
  area <- (0.5 * (a_1 - a_2))
  return(abs(area))
}
