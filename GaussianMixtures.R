library(MASS)

data("galaxies")

X = galaxies / 1000

library(mclust, quietly=TRUE)
#install.packages("mclust")

fit = Mclust(X, G=4, model="V")
summary(fit)

plot(fit, what="density", main="", xlab="velocity (Mm/s)")
rug(X)

set.seed(1234)
library(sBIC)
gMix=GaussianMixtures(maxNumComponents = 10, phi=1, restarts = 100)

m = sBIC(X, gMix)
#install.packages("sBIC")
print(m)

matplot(
  cbind(m$BIC - m$BIC[1], m$sBIC - m$sBIC[1]),
  pch = c(1, 3),
  col = "black",
  xlab = "Number of components",
  ylab = expression(BIC - BIC(M[1])),
  las=1, xaxt="n"
)
axis(1, at = 1:10)
legend("topleft",
       c(expression(BIC), expression(bar(sBIC)[1])),
       pch = c(1, 3),
       y.intersp = 1.2)

post.MCMC = c(0.000, 0.000, 0.061, 0.128, 0.182, 0.199, 0.160,
              0.109, 0.071, 0.040, 0.023, 0.013, 0.006, 0.003)[1:10]
post.MCMC = post.MCMC / sum(post.MCMC)

postBIC <- function(BIC) {
  prob <- exp(BIC - max(BIC))
  prob/sum(prob)
}
normalizedProbs = rbind("BIC"=postBIC(m$BIC), "sBIC1"=postBIC(m$sBIC), "MCMC"=post.MCMC)

barplot(
  normalizedProbs,
  beside = TRUE,
  col = c("white","grey","black"),
  legend = c(expression(BIC), expression(bar(sBIC)[1]), expression(MCMC)),
  xlab = "Number of components",
  ylab = "Probability",
  args.legend = list(y.intersp = 1.2),
  names.arg = 1:10
)
