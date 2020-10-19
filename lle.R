#install.packages("lle")
library(lle)
data(lle_scurve_data)
X <- lle_scurve_data
head(X, n=3)

neighbours <- find_nn_k(X, k=15)
neighbours[1:6, 1:6]

weights <- find_weights(neighbours, X, m=2, reg=2)
weights$wgts[1:6, 1:6]

#install.packages("scatterplot3d")
library(scatterplot3d)


scatterplot3d(x=X[,1], y=X[,2], z=X[,3], color=X[,2])

k5 <- lle(X, m=2, k=5, reg=2, ss=FALSE, id=TRUE, v=0.9 )

plot(k5$Y, main="K=5 data", xlab=expression(y[1]), ylab=expression(y[2]))

k15 <- lle(X, m=2, k=15, reg=2, ss=FALSE, id=TRUE, v=0.9 )

plot(k15$Y, main="K=15 data", xlab=expression(y[1]), ylab=expression(y[2]))

k40 <- lle(X, m=2, k=40, reg=2, ss=FALSE, id=TRUE, v=0.9 )

plot(k40$Y, main="K=40 data", xlab=expression(y[1]), ylab=expression(y[2]))

