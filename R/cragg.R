#' Calculate the Cragg-Donald statistic for a given model.
#'
#' @param X (formula). A one-sided formula of control variables.
#' @param Y (formula). A one-sided formula of endoenous variables (treatments)
#' @param Z (formula). A one-sided formula of instruments
#' @param data (dataframe). An optional dataframe, list, or environment
#' containing the variables used in the model. As with many of the base R
#' functions, if the variables are not found here, they may be searched for in
#' the environment cragg_donald() was called.
#'
#' @return (cd_test) results object of class "cd_test"
#'
#' @examples
#' cragg_donald(
#'		X = ~ control_1 + control_2 + control_3,
#'		Y = ~ treatment_1 + treatment_2,
#'		Z = ~ instrument_1 + instrument_2, instrument_3,
#'		data = dataframe
#' )
#'
#' @export
cragg_donald <- function(X,Y,Z,data=data.frame()) {

	X_m <- as.matrix(model.matrix(X, data))
	Y_m <- as.matrix(model.matrix(Y, data)[,-1])
	Z_m <- as.matrix(model.matrix(Z, data)[,-1])

	Z_ <- cbind(X_m,Z_m)

	Mx <- diag(nrow(X_m)) - X_m %*% solve(t(X_m) %*% X_m) %*%t(X_m)

	YT <- Mx %*% Y_m

	ZT <- Mx %*% Z_m
	PZT <- ZT %*% solve(t(ZT) %*% ZT ) %*% t(ZT)
	Mz_<-diag(nrow(Z_)) - Z_ %*% solve(t(Z_) %*% Z_) %*%t(Z_)

	T <- nrow(X_m)
	K1 <- ncol(X_m)
	K2 <- ncol(Z_m)
	N <- ncol(Y_m)

	Sig_hat_vv<-(t(Y_m) %*% Mz_ %*% Y_m) / (T - K1 - K2)

	fstat_matrix <- (solve(Sig_hat_vv)**.5 %*% t(YT) %*% PZT %*% YT %*% solve(Sig_hat_vv)**.5)/K2

	cd_stat <- min(eigen(fstat_matrix)$values)
	df <- T - K1 - K2

	RVAL <- list(cd_stat = cd_stat,
		df = df,
		X=X,Y=Y,Z=Z,
		K1=K1, K2=K2, N=N,
		data=deparse(substitute(data))
	)
	class(RVAL) <- "cd_test"

	RVAL
}
