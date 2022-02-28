#' f_quantile
#'
#' Helper function to find arbitrary quantiles
#'
#' @param x Numeric Vector
#' @param probs Numeric Vector of Probabilities
#' @param names Names of probs
#' @param ... Other arguments to be passed on
#' @return Numeric vector of length(probs)
#'
#' @importFrom stats quantile


f_quantile <-
  function(x,
           probs = c(0.05, 0.15, 0.5, 0.84, 0.95),
           names = c("ymin", "lower", "middle", "upper", "ymax"), ...) {
    q <- quantile(x, probs = probs)
    names(q) <- names
    q
  }
