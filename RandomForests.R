# Random Forest 

library(caret)
data(iris)
inTrain <- createDataPartition(y = iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]

modFit <- train(Species ~ ., data = training, method = "rf", prox = TRUE)
modFit

# Getting a single tree
getTree(modFit$finalModel, k = 2)

irisP <- classCenter(training[, c(3,4)], training$Species, modFit$finalModel$proximity)
irisP <- as.data.frame(irisP)
irisP$Species <- rownames(irisP)

p <- qplot(Petal.Width, Petal.Length, col = Species, data = training)
p + geom_point(aes(x = Petal.Width, y = Petal.Length, col = Species), size = 5, shape = 4, data = irisP)

# Predicting new values with random forests models
pred <- predict(modFit, testing)
testing$predRight <- pred == testing$Species
table(pred, testing$Species)

qplot(Petal.Width, Petal.Length, colour = predRight, data = testing, main = "Predictions Based on Test Set")
