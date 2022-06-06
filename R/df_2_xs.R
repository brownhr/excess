new_xs <- function(x, units, tape, depth, baseline) {
  x <- structure(x,
    class = "xs",
    Units = units,
    tape = tape,
    depth = depth,
    baseline = baseline
  )
  x
}


xs <- function(obj, ...) {
  UseMethod("xs", obj)
}

xs.default <- function(obj, ...){
  new_xs(x = obj, ...)
}

xs.data.frame <- function(xs,
                          x_col,
                          d_col,
                          baseline,
                          units = NULL) {


}
