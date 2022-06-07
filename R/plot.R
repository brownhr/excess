#' @export
#' @method plot xs

plot.xs <- function(xs, ...,
                    .baseline = attr(xs, "baseline"),
                    col_baseline = "blue"
                    ) {
  plot(
    x = attr(xs, "tape"),
    y = attr(xs, "depth"),
    type = "l",
    xlab = "Tape",
    ylab = "Depth"

  )
  lines(.baseline, col = col_baseline)

}
