# Ensembling Methods Code
library(ISLR)
data(Wage)
library(ggplot2)
library(caret)

# Create training, validation and testing data sets
wage <- subset(Wage, select = -c(logwage))

inBuild <- createDataPartition(y = wage$wage, p = 0.7, list = FALSE)

validation <- wage[-inBuild, ]
buildData <- wage[inBuild, ]

inTrain <- createDataPartition(y = buildData$wage, p = 0.7, list = FALSE)

training <- buildData[inTrain, ]
testing <- buildData[-inTrain, ]

dim(training)
dim(testing)
dim(validation)

# Create separate models and test accuracy
model1 <- train(wage ~ ., method = "glm", data = training)
model2 <- train(wage ~ ., method = "rf", data = training, trControl = trainControl(method="cv"),number=3)

pred1 <- predict(model1, testing)
pred2 <- predict(model2, testing)
qplot(pred1, pred2, colour = wage, data = testing)

# Create combined model by stacking
predDF <- data.frame(pred1,pred2,wage=testing$wage)
combModFit <- train(wage ~.,method="gam",data=predDF)
combPred <- predict(combModFit,predDF)

# RMSE of the first model - glm
sqrt(sum((pred1-testing$wage)^2))

# RMSE of the second model - random forest
sqrt(sum((pred2-testing$wage)^2))

# RMSE of the combined model
sqrt(sum((combPred-testing$wage)^2))

qplot(combPred, testing$wage, colour = testing$wage, main = "Combined Classifier Prediction Wage vs. Test Set" )

# Test combined model on test data
pred1V <- predict(model1, validation)
pred2V <- predict(model2, validation)
predVDF <- data.frame(pred1 = pred1V, pred2 = pred2V)
combPredV <- predict(combModFit, predVDF)

sqrt(sum((pred1V - validation$wage)^2))
sqrt(sum((pred2V - validation$wage)^2))
sqrt(sum((combPredV - validation$wage)^2))
