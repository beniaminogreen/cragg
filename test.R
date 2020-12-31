devtools::document()
#devtools::test()
devtools::load_all()

data54 <- read.csv("tests/testthat/test-data/data_1.csv")
stock_yogo_test(~X1, ~DB, ~Z1 + Z2, data = data54)
