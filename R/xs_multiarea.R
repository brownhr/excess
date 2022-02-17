library(dplyr)
library(readxl)

source("xs_area.R")

path <- "data"

xs_files <- (list.files(path, pattern = ".xlsx", full.names = T))

xs_areas <- sapply(
  X = xs_files,
  FUN = function(x) {
    file = read_xlsx(x)
    area = xs_area(file)
    return(area)
  }
) %>%
  # Convert to a df; code after this is unnecessary if you just want a named vector
  as.data.frame() %>%
  tibble::rownames_to_column(var = "xs_Name") %>%
  dplyr::rename(xs_Area = ".")
