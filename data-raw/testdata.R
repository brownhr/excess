## code to prepare `testdata` dataset goes here
library(readr)
testdata <- read_csv("data-raw/testdata.csv")


usethis::use_data(testdata, overwrite = TRUE)
