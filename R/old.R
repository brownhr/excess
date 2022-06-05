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


#' @title Custom geom_boxplot
#'
#' @description  Creates a boxplot with an arbitrary set of quantiles. Credit to
#'   Z.lin on stackexchange
#'   https://stackoverflow.com/questions/28368963/ggplot-how-to-add-a-segment-with-stat-summary
#'
#' @import ggplot2
#' @import grid
#' @importFrom rlang %||%

# include all data points beyond the range of qs values
StatBoxplot2 <- ggproto(
  "StatBoxplot2", StatBoxplot,
  compute_group = function(data, scales, width = NULL, na.rm = FALSE, coef = 1.5,
                           qs = c(0, 0.25, 0.5, 0.75, 1)) {
    if (!is.null(data$weight)) {
      mod <- quantreg::rq(y ~ 1,
                          weights = weight, data = data,
                          tau = qs
      )
      stats <- as.numeric(stats::coef(mod))
    } else {
      stats <- as.numeric(stats::quantile(data$y, qs))
    }
    names(stats) <- c("ymin", "lower", "middle", "upper", "ymax")
    iqr <- diff(stats[c(2, 4)])
    outliers <- data$y < stats[1] | data$y > stats[5] # change outlier definition

    if (length(unique(data$x)) > 1) {
      width <- diff(range(data$x)) * 0.9
    }
    df <- as.data.frame(as.list(stats))
    df$outliers <- list(data$y[outliers])
    if (is.null(data$weight)) {
      n <- sum(!is.na(data$y))
    } else {
      n <- sum(data$weight[!is.na(data$y) & !is.na(data$weight)])
    }
    df$notchupper <- df$middle + 1.58 * iqr / sqrt(n)
    df$notchlower <- df$middle - 1.58 * iqr / sqrt(n)
    df$x <- if (is.factor(data$x)) {
      data$x[1]
    } else {
      mean(range(data$x))
    }
    df$width <- width
    df$relvarwidth <- sqrt(n)
    df
  }
)


#' @title geom_boxplot2
#' @description Creates a boxplot with an arbitrary set of quantiles. Credit to
#'   Z.lin on stackexchange
#'   https://stackoverflow.com/questions/28368963/ggplot-how-to-add-a-segment-with-stat-summary
#' @inheritParams ggplot2::geom_boxplot
#' @param median.colour A character color value
#' @param median.color A character color value
#'
#'
#' @example
#'   library(ggplot2)
#'   data <- as.data.frame(stats::rpois(100, 25))
#'   names(data) <- "pos"
#'   quants <- c(0.05, 0.15, 0.5, 0.84, 0.95)
#'   ggplot(data = data, aes(y = pos)) +
#'     geom_boxplot2(qs = quants) +
#'     coord_flip()

geom_boxplot2 <- function(mapping = NULL, data = NULL, stat = "boxplot2", position = "dodge2",
                          ..., outlier.colour = NULL, outlier.color = NULL, outlier.fill = NULL,
                          outlier.shape = 19, outlier.size = 1.5, outlier.stroke = 0.5,
                          outlier.alpha = NULL, notch = FALSE, notchwidth = 0.5, varwidth = FALSE,
                          na.rm = FALSE, show.legend = NA, inherit.aes = TRUE,
                          median.colour = NULL, median.color = NULL) {
  if (is.character(position)) {
    if (varwidth == TRUE) {
      position <- position_dodge2(preserve = "single")
    }
  } else {
    if (identical(position$preserve, "total") & varwidth ==
        TRUE) {
      warning("Can't preserve total widths when varwidth = TRUE.",
              call. = FALSE
      )
      position$preserve <- "single"
    }
  }

  layer(
    data = data, mapping = mapping, stat = stat, geom = GeomBoxplot2,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(
      outlier.colour = outlier.color %||% outlier.colour,
      outlier.fill = outlier.fill, outlier.shape = outlier.shape,
      outlier.size = outlier.size, outlier.stroke = outlier.stroke,
      outlier.alpha = outlier.alpha, notch = notch, notchwidth = notchwidth,
      varwidth = varwidth, na.rm = na.rm,
      median.colour = median.color %||% median.colour, ...
    )
  )
}

