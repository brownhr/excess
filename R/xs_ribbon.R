#' Generate an area plot in ggplot2
#' @param .data Cross section data
#' @return A ggplot
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
