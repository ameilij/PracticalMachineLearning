library(ISLR)
library(ggplot2)
library(caret)
library(Hmisc)
library(gridExtra)
data(Wage)
summary(Wage)

inTrain <- createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain, ]
testing <- Wage[-inTrain, ]
dim(training)
dim(testing)

# Feature Plot
featurePlot(x = training[, c("age", "education", "jobclass")], y = training$wage, plot = "pairs")

# QPlot
qplot(age, wage, data = training)
qplot(age, wage, colour = jobclass, data = training)

# Add regression smoothers
qplot(age, wage, colour = education, data = training) + geom_smooth(method = "lm", formula = y ~ x)

# Cutting and making factor variables
cutWage <- cut2(training$wage, g = 3)
table(cutWage)
p1 <- qplot(cutWage, age, data = training, fill = cutWage, geom = c("boxplot"))
p2 <- qplot(cutWage, age, data = training, fill = cutWage, geom = c("boxplot", "jitter"))
grid.arrange(p1, p2, ncol = 2)

# Review tables
t1 <- table(cutWage, training$jobclass)
t1
prop.table(t1, 1)
prop.table(t1, 2)

# Density plots
qplot(wage, colour = education, data = training, geom = "density")

