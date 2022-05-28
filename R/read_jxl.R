#' @title read_jxl
#'
#' @description Reads a .jxl file as an R object
#' @param file Path to input .jxl file
#' @importFrom xml2 read_xml
#'
#' @return Object of class "sf"
#'
#'
#' @export

read_jxl <- function(file) {
  # This function doesn't currently do anything special, just a wrapper for
  # xml2::read_xml, but once we get some sample data from the total station, I
  # can actually do some work on it.

  xml <- xml2::read_xml(file)
  base::return(xml)
}
