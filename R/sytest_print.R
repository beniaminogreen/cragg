statprint <- function (statname,stat) {
		cat(
		format("",width=4),
		format(statname,width=28),
		format(stat, width =10),
		"\n")
}

#' @export
print.cd_test <- function (cd_test) {
	cat("Cragg-Donald test for weak instruments:\n\n")

	statprint("Data:",cd_test$data )
	statprint("Controls:",cd_test$X )
	statprint("Treatments:",cd_test$Y )
	statprint("Instruments:",cd_test$Z )
	cat("\n")
	statprint("Cragg-Donald Statistic:",cd_test$cd_stat )
	statprint("Df:",cd_test$df)
}

#' @export
print.sy_test <-function(sy_test) {
	sy_test$B=100*sy_test$B
	cat("Results of Stock and Yogo test for weak instruments:\n\n")
	statprint("Null Hypothesis:", "Instruments are weak")
	statprint("Alternative Hypothesis:", "Instruments are not weak")
	cat("\n\n")

	statprint("Data:",sy_test$data )
	statprint("Controls:",sy_test$X )
	statprint("Treatments:",sy_test$Y )
	statprint("Instruments:",sy_test$Z )
	cat("\n")

	statprint("Alpha:", .05)
	if (sy_test$size_bias == "bias") {
		cat(
			format("",width=4),
			format("Acceptable level of bias:", width=28),
			format(paste0(sy_test$B,"% relative to OLS.\n"))
			)
	} else {
		cat(
			format("",width=4),
			format("Acceptable level of bias:", width=28),
			format(paste0(sy_test$B,"% Wald test distortion.\n"))
			)
	}

	statprint("Critical Value:",sy_test$crit_val)
	cat("\n")
	statprint("Cragg-Donald Statistic:",sy_test$cd_stat )
	statprint("Df:",sy_test$df)
}
