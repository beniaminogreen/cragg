
# Cragg

An R package to implement the Cragg-Donald test for weak instruments.

## Overview

Cragg is an R package to implement the
[Cragg-Donald](https://doi.org/10.1017/S0266466600007519) test for weak
instruments, using critical values from [Stock and
Yogo](https://ssrn.com/abstract=1734933). These tests quantify the
degree to which weak instruments can undermine regression estimates for
models with multiple endogenous variables / treatments.

### Main Features

-   Calculates Cragg-Donald statistics for weak instruments.

-   Recommends critical values for the Cragg-Donald Statistic based on
    the largest allowable bias relative to regular OLS or maximum Wald
    test size distortion.

## Installation

``` r
#install.packages("devtools")
devtools::install_github("beniaminogreen/cragg")
```

## Usage

The cragg package has two main functions `cragg_donald()`, and
`stock_yogo_test()` \_\_\_\_\_\_ `cragg_donald()` implements the
Cragg-Donald test for weak instruments in R. It can be thought of as the
matrix-equivalent of the first-stage F-test for weak instruments, and is
used to evaluate models with multiple endogenous variables. The syntax
is show below:

``` r
library(cragg)
#Cragg-Donald Test
cragg_donald(
    ~X1+X2+X3,  #Controls
    ~D,         #Treatments
    ~Z1 + Z2,   #Instruments
    data =example_data
)
#> Cragg-Donald test for weak instruments:
#> 
#>      Data:                        example_data 
#>      Controls:                    ~X1 + X2 + X3 
#>      Treatments:                  ~D 
#>      Instruments:                 ~Z1 + Z2 
#> 
#>      Cragg-Donald Statistic:        204.3325 
#>      Df:                                 994
```

`stock_yogo_test()` implements the Stock and Yogo test for weak
instruments. This test is based off the Cragg-Donald statistic, and

``` r
stock_yogo_test(
    ~X1+X2+X3,  #Controls
    ~D,         #Treatments
    ~Z1 + Z2,   #Instruments
    B=.1,       #Maximum Allowable Size Distortion
    size_bias="size", #Calculate critical value for size distortions
    data =example_data
)
#> Results of Stock and Yogo test for weak instruments:
#> 
#>      Null Hypothesis:             Instruments are weak 
#>      Alternative Hypothesis:      Instruments are not weak 
#> 
#> 
#>      Data:                        data       
#>      Controls:                    ~X1 + X2 + X3 
#>      Treatments:                  ~D 
#>      Instruments:                 ~Z1 + Z2 
#> 
#>      Alpha:                             0.05 
#>      Acceptable level of bias:    10% Wald test distortion.
#>      Critical Value:                   19.93 
#> 
#>      Cragg-Donald Statistic:        204.3325 
#>      Df:                                 994
```
