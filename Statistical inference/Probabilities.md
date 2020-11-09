## Example 1

Consider influenza epidemics for two parent heterosexual families. Suppose that the probability is 17% that at least one of the parents has contracted the disease. The probability that the father has contracted influenza is 12% while the probability that both the mother and father have contracted the disease is 6%. What is the probability that the mother has contracted influenza?

We have the following information

<img src="https://render.githubusercontent.com/render/math?math=P(F \cup M) = 0.17">
<img src="https://render.githubusercontent.com/render/math?math=P(F) = 0.12">
<img src="https://render.githubusercontent.com/render/math?math=P(F \cap M ) = 0.06">


From where,

<img src="https://render.githubusercontent.com/render/math?math=P(F \cup M) = P(F) + P(M) - P(F \cap M)">
<img src="https://render.githubusercontent.com/render/math?math=0.17 = 0.12 + P(M) - 0.06">
<img src="https://render.githubusercontent.com/render/math?math=P(M) = 0.17 + 0.06 - 0.12">
<img src="https://render.githubusercontent.com/render/math?math=P(M) = 0.11">

## Example 2

A random variable, X is uniform, a box from 0 to 1 of height 1. (So that its density is f(x)=1 for 0≤x≤1.) What is its 75th percentile?

If the distribution is uniform the 75th percentile should be (1−0)∗0.75=0.75.

## Example 3

You are playing a game with a friend where you flip a coin and if it comes up heads you give her X dollars and if it comes up tails she gives you Y dollars. The probability that the coin is heads is p (some number between 0 and 1.) What has to be true about X and Y to make so that both of your expected total earnings is 0. The game would then be called “fair”.

Let G be your gains. Then, we expect that

<img src="https://render.githubusercontent.com/render/math?math=E[G] = (1-p) Y - p X">

is zero, i.e.

<img src="https://render.githubusercontent.com/render/math?math=(1-p) Y - p X = 0">
<img src="https://render.githubusercontent.com/render/math?math=(1-p) Y  = p X">
<img src="https://render.githubusercontent.com/render/math?math=\frac{Y}{X} = \frac{p}{1-p}">

## Example 4

A density that looks like a normal density (but may or may not be exactly normal) is exactly symmetric about zero. (Symmetric means if you flip it around zero it looks the same.) What is its median?

If the density is symmetric around zero the median should be 0.

## Example 5

Consider the following PMF shown below in R

```{r}
x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp
```
```{r}
##      [,1] [,2] [,3] [,4]
## X     1.0  2.0  3.0  4.0
## Prob  0.1  0.2  0.3  0.4
```

What is the mean?

The mean for this r.v. X is given by

<img src="https://render.githubusercontent.com/render/math?math=E[X] = \sum_{i=1}^4 p_i X_i = (0.1 \times 1.0) %2b (0.2 \times 2.0) %2b (0.3 \times 3.0) %2b (0.4 \times 4.0) = 3."> 

## Example 5

A web site (www.medicine.ox.ac.uk/bandolier/band64/b64-7.html) for home pregnancy tests cites the following: “When the subjects using the test were women who collected and tested their own samples, the overall sensitivity was 75%. Specificity was also low, in the range 52% to 75%.” Assume the lower value for the specificity. Suppose a subject has a positive test and that 30% of women taking pregnancy tests are actually pregnant. What number is closest to the probability of pregnancy given the positive test?

With Sensitivy 75% and Specificity between 52% and 75%, we assume 30% of women taking pregnancy tests are actually pregnant.
Let A be the event “the test is positive” and B the event “the woman is pregnant”. We are interested in the followings:

Sensitivity measures the proportion of positives that are correctly identified (e.g., the percentage of sick people who are correctly identified as having some illness): <img src="https://render.githubusercontent.com/render/math?math=\frac{P(A \cap B)}{P(B)} = P( A | B) = 0.75"> </br>
Specificity measures the proportion of negatives that are correctly identified (e.g., the percentage of healthy people who are correctly identified as not having some illness): <img src="https://render.githubusercontent.com/render/math?math=\frac{P(A^c \cap B^c)}{P(B^c)} = P(A^c | B^c) = 0.52"> </br> <br>

<img src="https://render.githubusercontent.com/render/math?math=P(B) = 0.30"> </br>

<img src="https://render.githubusercontent.com/render/math?math=P(B | A) = \frac{P(A \cap B)}{P(A)}">
<img src="https://render.githubusercontent.com/render/math?math== \frac{P(B) P(A|B)}{P(B) P(A|B) %2b P(B^c) P(A|B^c)}">
<img src="https://render.githubusercontent.com/render/math?math== \frac{P(B) P(A|B)}{P(B) P(A|B) %2b P(B^c) (1-P(A^c|B^c))}">
<img src="https://render.githubusercontent.com/render/math?math== \frac{0.30 * 0.75}{0.30 * 0.75 %2b (1-0.30) (1-0.52)} = 0.4010695">
