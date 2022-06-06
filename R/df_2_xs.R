new_xs <- function(x, tape, depth, baseline) {
  x <- structure(x, class = append(class(x), "xs"),
                 tape = tape,
                 depth = depth,
                 baseline = baseline)


  x
}


xs <- function(x, ...) {
  UseMethod("xs", x)
}

xs.default <- function(x, ...){
  new_xs(x = x, ...)
}

xs.data.frame <- function(xs,
                          x_col,
                          d_col,
                          baseline) {
  x_col <- deparse(substitute(x_col))
  d_col <- deparse(substitute(d_col))
  baseline <- deparse(substitute(basline))
  xs <- new_xs(
    xs,
    tape = x_col,
    depth = d_col,
    baseline = baseline
  )
  return(xs)
}
