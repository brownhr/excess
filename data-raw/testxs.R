## code to prepare `testdata` dataset goes here
library(dplyr)
testxs <- readr::read_csv("data-raw/testdata.csv")
testxs <- testxs %>% mutate(across(everything(), set_units, "ft"))

usethis::use_data(testxs, overwrite = TRUE)
