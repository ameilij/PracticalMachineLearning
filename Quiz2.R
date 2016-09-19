# QUESTION 1

# Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

# Which of the following commands will create non-overlapping training and test sets with about 50% of 
# the observations assigned to each?

# Example 1 (WRONG but could be usable)
adData = data.frame(predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]
table(training%in%testing)

# Example 2 (WRONG)
adData = data.frame(diagnosis,predictors)
train = createDataPartition(diagnosis, p = 0.50,list=FALSE)
test = createDataPartition(diagnosis, p = 0.50,list=FALSE)
table(train%in%test)

# Example 3 (RIGHT uses all available data)
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]
table(training%in%testing)

# Example 4 (WRONG)
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

# QUESTION 2
# Load the cement data using the commands:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# Make a plot of the outcome (CompressiveStrength) versus the index of the samples. 
# Color by each of the variables in the data set (you may find the cut2() function in the 
# Hmisc package useful for turning continuous covariates into factors). 
# What do you notice in these plots?

library(Hmisc)
ord <- order(training$CompressiveStrength)

par(mfrow = c(2,4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Cement, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$BlastFurnaceSlag, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$FlyAsh, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Water, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Superplasticizer, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$CoarseAggregate, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$FineAggregate, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Age, g=4))

# QUESTION 3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# Make a histogram and confirm the SuperPlasticizer variable is skewed. 
# Normally you might use the log transform to try to make the data more 
# symmetric. Why would that be a poor choice for this variable?
hist(log10(training$Superplasticizer + 1))
quantile(training$Superplasticizer)

# QUESTION 4
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Find all the predictor variables in the training set that begin with IL. 
# Perform principal components on these variables with the preProcess() 
# function from the caret package. Calculate the number of principal components 
# needed to capture 90% of the variance. How many are there?

ILnames <- grepl("^IL", colnames(training))
ILcol <- names(training[ILnames])
ILindex <- which(colnames(training)%in%ILcol)
library(kernlab)
pcaAnalysis <- preProcess(training[, ILindex], method = c("pca","center","scale"), thresh = 0.9)

# The summary is much more visible in the prcomp command
pcaAnalysis2 <- prcomp(training[, ILindex], center = TRUE, scale. = TRUE)
summary(pcaAnalysis2)

# QUESTION 5
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

# Method pca
preProc <- preProcess(train2[, -1], method = c("center", "scale", "pca"), thresh = 0.8)
trainPC <- predict(preProc, train2[, -1])
modelFit <- train(train2$diagnosis, data = trainPC, method = "glm")

# ALTERNATIVE
preProc <- preProcess(train2[, -1], method = c("center", "scale", "pca"), thresh = 0.8)
trainPC <- predict(preProc, train2[, -1])

p <- NULL
p$diagnosis <- training$diagnosis
p$PC1 <- trainPC$PC1
p$PC2 <- trainPC$PC2
p$PC3 <- trainPC$PC3
p$PC4 <- trainPC$PC4
p$PC5 <- trainPC$PC5
p$PC6 <- trainPC$PC6
p$PC7 <- trainPC$PC7

modelFit <- train(diagnosis ~ ., method = "glm", data = trainPC)
confusionMatrix(train2$diagnosis, predict(modelFit, trainPC))



