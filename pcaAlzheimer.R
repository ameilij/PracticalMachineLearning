# Create a training data set consisting of only the predictors with variable names
# beginning with IL and the diagnosis. Build two predictive models, one using the
# predictors as they are and one using PCA with principal components explaining 80%
# of the variance in the predictors. Use method="glm" in the train function.
# What is the accuracy of each method in the test set? Which is more accurate?

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[inTrain,]
testing = adData[-inTrain,]

# Rebuild train and test set for this exercise
ILnames <- grepl("^IL", colnames(training))
ILcol <- names(training[ILnames])
ILindex <- which(colnames(training)%in%ILcol)
train2 <- training[, c(1, ILindex)]
test2 <- testing[, c(1, ILindex)]

# Method with normal predictors
fit1 <- train(diagnosis ~ ., data = train2, method = "glm")
confusionMatrix(test2[, 1], predict(fit1, newdata = test2[, -1]))
confusionMatrix(train2[, 1], predict(fit1, newdata = train2[, -1]))

# Method pca
preProc <- preProcess(train2[, -1], method = c("center", "scale", "pca"), thresh = 0.8)
trainPC <- predict(preProc, train2[, -1])
testPC <- predict(preProc, test2[, -1])
modelFit <- train(x = trainPC, y = train2$diagnosis, method="glm")
confusionMatrix(test2[, 1], predict(modelFit, testPC))
confusionMatrix(train2[, 1], predict(modelFit, trainPC))
