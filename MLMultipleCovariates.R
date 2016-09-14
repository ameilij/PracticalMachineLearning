# Predicting Regression with Multiple Covariates
library(ISLR)
library(ggplot2)
library(caret)
data(Wage)

Wage2 <- subset(Wage, select = -c(logwage))
summary(Wage2)

inTrain <- createDataPartition(y = Wage2$wage, p = 0.7, list = FALSE)
training <- Wage2[inTrain, ]
testing <- Wage2[-inTrain, ]
dim(training)
dim(testing)

# Feature Plot
featurePlot(x = training[, c("age", "education", "jobclass")], y = training$wage, plot = "pairs")

# Plot different variable combinations
qplot(age, wage, data = training)
qplot(age, wage, colour = jobclass, data = training)
qplot(age, wage, colour = education, data = training)

# Now we can fit a linear model
modFit <- train(wage ~ age + jobclass + education, method = "lm", data = training)
finMod <- modFit$finalModel
print(finMod)

# Plot new model
plot(finMod, 1, pch = 19, cex = 0.5, col = "#00000010")
qplot(finMod$fitted, finMod$residuals, colour = race, data = training)
plot(finMod$residuals, pch = 19)

# Test new model on real testing data
pred <- predict(modFit, testing)
qplot(wage, pred, colour = year, data = testing)

# Short version with all covariates test
modFitAll <- train(wage ~ ., data = training, method = "lm")
pred2 <-  predict(modFitAll, testing)
qplot(wage, pred2, data = testing)

# EXTRA CHORE
# Using my own algorithm with controversial stepAIC function
library(MASS)
training2 <- training

# NOTE: preprocess al covariates with near-zero variation!
nsv <- nearZeroVar(training2, saveMetrics = TRUE)
print(nsv)
# Eliminate those covariates
training2$sex <- NULL
training2$region <-  NULL

# Now we can fit a GLM model and step thru the right covariate combination
testFit <- glm(wage ~ .,data = training2)
computerFit <- stepAIC(testFit, direction = "both")
pred3 <-  predict(computerFit, testing)
qplot(wage, pred3, data = testing)
