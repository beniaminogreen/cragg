#' @export
print.cd_test <- function (cd_test) {
	cat("Cragg-Donald test for weak instruments:\n\n")

	cat(paste0("	data:		",cd_test$data,"\n"))
	cat(paste0("	Controls:			",cd_test$X[2],"\n"))
	cat(paste0("	Treatments:			",cd_test$Y[2],"\n"))
	cat(paste0("	Instruments:			",cd_test$Z[2],"\n\n"))

	cat(paste0("	Cragg-Donald Statistic:		",round(cd_test$cd_stat,3),"\n"))
	cat(paste0("	Df:				",cd_test$df,"\n"))
}

#' @export
print.sy_test <-function(sy_test) {
	sy_test$B=100*sy_test$B
	cat("Results of Stock and Yogo test for weak instruments:\n\n")
	cat("	Null Hypothesis:		Instruments are weak.\n")
	cat("	Alternative Hypothesis:		Instruments are not weak.\n\n\n")

	cat(paste0("	data:				",sy_test$data,"\n"))
	cat(paste0("	Controls:			",sy_test$X[2],"\n"))
	cat(paste0("	Treatments:			",sy_test$Y[2],"\n"))
	cat(paste0("	Instruments:			",sy_test$Z[2],"\n\n"))

	cat(paste0("	Alpha:				",.05,"\n"))
	if (sy_test$size_bias == "bias") {
		cat(paste0("	Acceptable level of bias:	", sy_test$B,"% relative to OLS.\n"))
	} else {
		cat(paste0("	Acceptable size distortion:	", sy_test$B,"% Wald test distortion.\n"))
	}

	cat(paste0("	Critical Value:			",sy_test$crit_val,"\n\n"))
	cat(paste0("	Df:				",sy_test$df,"\n"))
	cat(paste0("	Cragg-Donald Statistic:		",sy_test$cd_stat,"\n"))
}
