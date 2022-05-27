#' @title Read Total Station .txt File
#' @description Reads a total station .txt points file, containing northing,
#'   easting, and elevation, to an sf multipoints object

#' @importFrom magrittr %>%
#' @importFrom sf st_as_sf
#'
#' @param file Path to input .txt file to be read by readr::read_table.
#' @param crs (Optional) CRS to be passed to sf
#' @inheritParams readr::read_table
#' @inheritDotParams readr::read_table
#' @param coord_cols Either one of \code{NULL} (default), in which the Northing (Y) and
#'   Easting (X) coordinates are automatically (and
#'   potentially incorrectly) guessed; a character vector containing the
#'   names of the columns, or a numerical vector of the indices (e.g. \code{c{2:3}}).
#'
#' @return An \code{sf} object with the \code{geometry} column set to the value of \code{coord_cols}
#'
#' @examples
#' \dontrun{
#' f <- "data/totalcoords.txt"
#' r <- xs_read_table(f, skip = 2, coord_cols = c("X", "Y"))
#' }
#'


xs_read_table <-
  function(file,
           skip = 0,
           crs = NA,
           coord_cols = NULL,
           ...) {
    r <- readr::read_table(
      file = file,
      skip = skip,
      skip_empty_rows = TRUE,
      ...) %>%
        stats::na.omit()


    # Guess the column names automatically, which is the default option.

    if (is.null(coord_cols)) {
      coord_cols <- c(
        northing_col = colnames(r)[stringr::str_detect(colnames(r), "([Nn]orthing)|(Yy)")],
        easting_col = colnames(r)[stringr::str_detect(colnames(r), "([Ee]asting)|(Xx)")]#,
        # elev_col = colnames(r)[stringr::str_detect(colnames(r), "[Ee]lev(ation)?|(Zz)")]
      )
    }
    sf <- sf::st_as_sf(r, coords = c(coord_cols["easting_col"], coord_cols["northing_col"]), crs = crs)
    return(sf)
  }
