
# Cragg

An R package to implement the Cragg-Donald test for weak instruments.

## Overview

Cragg is an R package to implement the
[Cragg-Donald](https://doi.org/10.1017/S0266466600007519) test for weak
instruments, using critical values from [Stock and
Yogo](https://ssrn.com/abstract=1734933).

### Main Features

-   Calculates Cragg-Donald staistics for weak instruments.

-   Reccomends critical values for the Cragg-Donald Statistic based on
    the largest allowable bias relative to regular OLS or maximum Wald
    test size distortion.

## Installation

``` r
#install.packages("devtools")
devtools::install_github("beniaminogreen/cragg")
```

## Usage

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

stock_yogo_test(
    ~X1+X2+X3,  #Controls
    ~D,         #Treatments
    ~Z1 + Z2,   #Instruments
    B=.1,
    size_bias="size",
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
