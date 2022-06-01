#' Standardize Units
#' @description Converts all columns in a data.frame to use the same system of units
#' @importFrom dplyr mutate across select
#' @importFrom tidyselect vars_select_helpers
#'
#' @param .cols The columns from which the Units are converted (by default, all numeric).
#' @param data A data.frame
#' @param Units Character of the units of measurement (e.g. "m" or "ft") or default NULL
#'
#' @return Data.frame with all columns in \code{.cols} (by default, all numeric columns) converted to use the units defined in \code{Units}
#'

standardize_units <- function(data, .cols = tidyselect::eval_select(is.numeric, data), Units = NULL) {
  data %>%
    dplyr::mutate(
      dplyr::across(
        .cols = tidyselect::all_of(.cols),
        .fns = ~units::set_units(., Units, mode = "standard")))
}
