#' @title Constructor for class \code{xs}
#' @description Basic dev-level constructor for generating a cross-section object ('xs')
#' @param x Object of class \code{data.frame}
#' @param tape Column of x from which the cross-coordinates (tape) are to be read
#' @param depth Column of x from which the rod measurements (depth) are to be read
#' @param baseline Column of x from which the bankful values (baseline) are to be read
#' @return An object of class \code{xs}

#' @seealso
#'  \code{\link[purrr]{prepend}}
#'  \code{\link[dplyr]{pull}}
#' @rdname new_xs
#' @export
#' @importFrom purrr prepend
#' @importFrom dplyr pull
new_xs <- function(x, tape, depth, baseline) {
  x <- structure(
    x,
    class = purrr::prepend(class(x), "xs"),
    tape = dplyr::pull(x, {{tape}}),
    depth = dplyr::pull(x, {{depth}}),
    baseline = dplyr::pull(x, {{baseline}}))

  stopifnot(all(is.numeric(attr(xs_testxs, "tape")),
                is.numeric(attr(xs_testxs, "depth")),
                is.numeric(attr(
                  xs_testxs, "baseline"
                ))))

  return(x)
}

#
# xs <- function(x, ...) {
#   UseMethod("xs", x)
# }
#
# xs.default <- function(x, ...){
#   new_xs(x = x, ...)
# }
#
# xs.data.frame <- function(xs,
#                           x_col,
#                           d_col,
#                           baseline) {
#   x_col <- deparse(substitute(x_col))
#   d_col <- deparse(substitute(d_col))
#   baseline <- deparse(substitute(basline))
#   xs <- new_xs(
#     xs,
#     tape = x_col,
#     depth = d_col,
#     baseline = baseline
#   )
#   return(xs)
# }
