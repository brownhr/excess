#' Sample cross-sectional data
#'
#' Cross-sectional data acquired from the Watauga River, Boone, N.C., U.S.
#'
#' @author Josh Platt
#' @author Quincy Williams
#'
#' @docType data
#'
#'
#' @usage NULL
#' @format A tibble of 34 rows and 3 variables:
#' \describe{
#'   \item{TAPE}{Tape measurement; x-coordinate}
#'   \item{InvertRod}{Depth measurement in meters}
#'   \item{Bankful}{Bankful measurement}
#' }
"testxs"


#' @title Sample pebble count data 1
#'
#' @description Pebble count data acquired from the Downstream-2 Cross Section 2
#'   site; Sep. 13, 2021
#'
#' @author Josh Platt
#' @docType data
#'
#' @usage NULL
#' @format A matrix of 20 rows and 8 columns: each column represents a transect
#'   and each cell in that column represents a recording from river left (row 1)
#'   to river right (row 20)
#'
"pebble1"


#' @title Test xs in \code{sf} format
#'
#' @description Simple example dataset of how to use data created by \code{sf}
#' @docType data
#' @author Harrison Brown
#' @usage NULL
#' @format A data frame with 34 rows and 4 variables:
#' \describe{
#'   \item{\code{TAPE}}{double Cross-section measurement}
#'   \item{\code{InvertRod}}{double Depth measurement}
#'   \item{\code{Bankful}}{double Baseline measurement}
#'   \item{\code{geometry}}{list \code{geometry} column of class `sfc`}
#'}
"test_sf"
