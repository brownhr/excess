## code to prepare `testdata` dataset goes here
library(tidyverse)
testxs <- readr::read_csv("data-raw/testdata.csv")
testxs <- testxs %>% mutate(across(everything(), set_units, "ft"))

testxs$ID <- c(letters, LETTERS)[1:nrow(testxs)]

usethis::use_data(testxs, overwrite = TRUE)

testxs2 <- readxl::read_xlsx("data-raw/xs-ds1/DS1XS3_1.xlsx")

usethis::use_data(testxs2, overwrite = TRUE)
