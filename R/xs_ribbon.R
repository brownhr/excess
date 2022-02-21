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
    ggplot(data = .data, aes(x = .data[[x_cor]], y = .data[[depth]])) +
    geom_path() +
    geom_path(aes(x = .data[[x_cor]], y = .data[[baseline]])) +
    geom_ribbon(
      aes(
        x = .data[[x_cor]],
        ymax = .data[[baseline]],
        ymin = pmin(.data[[baseline]], .data[[depth]])
      ),
      fill = "blue",
      alpha = 0.5
    )
  return(gg)
}
