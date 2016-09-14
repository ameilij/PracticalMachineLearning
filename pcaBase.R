# Principal Component Analysis
library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)

training <- spam[inTrain, ]
testing <- spam[-inTrain, ]

M <- abs(cor(training[, -58]))
diag(M) <- 0
which(M > 0.8, arr.ind = TRUE)

# Looking at two variables in particular
names(spam)[c(34, 32)]
plot(spam[, 34], spam[, 32])
cor(spam[, 34], spam[, 32])

# Since these two variables are almost the same, we can reduce them
x <- 0.71 * training$num415 + 0.71 * training$num857
y <- 0.71 * training$num415 + 0.71 * training$num857
plot(x, y)

# PCA in R
smallSpam <- spam[, c(34, 32)]
prComp <- prComp(smallSpam)
plot(prComp$x[,1], prComp$x[, 2])
