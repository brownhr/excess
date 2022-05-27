#' @title Read Total Station .txt File
#' @description Reads a total station .txt points file, containing northing,
#'   easting, and elevation, to an sf multipoints object

#' @importFrom magrittr %>%
#' @importFrom readr read_table
#' @import sf
#' @import lidR
#' @importFrom  fs path
#' @importFrom stats na.omit
#'
#' @param file Path to input .txt file to be read by readr::read_table.
#' @param crs CRS to be passed to sf
#' @inheritParams readr::read_table
#' @inheritDotParams readr::read_table
#'
#' @return An object of class st_multipoint
#'


read_tstxt <-
  function(file,
           skip = 0,
           col_names = c("PointNo.", "Y", "X", "Z", "Description"),
           crs = NULL,
           ...) {
    f <- fs::path(file)
    r <- readr::read_table(f, skip = skip, skip_empty_rows = TRUE, col_names = col_names, ...)
    r <- r %>% na.omit()

  }
