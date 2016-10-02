# Basic boosting: the idea is to take lots of possibly weak predictors, then we
# weight them and add them up. Thus we get a stronger one. 

# Load ISRL data
library(ISLR)
data("Wage")
library(ggplot2)
library(caret)

# Create training and testing sets
wage <- subset(Wage, select = -c(logwage))
inTrain <- createDataPartition(y = wage$wage, p = 0.7, list = FALSE)
training <- wage[inTrain, ]
testing <- wage[-inTrain, ]

# Fit a model using boosting
modFit <- train(wage ~ ., method = "gbm", data = training, verbose = FALSE)
print(modFit)

# Testing
# Remember boosting resampled the training data set, so now it has less 
# observations than in the original. Thus it is hard to cross-validate with
# the same data (length of vectors are not the same!)
qplot(predict(modFit, testing), wage, data = testing)
