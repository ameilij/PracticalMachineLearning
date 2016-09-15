library(caret)
data(mtcars)

inTrain <- createDataPartition(y = mtcars$mpg, p = 0.5, list = FALSE)
trainCars <- mtcars[inTrain, ]
testCars <- mtcars[-inTrain, ]

trainFit <- train(mpg ~ ., data = trainCars, method = "lm")
summary(trainFit$finalModel)

par(mfrow = c(1,2))
plot(trainCars$hp, trainCars$mpg, main = "Training Data")
plot(trainCars$hp, predict(trainFit), main = "Predictions Using Training Data")

par(mfrow = c(1,2))
plot(testCars$hp, testCars$mpg, main = "Test Data")
plot(testCars$hp, predict(trainFit, newdata = testCars), main = "Predictions Using Test Data" )

## Use stepAIC
library(MASS)
aicFit <- lm(mpg ~ .,data = trainCars)
step <- stepAIC(aicFit, direction="both")
summary(step)
