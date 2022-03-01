
#' @title Coerce pebble data to raster
#' @description Internal function to coerce pebble data into an object of class
#'   \code{raster}
#' @param data A matrix (or object coercible into type "matrix")
#' @param transpose A logical (default \code{TRUE}). If \code{TRUE}, transposes
#'   the input data

.pebble <- function(data, transpose = TRUE) {
  m <- matrix(as.numeric(data),
              ncol = ncol(data))

  if (transpose) {
    m <- t(m)
  }
  r <- raster::raster(m[nrow(m):1,])
  return(r)
}

#' @title Plot Pebble grid as Raster
#' @description Plots pebble data (see: \emph{pebble1}) as a raster from
#'   the raster package.
#'
#' @inheritParams .pebble
#' @param ... Other arguments to be passed along (primarily to
#'   \code{\link[raster]{raster}})
#' @param colNA A character representing a color (eg: "red")
#' @importFrom rlang check_installed
#' @export


plot_pebble <- function(data, ..., colNA = "red") {
  rlang::check_installed(pkg = "raster", reason = "to use `excess::plot_pebble()`")

  p <- .pebble(data = data)
  raster::plot(p, colNA = colNA)

}
