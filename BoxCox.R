library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)

training <- spam[inTrain, ]
testing <- spam[-inTrain, ]
hist(training$capitalAve, main = "", xlab = "Average Capitol Run Length")

# BoxCox transformation takes continuous data and tries to mimic normal data.
# It does so estimating a set of parameters using maximum likelihood
preObj <- preProcess(training[, -58], method = c("BoxCox"))

trainCapAveS <- predict(preObj, training[, -58])$capitalAve

par(mfrow = c(2,1))
hist(trainCapAveS)
qqnorm(trainCapAveS)
