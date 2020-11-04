## Example 1

What is the variance of the distribution of the average an IID draw of <img src="https://render.githubusercontent.com/render/math?math=n"> observations from a population with mean <img src="https://render.githubusercontent.com/render/math?math=\mu"> and variance <img src="https://render.githubusercontent.com/render/math?math={\sigma^2}"> ?

* <img src="https://render.githubusercontent.com/render/math?math={\frac{\sigma^2}{n}}">
* <img src="https://render.githubusercontent.com/render/math?math={\sigma^2}">
* <img src="https://render.githubusercontent.com/render/math?math={2\frac{\sigma}{\sqrt{n}}}">
* <img src="https://render.githubusercontent.com/render/math?math={\frac{\sigma}{n}}">

For large enough <img src="https://render.githubusercontent.com/render/math?math=n">, the distribution of <img src="https://render.githubusercontent.com/render/math?math=S_n"> is close to the normal distribution with mean <img src="https://render.githubusercontent.com/render/math?math=\mu"> and variance <img src="https://render.githubusercontent.com/render/math?math=\frac{\sigma^2}{n}">

## Example 2

Suppose that diastolic blood pressures (DBPs) from men aged 35-44 are normally distributed with a mean of 80mmHg and a standard deviation of 10 mmHg. About what is the probability that a random 35-44 year old has a DBP less than 70 ?

Let <img src="https://render.githubusercontent.com/render/math?math=\X">be DBP. We want <img src="https://render.githubusercontent.com/render/math?math=\P(X \leq 70)\)"> given that <img src="https://render.githubusercontent.com/render/math?math=\X"> is <img src="https://render.githubusercontent.com/render/math?math=\mathcal{N}(80, 10^2)\)">.

```{r}
xDBP <- 70
μ <- 80
σ <- 10
p <- round(pnorm(xDBP, mean = μ, sd = σ, lower.tail = TRUE) * 100)
P
```
## Example 3

Brain volume for adult women is normally distributed with a mean of about 1,100 cc for women with a standard deviation of 75 cc. What brain volume represents the 95th percentile?

Let <img src="https://render.githubusercontent.com/render/math?math=\X"> be the volume of the brain for adult women. We want <img src="https://render.githubusercontent.com/render/math?math=\X"> so that  <img src="https://render.githubusercontent.com/render/math?math=\F(x) = 0.95\)">.
We just need to calculate the quantile corresponding to a probability of 0.95, knowing that the brain volume follows a normal law <img src="https://render.githubusercontent.com/render/math?math={\mathcal{N}(1100,{75^2})}">.

```{r}
q <- 0.95
μ <- 1100
σ <- 75
x <- round(qnorm(q, mean = μ, sd = σ))
x
```

## Example 4

Refer to the previous question. Brain volume for adult women is about 1,100 cc for women with a standard deviation of 75 cc. Consider the sample mean of 100 random adult women from this population. What is the 95th percentile of the distribution of that sample mean?

Let <img src="https://render.githubusercontent.com/render/math?math=\(\bar X\)"> be the average sample mean for 100 randomly sampled women.

The standard error is <img src="https://render.githubusercontent.com/render/math?math=\SE_{\bar X} = \frac{\sigma}{\sqrt{n}}\)"> and <img src="https://render.githubusercontent.com/render/math?math=\X"> is <img src="https://render.githubusercontent.com/render/math?math=\mathcal{N}(1100, 75^2 / 100)\)">.

As the number of people is large enough, we can consider that the sample mean follows a normal distribution <img src="https://render.githubusercontent.com/render/math?math={\mathcal{N}(\mu,{\sigma^2}/n)}">, where <img src="https://render.githubusercontent.com/render/math?math=\mu =">1100, <img src="https://render.githubusercontent.com/render/math?math=\sigma =">75 and <img src="https://render.githubusercontent.com/render/math?math=\mathcal{N} =">100.

```{r}
q <- 0.95
μ <- 1100
σ <- 75
n <- 100
SE <- σ/sqrt(n)
round(qnorm(q, mean = μ, sd = SE))
```

## Question 5

You flip a fair coin 5 times, about what’s the probability of getting 4 or 5 heads?

As the coin is fair, the probability of getting 1 head at each flip is 0.5. The probability of getting at least 4 heads after 5 flips canbe computed using the binomial law.

<img src="https://render.githubusercontent.com/render/math?math={p = \mathcal{C}_{5}^{4}.(0.5)^4(1-0.5) + \mathcal{C}_{5}^{5}.(0.5)^5}">

```{r}
p <- 0.5
n <- 5
p.4heads <- choose(n, 4) * p^n
p.5heads <- choose(n, 5) * p^n
## <-- choose(5,4) * .5 ^ 5 + choose(5,5) * .5 ^ 5 --> ##
p.cumul <- round((p.4heads + p.5heads) * 100)
p.cumul
```

## Question 6

The respiratory disturbance index (RDI), a measure of sleep disturbance, for a specific population has a mean of 15 (sleep events per hour) and a standard deviation of 10. They are not normally distributed. Give your best estimate of the probability that a sample mean RDI of 100 people is between 14 and 16 events per hour?

The standard error of the mean is <img src="https://render.githubusercontent.com/render/math?math={\frac{\sigma}{\sqrt{n}}}">, where <img src="https://render.githubusercontent.com/render/math?math=\sigma =">10 and <img src="https://render.githubusercontent.com/render/math?math=\n =">100. So the value is 1. We then want to measure the probability of the RDI being inside 1 standard deviation around the mean. Thus it should be around 68%.

```{r]
μ <- 15
σ <- 10
n <- 100
SE <- σ/sqrt(n)

lower <- 14 ## 0
upper <- 16 ## 1

p.lower <- pnorm(lower, mean = μ, sd = SE) * 100
p.upper <- pnorm(upper, mean = μ, sd = SE) * 100

p.cumul <- round(p.upper - p.lower)
p.cumul
```

## Question 7

Consider a standard uniform density. The mean for this density is .5 and the variance is 1 / 12. You sample 1,000 observations from this distribution and take the sample mean, what value would you expect it to be near?

Using the LLN, the value should be approximately 0.5, but let’s check.

```{r}
q <- 0.5
μ <- 0.5
σ <- 1/12
n <- 1000 ## Must be a number
SE <- σ/sqrt(n)

qnorm(q, mean = μ, sd = SE)
```
## Question 8

The number of people showing up at a bus stop is assumed to be Poisson with a mean of 5 people per hour. You watch the bus stop for 3 hours. About what’s the probability of viewing 10 or fewer people?

Let <img src="https://render.githubusercontent.com/render/math?math=\X"> be the number of people in 3 hours then <img src="https://render.githubusercontent.com/render/math?math=\X \sim Poisson(\t \lambda) = Poisson(3 \times 5)\)">

```{r}
t <- 3
λ <- 5
q <- 10

p <- round(ppois(q, lambda = t * λ), digits=2)
p
```
