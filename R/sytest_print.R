statprint <- function (statname,stat) {
		cat(
		format("",width=4),
		format(statname,width=28),
		format(stat, width =10),
		"\n")
}

#' @export
print.cd_test <- function (x,...) {
	cat("Cragg-Donald test for weak instruments:\n\n")

	statprint("Data:",x$data )
	statprint("Controls:",x$X )
	statprint("Treatments:",x$Y )
	statprint("Instruments:",x$Z )
	cat("\n")
	statprint("Cragg-Donald Statistic:",x$cd_stat )
	statprint("Df:",x$df)
}

#' @export
print.sy_test <-function(x,...) {
	x$B=100*x$B
	cat("Results of Stock and Yogo test for weak instruments:\n\n")
	statprint("Null Hypothesis:", "Instruments are weak")
	statprint("Alternative Hypothesis:", "Instruments are not weak")
	cat("\n\n")

	statprint("Data:",x$data )
	statprint("Controls:",x$X )
	statprint("Treatments:",x$Y )
	statprint("Instruments:",x$Z )
	cat("\n")

	statprint("Alpha:", .05)
	if (x$size_bias == "bias") {
		cat(
			format("",width=4),
			format("Acceptable level of bias:", width=28),
			format(paste0(x$B,"% relative to OLS.\n"))
			)
	} else {
		cat(
			format("",width=4),
			format("Acceptable level of bias:", width=28),
			format(paste0(x$B,"% Wald test distortion.\n"))
			)
	}

	statprint("Critical Value:",x$crit_val)
	cat("\n")
	statprint("Cragg-Donald Statistic:",x$cd_stat )
	statprint("Df:",x$df)
}
