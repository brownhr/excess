## code to prepare `pebble1` dataset goes here
pebble1 <- readxl::read_xlsx("data-raw/DS2-XS2 9.13.2021.xlsx", col_types = c("text"))

pebble1 <- subset(pebble1, select = -c(length(pebble1)))

pebble1 <- as.matrix(pebble1)


usethis::use_data(pebble1, overwrite = TRUE)
