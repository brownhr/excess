## code to prepare `testdata` dataset goes here
library(readr)
testxs <- read_csv("data-raw/testdata.csv")


usethis::use_data(testxs, overwrite = TRUE)
