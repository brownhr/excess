#' @title Replace default value for `NULL`
#' @name op-null
#' @aliases %||%
#' @import units
#' @importFrom rlang %||%
#' @keywords internal
NULL

#' @importFrom magrittr %>%
NULL


#' @title NULL units if error
#' @import units
#' @keywords internal
#' @param x Numeric Vector

null_units <-
  function(x) {
    if (!is.numeric(x))
      stop("`x` must be numeric")
    tryCatch(
      expr = {
        units(x)
      },
      error = function(e)
        NULL
    )
  }
