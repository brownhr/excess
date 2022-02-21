#' Generate an area plot in ggplot2
#' @param .data A data.frame of cross-section data
#' @param x_cor A column of x-coordinates (default, *TAPE*)
#' @param depth A column of rod readings, relative to 0 (i.e. >0) (default,
#'   *InvertRod*)
#' @param baseline A column of baseline readings (default, *Bankful*)
#' @param ... Other arguments passed on to methods.
#' @return An object of class `ggplot`
#' @import ggplot2
#' @importFrom rlang .data
#' @export


# Tentative way of plotting the area lower than Bankful.
# It's a bit inaccurate if there isn't an observation at InvertRod == Bankful

xs_ribbon <- function(.data,
                      x_cor = "TAPE",
                      depth = "InvertRod",
                      baseline = "Bankful",
                      ...) {
  gg <-
    ggplot2::ggplot(data = .data) +
    ggplot2::geom_path(ggplot2::aes(x = .data[[x_cor]], y = .data[[depth]])) +
    ggplot2::geom_path(ggplot2::aes(x = .data[[x_cor]], y = .data[[baseline]])) +
    ggplot2::geom_ribbon(
      ggplot2::aes(
        x = .data[[x_cor]],
        ymax = .data[[baseline]],
        ymin = pmin(.data[[baseline]], .data[[depth]])
      ),
      fill = "blue",
      alpha = 0.5
    )
  return(gg)
}
