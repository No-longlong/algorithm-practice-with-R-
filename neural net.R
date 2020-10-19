library(nnet)
library(caret)
library(e1071)
#("e1071")
df = iris
plot(iris)
str(iris)
summary(iris)
sum(is.na(iris))

training_sampling <- sort(sample(1:nrow(df), nrow(df) * 0.7 ))
test_sampling <- setdiff(1:nrow(df),training_sampling)

training_set = df[training_sampling,]
test_set = df[test_sampling,]

# 모델 생성
nnet_m = nnet(Species ~. , data = training_set, size=3)
nnet_p = predict(nnet_m, newdata = test_set, type='class')

nnet_p = as.factor(nnet_p)
confusionMatrix(nnet_p, test_set$Species)

#############################

#install.packages("neuralnet")
library("neuralnet")

set.seed(123)
idx = sample(1:nrow(iris), 0.7*nrow(iris))
train_iris = iris[idx,]
test_iris = iris[-idx,]
head(train_iris)

train_iris$Species2[train_iris$Species=='setosa']=1
train_iris$Species2[train_iris$Species=='versicolor']=2
train_iris$Species2[train_iris$Species=='virginica']=3
train_iris$Species = NULL
head(train_iris)

test_iris$Species2[test_iris$Species=='setosa']=1
test_iris$Species2[test_iris$Species=='versicolor']=2
test_iris$Species2[test_iris$Species=='virginica']=3
test_iris$Species=NULL
head(test_iris)

normal_func <- function(x){
  return ((x-min(x))/ (max(x)-min(x)))
}

train_nor = as.data.frame(lapply(train_iris, normal_func))
train_nor
summary(train_nor)

test_nor <-as.data.frame(lapply(test_iris, normal_func))
test_nor
summary(test_nor)

model_net <- neuralnet(Species2 ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = train_nor,hidden=1)
model_net
plot(model_net)

model_result <- compute(model_net, test_nor[c(1:4)])
model_result

cor(model_result$net.result,test_nor$Species2)

model_net2 <- neuralnet(Species2 ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = train_nor, hidden=2 ,algorithm = "backprop" ,learningrate = 0.01)
model_net2
plot(model_net2)

model_result2 <- compute(model_net2, test_nor[c(1:4)])
model_result2
cor(model_result2$net.result,test_nor$Species2)

set.seed(1)
train<-sample(1:nrow(iris),nrow(iris)*0.7)
test <- seq(nrow(iris))[-train]
iristrain <-iris[train, ]
iristest <-iris[test, ]
dim(iristrain); dim(iristest)

iristrain <- cbind(iristrain, iristrain$Species=='setosa') 
iristrain <- cbind(iristrain, iristrain$Species=='versicolor')
iristrain <- cbind(iristrain, iristrain$Species=='virginica')
names(iristrain)[6:8] <-c('setosa','virginica','versicolor')
head(iristrain, 3)

nn <- neuralnet(setosa + virginica + versicolor ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = iristrain,hidden = 3)
plot(nn)

comp <- compute(nn, iristest[-5])
names(comp)
pred.weight <-comp$net.result
pred.weight
idx <- apply(pred.weight, 1, which.max)
idx

pred <-c('setosa','virginica','versicolor')[idx]
pred
table(pred,iristest$Species)