# define GeomBoxplot2 based on GeomBoxplot, with draw_group function & draw_key
# functions tweaked to use median.colour for the median segment's colour, if available


GeomBoxplot2 <- ggproto(
  "GeomBoxplot2",
  GeomBoxplot,
  draw_group = function(data, panel_params, coord, fatten = 2, outlier.colour = NULL,
                        outlier.fill = NULL, outlier.shape = 19, outlier.size = 1.5,
                        outlier.stroke = 0.5, outlier.alpha = NULL, notch = FALSE,
                        notchwidth = 0.5, varwidth = FALSE, median.colour = NULL) {
    common <- data.frame(
      colour = data$colour, size = data$size,
      linetype = data$linetype, fill = alpha(data$fill, data$alpha),
      group = data$group, stringsAsFactors = FALSE
    )
    whiskers <- data.frame(
      x = data$x, xend = data$x,
      y = c(data$upper, data$lower),
      yend = c(data$ymax, data$ymin),
      alpha = NA,
      common, stringsAsFactors = FALSE
    )
    box <- data.frame(
      xmin = data$xmin, xmax = data$xmax, ymin = data$lower,
      y = data$middle, ymax = data$upper,
      ynotchlower = ifelse(notch, data$notchlower, NA),
      ynotchupper = ifelse(notch,
                           data$notchupper, NA
      ),
      notchwidth = notchwidth, alpha = data$alpha,
      common, stringsAsFactors = FALSE
    )
    if (!is.null(data$outliers) && length(data$outliers[[1]] >= 1)) {
      outliers <- data.frame(
        y = data$outliers[[1]], x = data$x[1],
        colour = outlier.colour %||% data$colour[1], fill = outlier.fill %||%
          data$fill[1], shape = outlier.shape %||% data$shape[1],
        size = outlier.size %||% data$size[1], stroke = outlier.stroke %||%
          data$stroke[1], fill = NA, alpha = outlier.alpha %||%
          data$alpha[1], stringsAsFactors = FALSE
      )
      outliers_grob <- GeomPoint$draw_panel(
        outliers, panel_params,
        coord
      )
    } else {
      outliers_grob <- NULL
    }
    if (is.null(median.colour)) {
      ggplot2:::ggname(
        "geom_boxplot",
        grobTree(
          outliers_grob,
          GeomSegment$draw_panel(whiskers, panel_params, coord),
          GeomCrossbar$draw_panel(box, fatten = fatten, panel_params, coord)
        )
      )
    } else {
      ggplot2:::ggname(
        "geom_boxplot",
        grobTree(
          outliers_grob,
          GeomSegment$draw_panel(whiskers, panel_params, coord),
          GeomCrossbar$draw_panel(box, fatten = fatten, panel_params, coord),
          GeomSegment$draw_panel(
            transform(box,
                      x = xmin, xend = xmax, yend = y,
                      size = size, alpha = NA,
                      colour = median.colour
            ),
            panel_params,
            coord
          )
        )
      )
    }
  },
  draw_key = function(data, params, size) {
    if (is.null(params$median.colour)) {
      draw_key_boxplot(data, params, size)
    } else {
      grobTree(linesGrob(0.5, c(0.1, 0.25)),
               linesGrob(0.5, c(0.75, 0.9)),
               rectGrob(height = 0.5, width = 0.75),
               linesGrob(c(0.125, 0.875), 0.5,
                         gp = gpar(col = params$median.colour)
               ),
               gp = gpar(
                 col = data$colour,
                 fill = alpha(data$fill, data$alpha),
                 lwd = data$size * .pt,
                 lty = data$linetype
               )
      )
    }
  }
)


xs_areaold <- function(data,
                       tape = NULL,
                       depth = NULL,
                       baseline = NULL) {
  # Allow for either a character vector or column name input

  tape = tape %||% data$TAPE
  depth = depth %||% data$InvertRod
  baseline = baseline %||% rep(mean(data$Bankful), nrow(data))





  z_baseline <- normalize_baseline(depth, baseline)
  Area <- trap_area(tape, z_baseline)
  return(sum(Area))
}
