## Example 1

Consider the following data with x as the predictor and y as as the outcome.
```{r}
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62) 
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36) ## Give a P-value for the two sided hypothesis test of whether β1 from a linear regression model is 0 or not.
```

```{r}
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit<-lm(y~x)
est<-predict(fit,data.frame(x))

plot(x,y)
abline(fit,col="red")
plot of chunk unnamed-chunk-1
```
```{r}
summary(fit)
## 
## Call:
## lm(formula = y ~ x)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.2764 -0.1881  0.0136  0.1660  0.2714 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)    0.188      0.206    0.91    0.391  
## x              0.722      0.311    2.33    0.053 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.223 on 7 degrees of freedom
## Multiple R-squared:  0.436,  Adjusted R-squared:  0.355 
## F-statistic: 5.41 on 1 and 7 DF,  p-value: 0.053
#p-value: 0.053
```

## Example 2

Consider the previous problem, give the estimate of the residual standard deviation.

```{r}
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

n <- length(y)

beta1 <- cor(y, x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)

yhat <- beta0 + beta1 * x
residuals <- y - yhat

sigma <- sqrt(sum(residuals^2)/(n-2))
sigma ## [1] 0.2229981
```

## Example 3

In the mtcars data set, fit a linear regression model of weight (predictor) on mpg (outcome). Get a 95% confidence interval for the expected mpg at the average weight. What is the lower endpoint?

```{r}
x<-mtcars$wt
y<-mtcars$mpg
fit<-lm(y ~ x)

predict(fit,data.frame(x=mean(x)), interval="confidence")
```
```{r}
##     fit   lwr   upr
## 1 20.09 18.99 21.19
```
```{r}
p1<-predict(fit,data.frame(x), interval="confidence")
plot(x,y,xlab='Weight (1000lb)',ylab='MPG')
abline(fit,col="red")
lines(x,p1[,2],col="purple")
lines(x,p1[,3],col="purple")
```

## Example 4

Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?

The estimated expected change in mpg per 1,000 lb increase in weight.

## Example 5

Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs). A new car is coming weighing 3000 pounds. Construct a 95% prediction interval for its mpg. What is the upper endpoint?

```{r}
predict(fit,data.frame(x=3), interval="prediction")
##     fit   lwr   upr
## 1 21.25 14.93 27.57
```

## Example 6

Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs). A “short” ton is defined as 2,000 lbs. Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight. Give the lower endpoint.

```{r}
fit2<-lm(y~I(x/2))
tbl2<-summary(fit2)$coefficients
mn<-tbl2[2,1]      #mean is the estimated slope
std_err<-tbl2[2,2] #standard error
deg_fr<-fit2$df    #degree of freedom
#Two sides T-Tests
mn + c(-1,1) * qt(0.975,df=deg_fr) * std_err
## [1] -12.973  -8.405
par(mfrow=c(1,2))
plot(x,y)
abline(fit,col="red")
plot(x/2,y)
abline(fit2,col="red")
```

1000lb v.s. short ton (2000lb per short ton)

## Example 7

If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?

```{r}
summary(fit)$coefficients
##             Estimate Std. Error t value  Pr(>|t|)
## (Intercept)   37.285     1.8776  19.858 8.242e-19
## x             -5.344     0.5591  -9.559 1.294e-10
```
```{r}
fit3<-lm(y~I(x/100))
summary(fit3)$coefficients
##             Estimate Std. Error t value  Pr(>|t|)
## (Intercept)    37.29      1.878  19.858 8.242e-19
## I(x/100)     -534.45     55.910  -9.559 1.294e-10
```

## Example 8

I have an outcome, Y, and a predictor, X and fit a linear regression model with Y=β0+β1X+ϵ to obtain β^0 and β^1. What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, X+c for some constant, c?

```{r}
c<-5
cf1<-summary(fit)$coefficients
cf1
```
```{r}
##             Estimate Std. Error t value  Pr(>|t|)
## (Intercept)   37.285     1.8776  19.858 8.242e-19
## x             -5.344     0.5591  -9.559 1.294e-10
```
```{r}
fit4<-lm(y~I(x+c)) # add some constant c
cf2<-summary(fit4)$coefficients
cf2
```
```{r}
##             Estimate Std. Error t value  Pr(>|t|)
## (Intercept)   64.007     4.6257  13.837 1.467e-14
## I(x + c)      -5.344     0.5591  -9.559 1.294e-10
```
```{r}
b0<-cf1[1,1]
b1<-cf1[2,1]
c(b0,b1)
```
```{r}
## [1] 37.285 -5.344
```
```{r}
b0 - c*b1
```
```{r}
## [1] 64.01
```

## Example 9

Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor. About what is the ratio of the the sum of the squared errors, ∑ni=1(Yi−Y^i)2 when comparing a model with just an intercept (denominator) to the model with the intercept and slope (numerator)?

Model with Slope & Intercept v.s. Model with only Intercept v.s. Only Slope

```{r}
fit5<-lm(y ~ 1)
fit6<-lm(y ~ x - 1)
plot(x,y)

abline(fit,col="red")
abline(fit5,col="blue")
abline(fit6,col="green")
```
```{r}
anova(fit)
## Analysis of Variance Table
## 
## Response: y
##           Df Sum Sq Mean Sq F value  Pr(>F)    
## x          1    848     848    91.4 1.3e-10 ***
## Residuals 30    278       9                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
```{r}
anova(fit5)
## Analysis of Variance Table
## 
## Response: y
##           Df Sum Sq Mean Sq F value Pr(>F)
## Residuals 31   1126    36.3
```
```{r}
278/1126 ## residual with divided by residual without 
## [1] 0.2469
```

## Example 10
Do the residuals always have to sum to 0 in linear regression?

```{r}
sum(resid(fit))  #both intercept and slope
## [1] -1.638e-15
```
```{r}
sum(resid(fit5)) #only intercept
## [1] -5.995e-15
```
```{r}
sum(resid(fit6)) #only slope
## [1] 98.12
```

How can we measure which one is the best model? Use Sigma or R^2

```{r}
summary(fit)$sigma   #both intercept and slope
## [1] 3.046
```
```{r}
summary(fit5)$sigma  #only intercept
## [1] 6.027
```
```{r}
summary(fit6)$sigma  #only slope
## [1] 11.27
```
