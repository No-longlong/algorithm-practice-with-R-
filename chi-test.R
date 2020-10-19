x <-  matrix(c(324,371.28,78,79.56,261,212.16), nrow=2, 
             dimnames = list(c("관찰", "기대"), c("제품A", "제품B", "제품C")))

barplot(x, beside = TRUE, legend = TRUE)

chisq.test(x, y = NULL, correct = TRUE,
           p = rep(1/length(x), length(x)), rescale.p = FALSE,
           simulate.p.value = FALSE, B = 2000)

chisq.test(x = x[c(1),], p = c(0.56, 0.12, 0.32))

px <- seq(0, 20, length.out = 101)
plot(px, dchisq(px, 2), type = 'l', col = 'blue')

xa <- qchisq(0.95, 2)
lines(c(xa, xa), c(1, 0), lty = 2)

xc <- qchisq(1 - 0.0001756, 2)
lines(c(xc, xc), c(1, 0), col = 'red')


install.packages("descr")

library(descr)

x <-  matrix(c(269,155,83,57,215,181), nrow = 2,
             dimnames = list(c("여성", "남성"), c("제품1", "제품2", "제품3")))

CrossTable(x, expected = TRUE, prop.r = FALSE, prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE)

chisq.test(x)
