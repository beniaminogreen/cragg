test_that("cragg_donald results are accurate", {
	results <- read.csv("./test-data/stata_testing_data.csv", header=F)[,2]
	for (i in seq(10)) {
		data <- read.csv(paste0("./test-data/data_", i ,".csv"))
		expect_equal(round(cragg_donald(~X1 + X2 + X3,~D,~Z1 + Z2, data),3), results[i])
	}
	data <- read.csv("./test-data/data_1.csv")
	expect_equal(round(cragg_donald(~1, ~D, ~Z1 + Z2, data_fr = data),3),204.916)
})