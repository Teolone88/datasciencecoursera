## Example 1

Load the Alzheimer's disease data using the commands:  
```{r}
library(AppliedPredictiveModeling)  
data(AlzheimerDisease)
```
Which of the following commands will create non-overlapping training and test sets with about 50% of the observations assigned to each?
```{r}
adData = data.frame(diagnosis,predictors)  
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)  
training = adData[-testIndex,]  
testing = adData[testIndex,]
```

## Example 2

Load the cement data using the commands:
```{r}
library(AppliedPredictiveModeling)  
data(concrete)  
library(caret)  
set.seed(1000)  
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]  
training = mixtures[ inTrain,]  
testing = mixtures[-inTrain,]  
```

Make a plot of the outcome (CompressiveStrength) versus the index of the samples. Color by each of the variables in the data set (you may find the cut2() function in the Hmisc package useful for turning continuous covariates into factors). What do you notice in these plots?

```{r}
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
```
```{r}
library(GGally)
library(Hmisc)
## Using ggpair
training2 <- training
#cut CompressiveStrength into 4 levels.  This is the only way to work with colour in ggpair
training2$CompressiveStrength <- cut2(training2$CompressiveStrength, g=4)
ggpairs(data = training2, columns = c("FlyAsh","Age","CompressiveStrength"), mapping = ggplot2::aes(colour = CompressiveStrength))
```

There is a non-random pattern in the plot of the outcome versus index that does not appear to be perfectly explained by any predictor suggesting a variable may be missing.

## Example 

Load the cement data using the commands:
```{r}
library(AppliedPredictiveModeling)  
data(concrete)  
library(caret)  
set.seed(1000)  
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]  
training = mixtures[ inTrain,]  
testing = mixtures[-inTrain,]
```

Make a histogram and confirm the SuperPlasticizer variable is skewed. Normally you might use the log transform to try to make the data more symmetric. Why would that be a poor choice for this variable?
```{r}
library(AppliedPredictiveModeling)
data(concrete)
suppressMessages(library(caret))
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
par(mfrow = c(2,1))
hist(training$Superplasticizer)
hist(log(training$Superplasticizer + 1))
```

There are a large number of values that are the same and even if you took the log(SuperPlasticizer + 1) they would still all be identical so the distribution would not be symmetric.

## Example 4
```{r}
library(caret)  
library(AppliedPredictiveModeling)  
set.seed(3433)data(AlzheimerDisease)  
adData = data.frame(diagnosis,predictors)  
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]training = adData[ inTrain,]  
testing = adData[-inTrain,] 
```

Find all the predictor variables in the training set that begin with IL. Perform principal components on these variables with the preProcess() function from the caret package. Calculate the number of principal components needed to capture 90% of the variance. How many are there?
```{r}
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```
```{r}
trainingIL <- training[,grep("^IL", names(training))]
procTrain <- preProcess(trainingIL, method = "pca", thresh = 0.9 )
procTrain
```
```{r}
## Created from 251 samples and 12 variables
## 
## Pre-processing:
##   - centered (12)
##   - ignored (0)
##   - principal component signal extraction (12)
##   - scaled (12)
## 
## PCA needed 9 components to capture 90 percent of the variance
```

## Example 5

Load the Alzheimer’s disease data using the commands:
```{r}
library(caret)  
library(AppliedPredictiveModeling)  
set.seed(3433)data(AlzheimerDisease)  
adData = data.frame(diagnosis,predictors)  
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]training = adData[ inTrain,]  
testing = adData[-inTrain,]  
```

Create a training data set consisting of only the predictors with variable names beginning with IL and the diagnosis. Build two predictive models, one using the predictors as they are and one using PCA with principal components explaining 80% of the variance in the predictors. Use method=“glm” in the train function.

What is the accuracy of each method in the test set? Which is more accurate?
```{r}
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```
```{r}
# grep all columns with IL and diagnosis in the traning and testing set
trainingIL <- training[,grep("^IL|diagnosis", names(training))]
testingIL <- testing[,grep("^IL|diagnosis", names(testing))]
```
```{r}
# non-PCA
model <- train(diagnosis ~ ., data = trainingIL, method = "glm")
predict_model <- predict(model, newdata= testingIL)
matrix_model <- confusionMatrix(predict_model, testingIL$diagnosis)
matrix_model$overall[1]
##  Accuracy 
## 0.6463415
# PCA
modelPCA <- train(diagnosis ~., data = trainingIL, method = "glm", preProcess = "pca",trControl=trainControl(preProcOptions=list(thresh=0.8)))
matrix_modelPCA <- confusionMatrix(testingIL$diagnosis, predict(modelPCA, testingIL))
matrix_modelPCA$overall[1]
##  Accuracy 
## 0.7195122
```
Non-PCA Accuracy: 0.65

PCA Accuracy: 0.72
