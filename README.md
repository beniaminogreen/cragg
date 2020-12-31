
# Cragg

An R package to implement the Cragg-Donald test for weak instruments.

## Overview

Cragg is an R package to implement the Cragg-Donald
([1993](#ref-Cragg_1993)) test for weak instruments, using critical
values from Stock and Yogo ([2005](#ref-Stock_2005)). These tests
quantify the degree to which weak instruments can undermine regression
estimates for models with multiple endogenous variables / treatments.

### Main Features

-   Calculates Cragg-Donald statistics for weak instruments.

-   Recommends critical values for the Cragg-Donald Statistic based on
    the largest allowable bias relative to regular OLS or the maximum
    allowable size distortion of the Wald test.

## Installation

``` r
#install.packages("devtools")
devtools::install_github("beniaminogreen/cragg")
```

## Usage

The cragg package has two main functions `cragg_donald()`, and
`stock_yogo_test()`.

`cragg_donald()` implements the Cragg-Donald test for weak instruments
in R. It can be thought of as the matrix-equivalent of the first-stage
F-test for weak instruments, and is used to evaluate models with
multiple endogenous variables. The syntax is show below:

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
instruments. The Stock and Yogo test is based on a set of critical
values for the Cragg-Donalds statistic based on the null hypothesis

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

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Cragg_1993" class="csl-entry">

Cragg, John G., and Stephen G. Donald. 1993. “Testing Identifiability
and Specification in Instrumental Variable Models.” *Econometric Theory*
9 (2): 222–40. <https://doi.org/10.1017/s0266466600007519>.

</div>

<div id="ref-Stock_2005" class="csl-entry">

Stock, James H., and Motohiro Yogo. 2005. “Testing for Weak Instruments
in Linear IV Regression.” In *Identification and Inference for
Econometric Models*, 80–108. Cambridge University Press.
<https://doi.org/10.1017/cbo9780511614491.006>.

</div>

</div>
