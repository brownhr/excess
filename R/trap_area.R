#' Calculate trapezoidal-rule area for two vectors
#' @param x Numeric vector
#' @param y Numeric vector
#' @return A double of the calculated area, with proper units of measurement
#'   (e.g., ft^2)
#'
#' @importFrom stats na.omit
#'

# TODO: Write examples


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

  x_seq <- na.omit(dplyr::lead(x) - x)
  y_seq <- na.omit(y + dplyr::lead(y))
  Area <- (x_seq * y_seq)/2
  return(Area)
}
