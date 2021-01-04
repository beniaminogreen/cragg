#' Calculate the Cragg-Donald statistic for a given model.
#'
#' @param X (formula). A one-sided formula of control variables.
#' @param D (formula). A one-sided formula of endogenous variables (treatments)
#' @param Z (formula). A one-sided formula of instruments
#' @param data (dataframe). An optional dataframe, list, or environment
#' containing the variables used in the model. As with many of the base R
#' functions, if the variables are not found here, they may be searched for in
#' the environment cragg_donald() was called.
#'
#' @return (cd_test) results object of class "cd_test"
#'
#'
# cragg_donald(
#		X = ~ control_1 + control_2 + control_3,
#		D = ~ treatment_1 + treatment_2,
#		Z = ~ instrument_1 + instrument_2 + instrument_3,
#		data = dataframe
# )
#
#' @export
cragg_donald <- function(X,D,Z,data=data.frame()) {

	X_m <- as.matrix(stats::model.matrix(X, data))
	D_m <- as.matrix(stats::model.matrix(D, data)[,-1])
	Z_m <- as.matrix(stats::model.matrix(Z, data)[,-1])

	T <- nrow(X_m)
	K1 <- ncol(X_m)
	K2 <- ncol(Z_m)
	N <- ncol(D_m)

	Z_ <- cbind(X_m,Z_m)

	Mx <- diag(nrow(X_m)) - X_m %*% solve(t(X_m) %*% X_m) %*%t(X_m)

	DT <- Mx %*% D_m

	ZT <- Mx %*% Z_m
	PZT <- ZT %*% solve(t(ZT) %*% ZT ) %*% t(ZT)
	Mz_<-diag(nrow(Z_)) - Z_ %*% solve(t(Z_) %*% Z_) %*%t(Z_)


	Sig_hat_vv<-(t(D_m) %*% Mz_ %*% D_m) / (T - K1 - K2)

	fstat_matrix <- (t(solve(expm::sqrtm(Sig_hat_vv))) %*% (t(DT) %*% PZT %*% DT) %*% solve(expm::sqrtm(Sig_hat_vv)))/K2
	#fstat_matrix <- (t(1 / expm::sqrtm(Sig_hat_vv)) %*% (t(DT) %*% PZT %*% DT) %*% (1/expm::sqrtm(Sig_hat_vv)))/K2
	#fstat_matrix <- (t(Sig_hat_vv^-.5) %*% (t(DT) %*% PZT %*% DT) %*% (Sig_hat_vv**-.5))/K2
	#fstat_matrix <- (t((Sig_hat_vv)**(-.5)) %*% t(DT) %*% PZT %*% DT %*% (Sig_hat_vv)**(-.5))/K2

	cd_stat <- min(eigen(fstat_matrix)$values)
	df <- T - K1 - K2

	RVAL <- list(cd_stat = cd_stat,
		df = df,
		X=X,D=D,Z=Z,
		K1=K1, K2=K2, N=N,
		data=deparse(substitute(data))
	)
	class(RVAL) <- "cd_test"

	RVAL
}

