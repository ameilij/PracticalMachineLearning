# Regression Example with Machine Learning

library(caret)
data(faithful)
set.seed(333)

inTrain <- createDataPartition(y = faithful$waiting, p = 0.5, list = FALSE)
trainFaith <- faithful[inTrain, ]
testFaith <- faithful[-inTrain, ]
head(trainFaith)

# Look at relationship with a visual graph
plot(trainFaith$waiting, trainFaith$eruptions, pch = 19, col = "blue", xlab = "waiting", ylab = "duration")

# Fit linear model
lm1 <- lm(eruptions ~ waiting, data = trainFaith)
summary(lm1)

plot(trainFaith$waiting, trainFaith$eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration")
lines(trainFaith$waiting, lm1$fitted.values, lwd = 3)

# Let's predict a new value manually
newvalue = 80
coef(lm1)[1] + coef(lm1)[2] * newvalue

newdata = data.frame(waiting = 80)
predict(lm1, newdata)

# But how do we evaluate the test set?
# Plot training and test set

par(mfrow = c(1,2))

plot(trainFaith$waiting, trainFaith$eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration")
lines(trainFaith$waiting, predict(lm1), lwd = 3)

plot(testFaith$waiting, testFaith$eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration")
lines(testFaith$waiting, predict(lm1, newdata = testFaith), lwd = 3)

# Test errors for datasets
sqrt(sum((lm1$fitted.values - trainFaith$eruptions) ^ 2))
sqrt(sum((predict(lm1, newdata = testFaith) - testFaith$eruptions) ^ 2))

# My own test to detect correlation in dataset and model
cor(trainFaith$waiting, trainFaith$eruptions)
cor(trainFaith$waiting, predict(lm1, trainFaith))
cor(testFaith$waiting, testFaith$eruptions)
cor(testFaith$waiting, predict(lm1, newdata = testFaith))

myRealTestValues <- testFaith$eruptions
myPredictedTestValues <- predict(lm1, newdata = testFaith)
quantile(myRealTestValues)
quantile(myPredictedTestValues)

# Prediction intervals
pred1 <- predict(lm1, newdata = testFaith, interval = "prediction")
ord <- order(testFaith$waiting)
plot(testFaith$waiting, testFaith$eruptions, pch = 19, col = "blue")
matlines(testFaith$waiting[ord], pred1[ord, ], type = "l", col = c(1,2,2), lty = c(1,1,1), lwd = 3)

modFit <- train(eruptions ~ waiting, data = trainFaith, method = "lm")
summary(modFit$finalModel)

plot(testFaith$waiting, testFaith$eruptions, pch = 19)
lines(testFaith$waiting, predict(modFit, newdata = testFaith), lwd = 3)
