# Practical Machine Learning
<center>![JHU](https://github.com/ameilij/PracticalMachineLearning/blob/master/JHU-Logo-Square-Mini_180px.png)</center>

__COURSERA Practical Machine Learning Class | Johns Hopkins University__

This is my repository for all code examples, homework and investigation of Machine Learning concerning COURSERA Johns Hopkins University Practical Machine Learning class. The following files are available for all to use.

__BasicAnalysis.R__
This is a very simple example of what happpens when you overfit a model. It's the first introduction to prediction and why sometimes too many rules can ruin the predictor. 

__BasicPreprocessing.R__
While it is tempting to start training a predictor from the get go, most datasets will require some preprocessing. Maybe the data is skewed, or maybe some data needs imputation. Many good examples to follow on stardardizing and such.

__BasicTreeCalssification.R__
Classifying with trees is a fun algorithm for predicting if an entity belongs or not to a class. These methods are better for predictions in non-linear environments. 

__BoxCox.R__
BoxCox transformation takes continuous data and tries to mimic normal data. It does so estimating a set of parameters using maximum likelihood. Maybe for the uber-Statistician but handy when needed.

__caretDataSlicing.R__
Samples on data slicing with the Caret package.

__caretExample1.R__
First entry point for very simple creation of test and training data sets.

__imputingData.R__
Examples of how to properly impute data so your predictors don't suffer. 

__MLMultipleCovariates.R__
More advanced code samples of using ML with multiple covariates. Includes official Johns Hopkins solution plus my own code on using stepAIC (a rather controversial yet useful function for multiple covariate selection) for building multiple covariate predictor formulas. Used with training and testing sets, you can verify on your own using <code js>cor(x,y)</code> check. 

__MLRegression1.R__
Machine learning example with multiple regression using one covariate. Easy to follow, yet a lot to learn!

__pcaBase.R__
Good example of using PCA (principal component analysis) to reduce two very similar predictors into one without losing prediction capacity. 

__plottingPredictors.R__
Good examples of using plots on training sets to guide predictors through EDA (Explorative Data Analysis.)

__tidyCovariates.R__
More necessary for some methods - regression and SVM's - than others, tidy covariates are new covariates to simplify prediction formulas. Good examples in here!

__trainingOptions.R__
Simplest creation of training data template so far in this repository.

More files will be added in the future. I hope this helps you get started in Machine Learning as it has helped me =)

> Panama | August 2016
