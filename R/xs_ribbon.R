#' Generate an area plot in ggplot2
#' @param .data Cross section data
#' @return A ggplot
#' @import ggplot2
#' @importFrom rlang .data
#' @export


# Tentative way of plotting the area lower than Bankful. It's a bit inaccurate if
# there isn't an observation at InvertRod == Bankful

xs_ribbon <- function(.data) {
  gg <-
    ggplot(data = .data, aes(x = .data$TAPE, y = .data$InvertRod)) +
    geom_path() +
    geom_path(aes(x = .data$TAPE, y = .data$Bankful)) +
    geom_ribbon(
      aes(
        x = .data$TAPE,
        ymax = .data$Bankful,
        ymin = pmin(.data$Bankful, .data$InvertRod)
      ),
      fill = "blue",
      alpha = 0.5
    )
  return(gg)
}

# cowplot::plot_grid(plotlist = xs_gg, labels = rownames(xs_areas))
