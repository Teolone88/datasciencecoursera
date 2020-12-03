# Load the vowel.train and vowel.test data sets:

library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

# Set the variable y to be a factor variable in both the training and test set. Then set the seed to 33833. Fit (1) a random forest predictor relating the factor variable y to   # the remaining variables and (2) a boosted predictor using the "gbm" method. Fit these both with the train() command in the caret package.

# What are the accuracies for the two approaches on the test data set? What is the accuracy among the test set samples where the two methods agree?

library(devtools)
library(ElemStatLearn)
library(AppliedPredictiveModeling)
library(caret)
library(pgmm)
library(rpart)
library(gbm)
library(lubridate)
library(forecast)
library(e1071)

set.seed(33833)
data(vowel.train); vowel.train$y <- as.factor(vowel.train$y)
data(vowel.test); vowel.test$y <- as.factor(vowel.test$y)
class(vowel.train$y)
levels(vowel.train$y)
# apply random forest
rfFit <- caret::train(y~ .,data=vowel.train,method="rf", do.trace=T)
# predict outcome for test data set using the random forest model
rfPred <- predict(rfFit,vowel.test)
# tabulate results
table(rfPred,vowel.test$y)
# apply gbm
gbmFit <- caret::train(y ~ ., method="gbm", data=vowel.train, verbose=F)
# predict outcome for test data set using the gbm model
gbmPred <- predict(gbmFit,vowel.test)

# Extract accuracies for (1) random forests and (2) gbm
confusionMatrix(rfPred, vowel.test$y)$overall[1]
confusionMatrix(gbmPred, vowel.test$y)$overall[1]

# Create new df with both predictions
predDF <- data.frame(rfPred, gbmPred, y = vowel.test$y)
# Accuracy among the test set samples where the two methods agree
sum(rfPred[predDF$rfPred == predDF$gbmPred] == 
        predDF$y[predDF$rfPred == predDF$gbmPred]) / 
    sum(predDF$rfPred == predDF$gbmPred)

#************************************************************

# Load the Alzheimer's data using the following commands

set.seed(62433)

library(AppliedPredictiveModeling)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis ("lda") model.   # Stack the predictions together using random forests ("rf"). What is the resulting accuracy on the test set? Is it better or worse than each of the individual predictions?

# apply random forest
rfFit <- caret::train(diagnosis~ .,data=training,method="rf", do.trace=T)
# predict outcome for test data set using the random forest model
rfPred <- predict(rfFit,testing)
# tabulate results
table(rfPred,testing$diagnosis)
# apply gbm
gbmFit <- caret::train(diagnosis ~ ., method="gbm", data=training, verbose=F)
# predict outcome for test data set using the generalized booster model (boosted trees)
gbmPred <- predict(gbmFit,testing)
# apply linear discriminant analysis
ldaFit <- caret::train(diagnosis~ .,data=training,method="lda")
# predict outcome for test data set using the linear discriminant analysis model
ldaPred <- predict(ldaFit,testing)


# Extract accuracies for (1) random forests and (2) gbm and (3) lda models
confusionMatrix(rfPred, testing$diagnosis)$overall[1]
confusionMatrix(gbmPred, testing$diagnosis)$overall[1]
confusionMatrix(ldaPred, testing$diagnosis)$overall[1]

# Create new df with all predictions
predDF <- data.frame(rfPred, gbmPred, ldaPred, diagnosis = testing$diagnosis)
# apply random forest to the new df
dfFit <- caret::train(diagnosis~ .,data=predDF,method="rf", do.trace=T)
# predict outcome for new df using the random forest model
dfPred <- predict(dfFit,testing)

# Extract accuracy for new aggregate DF with random forests model
confusionMatrix(dfPred, testing$diagnosis)$overall[1]

#***************************************************************

# Load the concrete data with the commands:

set.seed(233)
library(AppliedPredictiveModeling)
library(elasticnet)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 233 and fit a lasso model to predict Compressive Strength. Which variable is the last coefficient to be set to zero as the penalty increases? (Hint: it may be # useful to look up ?plot.enet).

# apply lasso model
mod_lasso <- train(CompressiveStrength ~ ., data = training, method = "lasso")
# plot model
plot.enet(mod_lasso$finalModel, xvar = "penalty", use.color = TRUE)

#****************************************************************

# Load the data on the number of visitors to the instructors blog from here:
link <- "https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
# Using the commands:

library(lubridate) # For year() function below
library(forecast)

dat = read.csv(file.choose())
training = dat[year(ymd(dat$date)) < 2012,]
testing = dat[year(ymd(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
tstest <- ts(testing$visitsTumblr)

# Fit a model using the bats() function in the forecast package to the training time series. Then forecast this model for the remaining time points. For how many of the testing # points is the true value within the 95% prediction interval bounds?

# apply ts model
tsFit <- bats(tstrain)
# predict model with 95% confidence
tsPred <- forecast(tsFit,level = 95, h = dim(testing)[1])
# calculate percentage of visits from the testing df within the 95% confidence interval of the ts model
sum(tsPred$lower < testing$visitsTumblr & testing$visitsTumblr < tsPred$upper) / 
    dim(testing)[1]
# plot ts with pre and post prediction dates
plot(forecast(tsFit, h=30, level=c(80,95)), xaxt='n')
axis(1, at=seq(1, 365,1) , las=2, labels=seq(as.Date(min(dat$date)), as.Date(max(dat$date)), length.out=365))
axis(1, at=seq(366,395,1), las=2, labels=seq(as.Date(max(dat$date))+days(1),as.Date(max(dat$date))+days(30), length.out=30)) # Overlap of day of transition

#****************************************************

# Load the concrete data with the commands:

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[inTrain, ]
testing = concrete[-inTrain, ]

# Set the seed to 325 and fit a support vector machine using the e1071 package to predict Compressive Strength using the default settings. Predict on the testing set. What is   # the RMSE?

set.seed(325)
library(e1071)
# apply support vector model
svmFit <- svm(CompressiveStrength ~ ., data = training)
# predict model on testing df
svmPred <- predict(svmFit, testing)
# determine accuracy percentage by assessing the root squared errors (RMSE)
accuracy(svmPred, testing$CompressiveStrength)
# plot prediction model
plot(svmPred,testing$CompressiveStrength)
# visualize predictor trend with the outcome
abline(lm(testing$CompressiveStrength ~ predict(svmFit, testing), data = testing), col = "blue", lwd = 2)
