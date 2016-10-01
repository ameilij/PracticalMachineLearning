# Basic Tree Clasification

# Load basic data from the iris data set
data(iris)
library(caret)
library(ggplot2)
names(iris)
table(iris$Species)

# Prepare training and testing sets
inTrain <- createDataPartition(y = iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
dim(training)
dim(testing)

# Get a sense of petal vs. sepal width
qplot(Petal.Width, Sepal.Width, colour = Species, data = training)

# Fit a model
modFit <- train(Species ~ ., method = "rpart", data = training)
print(modFit$finalModel)
plot(modFit$finalModel, uniform = TRUE, main = "Classification Tree")
text(modFit$finalModel, use.n = TRUE, all = TRUE, cex = 0.8)

# Pretty tree version - BUT ONLY WORKS IF YOU INSTALL GTK+
library(rattle)
fancyRpartPlot(modFit$finalModel)

# Predict new values with the testing set
predict(modFit, newdata = testing)
confusionMatrix(predict(modFit, newdata = testing), testing$Species)
