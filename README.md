
<!-- README.md is generated from README.Rmd. Please edit that file -->

# excess

<!-- badges: start -->
<!-- badges: end -->

The `excess` package is designed to provide a set of tools and workflows
to analyze and interpret hydrological cross-sectional data. This package
is currently in development, so use with caution :smile:.

## Installation

You can install the development version of excess from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("brownhr/excess")
```

## Calculating cross-sectional area

Under the hood, the `xs_area()` function calculates the area of a
cross-section through use of the **trapezoidal rule**, as provided by
the `pracma` package.

``` r
library(excess)

head(testdata)
#> # A tibble: 6 x 3
#>    TAPE InvertRod Bankful
#>   <dbl>     <dbl>   <dbl>
#> 1  0        -0.83   -3.29
#> 2  1        -1.01   -3.29
#> 3  3        -1.48   -3.29
#> 4  4.7      -1.19   -3.29
#> 5  5.95     -1.19   -3.29
#> 6  9.8      -1.93   -3.29
```

``` r
## If you can't find the `testdata` object, load it with data()

data(testdata)
```

``` r
xs_area(testdata)
#> [1] 23.4665
```

You can visualize cross-sections with `xs_ribbon()`

``` r
xs_ribbon(testdata)
```

<img src="man/figures/README-xs-ribbon-1.png" width="100%" />
