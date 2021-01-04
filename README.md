
# Cragg

An R package to implement the Cragg-Donald test for weak instruments.

[![Build
Status](https://travis-ci.com/beniaminogreen/cragg.svg?branch=main)](https://travis-ci.com/beniaminogreen/cragg)
![Codecov](https://img.shields.io/codecov/c/github/beniaminogreen/cragg)
[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

## Overview

The Cragg-Donald (1993) test is a common way to test for weak
instruments in an IV regeression but has never been implemented in R.
The cragg package provides an implementation of the Cragg-Donald test in
R and provides access to the critical values for the Cragg-Donald
statistic developed in Stock and Yogo (Stock 2005). These tests quantify
the degree to which weak instruments can undermine regression estimates
for models with multiple endogenous variables / treatments.

### Main Features

-   Calculates Cragg-Donald statistics for weak instruments.

-   Recommends critical values for the Cragg-Donald Statistic based on
    the largest allowable bias relative to regular OLS or the maximum
    allowable size distortion of the Wald test statistic.

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
multiple endogenous variables. This function has been tested against the
results from STATA’s ivreg2 package (Baum, Mark, Stillman 2002) to
ensure accuracy.

The syntax is show below:

``` r
library(cragg)
#Cragg-Donald Test
cragg_donald(
    ~X1+X2+X3,  #Controls
    ~D1 + D2,           #Treatments
    ~Z1 + Z2 + Z3,  #Instruments
    data =example_data
)
#> Cragg-Donald test for weak instruments:
#> 
#>      Data:                        example_data 
#>      Controls:                    ~X1 + X2 + X3 
#>      Treatments:                  ~D1 + D2 
#>      Instruments:                 ~Z1 + Z2 + Z3 
#> 
#>      Cragg-Donald Statistic:        186.1346 
#>      Df:                                 993
```

`stock_yogo_test()` implements the Stock and Yogo test for weak
instruments. The test developed by Stock and Yogo (2005) is a decision
rule meant to ensure that weak instruments do not pose a problem. Stock
and Yogo suggest two methods to select the critical values: one based on
maximum allowable bias relative to normal OLS and another based on the
maximum size of a Wald test on all of the instruments. Both of these
decision rules are implemented.

``` r
stock_yogo_test(
    ~X1+X2+X3,  #Controls
    ~D1,            #Treatments
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
#>      Data:                        example_data 
#>      Controls:                    ~X1 + X2 + X3 
#>      Treatments:                  ~D1 
#>      Instruments:                 ~Z1 + Z2 
#> 
#>      Alpha:                             0.05 
#>      Acceptable level of bias:    10% Wald test distortion.
#>      Critical Value:                   19.93 
#> 
#>      Cragg-Donald Statistic:        360.5978 
#>      Df:                                 994
```

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-ivreg2" class="csl-entry">

Baum, Christopher F, Mark E Schaffer, and Steven Stillman. 2002. “<span
class="nocase">IVREG2: Stata module for extended instrumental
variables/2SLS and GMM estimation</span>.” Statistical Software
Components, Boston College Department of Economics.

</div>

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
