#' @title Cross-Sectional area
#'
#' @description Calculate area of a cross-section using the trapezoidal rule for
#'   integration. By default, uses the columns "TAPE" for measurement across xs,
#'   "InvertRod" for depth relative to y = 0, and "Bankful" for baseline
#'   measurement.
#' @param .data A data.frame of cross-section data
#' @param x_cor A column of x-coordinates (default, *TAPE*)
#' @param depth A column of rod readings, relative to 0 (i.e. >0) (default,
#'   *InvertRod*)
#' @param baseline A column of baseline readings (default, *Bankful*)
#' @return A Double of the cross-sectional area compared to a baseline
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom dplyr summarize mutate
#' @export
#' @examples
#'   xs_area(testxs)

xs_area <- function(.data,
                    x_cor = "TAPE",
                    depth = "InvertRod",
                    baseline = "Bankful") {
  .data %>%
    dplyr::mutate(depth_baseline = pmin(.data[[baseline]], .data[[depth]]) - .data[[baseline]]) %>%
    dplyr::summarize(area = abs(pracma::trapz(
      x = .data[[x_cor]],
      y = .data$depth_baseline
    ))) %>%
    as.double()
}
