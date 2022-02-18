#' Calculate XS area from data
#' @param .data A data.frame of cross-section data
#' @return A Double of the cross-sectional area compared to a baseline (default, *Bankful*)
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @import dplyr
#' @export

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))



# # Function is Depreciated... remove later
# xs_area2 <- function(.data) {
#   # Mutate the InvertRod to be relative to Bankful;
#   # This can easily be appended to also calculate area relative to another
#   # feature, such as WS or whatever else.
#
#
#   # Set values of InvertRod > Bankful equal to Bankful, then normalize the
#   # whole dataset such that Bankful = 0 (baseline)
#
#   .data <- .data %>%
#     dplyr::mutate(Depth_Baseline = (pmin(.data$InvertRod, .data$Bankful) - .data$Bankful))
#
#
#   # Approximate integration using trapezoidal rule with basepoints at x = xs$TAPE
#   area <- abs(pracma::trapz(x = .data$TAPE,
#                             y = .data$Depth_Baseline))
#   return(area)
# }


xs_area <- function(.data,
                     .x_cor = TAPE,
                     .invertrod = InvertRod,
                     .bankfull = Bankful) {
  .x_cor <- enquo(.x_cor)
  .invertrod <- enquo(.invertrod)
  .bankfull <- enquo(.bankfull)

  .data %>%
    mutate(depth_bf = pmin(!!.bankfull, !!.invertrod)-!!.bankfull) %>%
    summarize(area = abs(pracma::trapz(x = !!.x_cor,
                                       y = .data$depth_bf))) %>%
    as.double()
}



# path <- "data"

# xs_files <- (list.files(path, pattern = ".xlsx", full.names = T))

# xs_areas <- sapply(
#   X = xs_files,
#   FUN = function(x) {
#     file = read_xlsx(x)
#     area = xs_area(file)
#     return(area)
#   }
# ) %>%
#   # Convert to a df; code after this is unnecessary if you just want a named vector
#   as.data.frame() %>%
#   tibble::rownames_to_column(var = "xs_Name") %>%
#   dplyr::rename(xs_Area = ".")
