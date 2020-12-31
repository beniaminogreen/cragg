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
