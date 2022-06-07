#' @export
as_xs <- function(x) {
  UseMethod("as_xs")
}


#' @export
as_xs.default <- function(x, tape, depth, baseline) {
  x <- structure(x,
    class = purrr::prepend(class(x), "xs"),
    tape = tape, depth = depth, baseline = baseline
  )
  return(x)
}


#' @export
#' @method as_xs data.frame
#' @importFrom rlang enquo

as_xs.data.frame <- function(x, tape, depth, baseline) {
  x <- structure(
    x,
    class = purrr::prepend(class(x), "xs"),
    tape = x[[rlang::enquo(tape)]],
    depth = x[[rlang::enquo(depth)]],
    baseline = x[[rlang::enquo(baseline)]]
  )
  return(x)
}
