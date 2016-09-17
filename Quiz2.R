## QUESTION 1

## Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

## Which of the following commands will create non-overlapping training and test sets with about 50% of 
## the observations assigned to each?

## Example 1 (WRONG but could be usable)
adData = data.frame(predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]
table(training%in%testing)

## Example 2 (WRONG)
adData = data.frame(diagnosis,predictors)
train = createDataPartition(diagnosis, p = 0.50,list=FALSE)
test = createDataPartition(diagnosis, p = 0.50,list=FALSE)
table(train%in%test)

## Example 3 (RIGHT uses all available data)
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]
table(training%in%testing)


## Example 4 (WRONG)
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50)
training = adData[trainIndex,]
testing = adData[-trainIndex,]


## QUESTION 2

## Load the cement data using the commands:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

## Make a plot of the outcome (CompressiveStrength) versus the index of the samples. 
## Color by each of the variables in the data set (you may find the cut2() function in the 
## Hmisc package useful for turning continuous covariates into factors). 
## What do you notice in these plots?

library(Hmisc)
ord <- order(training$CompressiveStrength)

par(mfrow = c(3,3))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Cement, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$BlastFurnaceSlag, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$FlyAsh, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Water, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Superplasticizer, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$CoarseAggregate, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$FineAggregate, g=4))
qplot(ord, CompressiveStrength, data=training, color=cut2(training$Age, g=4))

## QUESTION 3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

## Make a histogram and confirm the SuperPlasticizer variable is skewed. 
## Normally you might use the log transform to try to make the data more 
## symmetric. Why would that be a poor choice for this variable?
hist(log10(training$Superplasticizer + 1))
quantile(training$Superplasticizer)

## QUESTION 4
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

## Find all the predictor variables in the training set that begin with IL. 
## Perform principal components on these variables with the preProcess() 
## function from the caret package. Calculate the number of principal components 
## needed to capture 90% of the variance. How many are there?

ILnames <- grepl("^IL", colnames(training))
ILcol <- names(training[ILnames])
ILindex <- which(colnames(training)%in%ILcol)
library(kernlab)
pcaAnalysis <- preProcess(training[, ILindex], method = "pca", cor = TRUE, center = TRUE, scale. = TRUE)

## The summary is much more visible in the prcomp command
pcaAnalysis2 <- prcomp(training[, ILindex], center = TRUE, scale. = TRUE)
print(pcaAnalysis2)

## QUESTION 5
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[inTrain,]
testing = adData[-inTrain,]

## Create a training data set consisting of only the predictors with variable names
## beginning with IL and the diagnosis. Build two predictive models, one using the
## predictors as they are and one using PCA with principal components explaining 80%
## of the variance in the predictors. Use method="glm" in the train function.
## What is the accuracy of each method in the test set? Which is more accurate?

ILnames <- grepl("^IL", colnames(training))
ILcol <- names(training[ILnames])
ILindex <- which(colnames(training)%in%ILcol)
train2 <- training[, c(1, ILindex)]
test2 <- testing[, c(1, ILindex)]

# Method glm
fit1 <- train(diagnosis ~ ., data = train2, method = "glm")
confusionMatrix(test2[, 1], predict(fit1, newdata = test2[, -1]))

# Method pca
fit2 <- prcomp(train2[, -1], center = TRUE, scale. = TRUE)
confusionMatrix(test2[, 1], predict(fit2, newdata = test2[, -1]))



