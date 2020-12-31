test_that("Stock and Yogo critical values match those given in paper for bias", {
		expect_equal(stock_yogo_reccomender(25,2,.05,"bias"),20.73)
		expect_equal(stock_yogo_reccomender(19,1,.1,"bias"),11.46)
		expect_equal(stock_yogo_reccomender(6,2,.2,"bias"),6.08)
		expect_equal(stock_yogo_reccomender(19,1,.3,"bias"),4.51)
		expect_equal(stock_yogo_reccomender(7,3,.2,"bias"),5.56)
})
test_that("Stock and Yogo critical values match those given in paper for size", {
		expect_equal(stock_yogo_reccomender(5,2,.1,"size"),19.45)
		expect_equal(stock_yogo_reccomender(4,1,.15,"size"),13.96)
		expect_equal(stock_yogo_reccomender(10,2,.2,"size"),11.65)
		expect_equal(stock_yogo_reccomender(20,2,.25,"size"),13.84)
})
test_that("stock_yogo_reccomender warns when N gets greater than what they give values for in the paper", {
		expect_warning(stock_yogo_reccomender(5,8,.1,"bias"),"available up to N=3")
		expect_warning(stock_yogo_reccomender(4,8,.15,"size"),"available up to N=2")
})
test_that("stock_yogo_reccomender fails if bias/size is not given", {
		expect_error(stock_yogo_reccomender(5,8,.1,"wrong input"),"size / bias")
})
test_that("stock_yogo_reccomender fails if bias is specified wrongly", {
		expect_error(stock_yogo_reccomender(5,8,1,"bias"),"Bias must be one of")
		expect_error(stock_yogo_reccomender(5,8,1,"size"),"Bias must be one of")
})
