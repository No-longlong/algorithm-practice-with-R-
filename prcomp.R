dt = iris[, -5]
dt_group = iris[, 5]

pca_dt = prcomp(dt, center = T, scale = T)

pca_dt
plot(pca_dt, type="l")
summary(pca_dt)

#install.packages("devtools")
library(devtools)
#install.packages("ggbiplot")
# ggbiplot 설치 실패