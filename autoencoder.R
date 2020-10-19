#install.packages("autoencoder")
library(autoencoder)
X = USArrests

aeNN <- autoencoder(faithful, hiddenLayers = c(4,1,4), batchSize = 5,
                    learnRate = 1e-5, momentum = 0.5, L1 = 1e-3, L2 = 1e-3,
                    robErrorCov = TRUE)
# autoencoder 라이브러리를 못찾음