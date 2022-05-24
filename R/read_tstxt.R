#' @title Read Total Station .txt File
#' @description Reads a total station .txt points file, containing northing,
#'   easting, and elevation, to an sf multipoints object

#' @importfrom magrittr `%>%`
#' @import readr
#' @import sf
#' @import lidR
#' @import fs


read_tstxt <-
  function(file,
           skip = 0,
           col_names = c("PointNo.", "Y", "X", "Z", "Description"),
           crs = NULL,
           ...) {
    f <- fs::path(file)
    r <- readr::read_table(f, skip = skip, skip_empty_rows = TRUE, col_names = col_names)
    r <- r %>% na.omit()

  }
