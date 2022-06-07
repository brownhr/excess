as_xs <- function(x){
  UseMethod("as_xs")
}

as_xs.default <- function(x, tape, depth, baseline) {
  x <- structure(x,
                 class = purrr::prepend(class(x), "xs"),
                 tape = tape, depth = depth, baseline = baseline)
  return(x)
}


#' @export
#' @method as_xs data.frame

as_xs.data.frame <- function(x, tape, depth, baseline){
  x <- structure(
    x,
    class = purrr::prepend(class(x), "xs"),
    tape = x[[substitute(tape)]],
    depth = x[[substitute(depth)]],
    baseline = x[[substitute(baseline)]]

  )
}
