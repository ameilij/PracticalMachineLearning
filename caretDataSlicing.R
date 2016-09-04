library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)

training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

set.seed(32323)
folds <- createFolds(y = spam$type, k = 10, list = TRUE, returnTrain = TRUE)
sapply(folds, length)

# There is an option to return test sets
folds <- createFolds(y = spam$type, k = 10, list = TRUE, returnTrain = FALSE)

# And also resampling
folds <- createResample(y = spam$type, times = 10, list = TRUE)
folds[[1]][1:10]

# Time slices are also possible
time <- 1:1000
folds <- createTimeSlices(y = time, initialWindow = 20, horizon = 10)
names(folds)
