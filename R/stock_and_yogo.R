#' Perform the Stock and Yogo test for weak instruments
#'
#' @param X (formula). A one-sided formula of control variables.
#' @param D (formula). A one-sided formula of endogenous variables (treatments)
#' @param Z (formula). A one-sided formula of instruments
#' @param data (dataframe). An optional dataframe, list, or environment
#' containing the variables used in the model. As with many of the base R
#' functions, if the variables are not found here, they may be searched for in
#' the environment cragg_donald() was called.
#' @param B One of \[.05, .1, .15, .2, .25, .3\]. The maximum size of allowable bias relative
#' @param size_bias Either "bias" or "size". Whether to use a critical
#' value based on the maximum allowable bias relative to regular OLS (bias), or maximum
#' Wald test size distortion (size).
#' @return (sy_test) the results of the stock and yogo test.
#'
#' @examples
#' #Perform the Stock and Yogo test on a model that instruments
#' #Sepal Width on Petal Length, Petal Width, and Species, while controlling
#' #for Sepal.Length (a toy example).
#'
#' stock_yogo_test(X=~Sepal.Length, D=~Sepal.Width,
#'		Z=~Petal.Length + Petal.Width + Species,
#'		size_bias="bias",data = iris)
#'
#' @export
stock_yogo_test <- function(X,D,Z,data,B=.05,size_bias="bias"){
	cd <- cragg_donald(X,D,Z,data)
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
#' @param size_bias Either "bias" or "size". Whether to use a critical
#' value based on the maximum allowable bias relative to regular OLS (bias), or maximum
#' Wald test size distortion.
#' @return (float) the recommended critical value.
#'
#' @examples
#' #To reccomend a critical value for a test with 2 endogenous variables
#' #and four instruments based on a 5% maximum allowable bias relative to OLS
#'
#' stock_yogo_reccomender(4,2,.05,"bias")
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
		if ( !K >= N ){
			stop("Error: K must be greater than or equal to N for this operation")
		}
	} else {
		sy_table <- sy_size
		B %in% c(.1,.15,.2,.25) ||
			stop("Bias must be one of .10, .15, .2, .25")
		if (N>2) {
			warning("Warning: critical values for size are only available up to N=2 instruments. Using N=2.")
			N<-2
		}
		if (K<N){
			stop("Error: K must be greater than or equal to N for this operation")
		}
	}


	column_name = paste0("B",B)
	row <- which(sy_table$K == K & sy_table$N==N)

	crit_val <- sy_table[[column_name]][row]
	if (is.null(crit_val)) {
		stop("crit_val not found")
	}
	return(crit_val)
}
