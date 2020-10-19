require(MASS)

r = lda(formula = Species ~.,
        data = iris,
        prior = c(1,1,1)/3)


prop = r$svd^2/sum(r$svd^2)


r2 = lda(formula = Species ~ .,
         data = iris,
         prior = c(1,1,1)/3,
         CV = TRUE)

train = sample(1:150, 75)

r3 = lda(Species ~ .,
         iris,
         prior = c(1,1,1)/3,
         subset = train)

plda = predict(object = r,
               newdata = iris[-train, ])

plda
