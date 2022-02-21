#' Calculate Cross-sectional area
#' @param .data A data.frame of cross-section data
#' @param x_cor A column of x-coordinates (default, *TAPE*)
#' @param invertrod A column of rod readings, relative to 0 (i.e. >0)
#' @param baseline A column of baseline readings, defaults to Bankful
#' @return A Double of the cross-sectional area compared to a baseline
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @import dplyr
#' @export

xs_area <- function(.data,
                    x_cor = TAPE,
                    invertrod = InvertRod,
                    baseline = Bankful) {
  x_cor <- enquo(x_cor)
  invertrod <- enquo(invertrod)
  baseline <- enquo(baseline)

  .data %>%
    mutate(depth_bf = pmin(!!baseline, !!invertrod) - !!baseline) %>%
    summarize(area = abs(pracma::trapz(
      x = !!x_cor,
      y = .data$depth_bf
    ))) %>%
    as.double()
}
