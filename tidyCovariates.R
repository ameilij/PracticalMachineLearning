# tidyCovariates.R
# @author Ariel E. Meilij
# @date September 4, 2016

library(ISLR)
library(caret)
data(Wage)

inTrain <- createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain, ]
testing <- Wage[-inTrain, ]

table(training$jobclass)

# Inserting dummy variables
dummies <- dummyVars(wage ~ jobclass, data = training)
head(predict(dummies, newdata = training))

# Remove zero covariates
nsv <- nearZeroVar(training, saveMetrics = TRUE)
nsv

# Breaking into splines
library(splines)
bsBasis <- bs(training$age, df = 3)
bsBasis

# Use a linear model to predict wage according to splines of age
# Plot actual data and then overimpose prediction model based on splines
lm1 <- lm(wage ~ bsBasis, data = training)
plot(training$age, training$wage, pch = 19, cex = 0.5)
points(training$age, predict(lm1, newdata = training), col = "red", pch = 19, cex = 0.5)

# Experiment with TEST set
# Breaking into splines
bsBasis2 <- bs(testing$age, df = 3)
bsBasis2

# Use a linear model to predict wage according to splines of age
# Plot actual data and then overimpose prediction model based on splines
lm2 <- lm(wage ~ bsBasis2, data = testing)
plot(testing$age, testing$wage, pch = 19, cex = 0.5)
points(testing$age, predict(lm2, newdata = testing), col = "red", pch = 19, cex = 0.5)
