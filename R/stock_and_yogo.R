#' @export
stock_yogo_test <- function(X,Y,Z,data,B=.05,size_bias="bias"){
	cd <- cragg_donald(X,Y,Z,data)
	RVAL <- c(cd, list(B=B, crit_val = stock_yogo_reccomender(K=cd$K2,N=cd$N,B,size_bias),
	size_bias = size_bias))
	RVAL$data <- deparse(substitute(data))
	class(RVAL)<- "sy_test"

	RVAL
}

#' Recommend a critical value for the Cragg-Donald test given a maximum allowable bias/size distortion
#'
#' @param B One of \[.05, .1, .15, .2, .25, .3\]. The maximum size of allowable bias relative
#' to the normal OLS or the maximum Wald test size distortion.
#' @param N (int).  The number of endogenous variables (treatments)
#' @param K (int). The number of instruments.
#' @param size_bias One of ["bias", "size"]. Whether to use a critical
#' value based on the maximum allowable bias relative to regular OLS (bias), or maximum
#' Wald test size distortion.
#' @return (float) the recommended critical value.
#'
#' @export
stock_yogo_reccomender <- function(K,N,B,size_bias) {
	size_bias %in% c("bias", "size") ||
		stop("size / bias must be specified")

	if (size_bias == "bias") {
		sy_table <- sy_bias
		B %in% c(.05,.1,.2,.3) ||
			stop("Bias must be one of .05, .1, .2, .3")
		if (N>3) {
			warning("Warning: critical values for size are only available up to N=3 instruments. Using N=3")
			N <- 3
		}
	} else {
		sy_table <- sy_size
		B %in% c(.1,.15,.2,.25) ||
			stop("Bias must be one of .10, .15, .2, .25")
		if (N>2) {
			warning("Warning: critical values for size are only available up to N=2 instruments. Using N=2.")
			N<-2
		}
	}

	column_name = paste0("B",B)
	row <- which(sy_table$K == K & sy_table$N==N)
	sy_table[[column_name]][row]
}
