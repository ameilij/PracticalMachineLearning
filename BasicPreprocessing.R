library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)

training <- spam[inTrain, ]
testing <- spam[-inTrain, ]
hist(training$capitalAve, main = "", xlab = "Average Capitol Run Length")

mean(training$capitalAve)
sd(training$capitalAve)

# Standardizing 
trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve - mean(trainCapAve)) / sd(trainCapAve)
mean(trainCapAveS)
sd(trainCapAveS)

# When we apply to test model, use same parameters as training!
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve - mean(trainCapAve)) / sd(trainCapAve)
mean(testCapAveS)
sd(testCapAveS)

# The preprocess function helps
preObj <- preProcess(training[,-58], method = c("center", "scale"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)

# Checking out the preProcess function without eliminating outcome variable
preObj <- preProcess(training, method = c("center", "scale"))
trainCapAveS <- predict(preObj, training)$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)


