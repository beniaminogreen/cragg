test_that("cragg_donald results are accurate", {
	fake_data <- function (seed,n) {
		set.seed(seed)
		X1 = runif(n)
		XA = X1*runif(n)
		X2 = runif(n)
		XB = X2*runif(n)
		Z1 = runif(n)
		ZA = Z1*runif(n)
		Z2 = runif(n)
		ZB = Z2*runif(n)
		Z3 = runif(n)
		ZC = Z3*runif(n)
		D1 = XA + 5*ZA +ZB
		D2 = XB + 2*ZB + ZC
		Y = XB + D1*2*runif(n) + D2*runif(n)
		data.frame(X1,X2,Z1,Z2,Z3,Y,D1,D2)
	}

	answers <- c(41.614, 52.252, 33.711, 44.734,39.979,30.105,44.939,27.960,30.532,31.191)
	for (i in seq(20,29)) {
		ans<- answers[i-19]
		cd_stat <- cragg_donald(~X1, ~D1 + D2 ,~ Z1 + Z2 +Z3 , data = fake_data(i,250))$cd_stat
		expect_equal(round(cd_stat,3), ans)
	}
})
