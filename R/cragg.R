#' Calculate the Cragg-Donald statistic for a given model.
#' @param X formula of control variables
#' @param Y fromula of treatment variable
#' @param Z formula of instrumental variables
#' @return The Cragg-Donald Statistic from the specified model
#' @export
cragg_donald <- function(X,Y,Z,data_fr) {
	X <- model.matrix(X, data_fr)
	Y <- model.matrix(Y, data_fr)[,-1]
	Z <- model.matrix(Z, data_fr)[,-1]

	Z_ <- cbind(X,Z)

	Mx <- diag(nrow(X)) - X %*% solve(t(X) %*% X) %*%t(X)

	YT <- Mx %*% Y

	ZT <- Mx %*% Z
	PZT <- ZT %*% solve(t(ZT) %*% ZT ) %*% t(ZT)
	Mz_<-diag(nrow(Z_)) - Z_ %*% solve(t(Z_) %*% Z_) %*%t(Z_)

	T <- nrow(X)
	K1 <- ncol(X)
	K2 <- ncol(Z)

	Sig_hat_vv<-(t(Y) %*% Mz_ %*% Y) / (T - K1 - K2)

	fstat_matrix <- (solve(Sig_hat_vv)**.5 %*% t(YT) %*% PZT %*% YT %*% solve(Sig_hat_vv)**.5)/K2

	min(eigen(fstat_matrix)$values)
}

