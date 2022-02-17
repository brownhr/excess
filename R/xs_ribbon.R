# Tentative way of plotting the area lower than Bankful. It's a bit inaccurate if
# there isn't an observation at InvertRod == Bankful
require(ggplot2)

xs_ribbon <- function(data){
ggplot(data = data, aes(x = TAPE, y = InvertRod)) +
  geom_path() +
  geom_path(aes(x = TAPE, y = Bankful)) + geom_ribbon(aes(
    x = TAPE,
    ymax = Bankful,
    ymin = pmin(Bankful, InvertRod)
  ),
  fill = "blue",
  alpha = 0.5)
}

# cowplot::plot_grid(plotlist = xs_gg, labels = rownames(xs_areas))