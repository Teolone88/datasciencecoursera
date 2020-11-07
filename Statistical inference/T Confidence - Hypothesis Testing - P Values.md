## Example 1

In a a population of interest, a sample of 9 men yielded a sample average brain volume of 1,100cc and standard deviation of 30cc. What is a 95% Students’ T confidence interval for a mean brain volume in this new population ?

The confidence interval is given by :
<img src="https://render.githubusercontent.com/render/math?math={CI = \mu \pm \sigma.t_{0.975,n-1}}">

```{r}
mu <- 1100
sigma <- 30
n <- 9
CI <- mu + c(-1,1)*sigma*qt(0.975,df=n-1)/sqrt(n)
CI
```

## Example 2

A diet pill is given to 9 subjects over six weeks. The average difference in weight (follow up - baseline) is -2 pounds. What would the standard deviation of the difference in weight have to be for the upper endpoint of the 95% T confidence interval to touch 0?

Interval <img src="https://render.githubusercontent.com/render/math?math=\CI_{up} = \bar X %2b t_{n-1} S / \sqrt{n}\)">, where <img src="https://render.githubusercontent.com/render/math?math=\t_{n-1}\)"> is the relevant quantile

Rewritten, to get standard deviation: <img src="https://render.githubusercontent.com/render/math?math=\S = \frac{CI_{up} - \bar X * \sqrt{n}}{t_{n-1}}\)">

```{r}
n <- 9
mu <- -2
q = 0.975 # is 95% with 2.5% on both sides of the range
CI.upper = 0 ## -2 is CI.lower endpoint
sigma = (ci.upper - mu * sqrt(n))/qt(q, df=n-1)
round(sigma, 2)
```

Otherwise, regarding the previous formula, we can have the following
<img src="https://render.githubusercontent.com/render/math?math={CI = \mu %2b \sigma.t_{0.975,n-1} = 0}"> <br><br>
so  <img src="https://render.githubusercontent.com/render/math?math={-2 %2b t_{0.975,8}*\frac{\sigma}{\sqrt(n)} = 0}">

```{r}
mu <- -2
n <- 9
sigma <- -mu*sqrt(n)/qt(0.975,df=n-1)
sigma
```

## Example 3

In an effort to improve running performance, 5 runners were either given a protein supplement or placebo. Then, after a suitable washout period, they were given the opposite treatment. Their mile times were recorded under both the treatment and placebo, yielding 10 measurements with 2 subjects per period. The researchers intend to use a t-test and interval to investigate the treatment. Should they use a paired or independent group T test and interval ?

<b>We want to know the impact of the substitution of the treatment and placebo on two independant groups. So we should use a paired t-test.</b>

## Example 4

In a sudy of emergency room waiting times, investigators consider a new and the standard triage system. To test the systems, administrators selected 20 nights and randomly assigned the new triage system to be used on 10 nights. They cdalculated the nightly median waiting waiting time (MWT) to see a physician. The average MWT for the nes system was 3 hours with a variance of 0.60 while the average MWT for the old system was 5 hours with a variance of 0.68. Consider the 95% confidence interval estimate for the differences of the mean MWT associated with the new system. Assume a constant variance. What is the interval ? Substract in this order (New System - Old System).

Having the following: <br>

* <img src="https://render.githubusercontent.com/render/math?math={{S_{new}}^2}"> and <img src="https://render.githubusercontent.com/render/math?math={{S_{old}}^2}"> the variances for the new and old systems. <br>
* <img src="https://render.githubusercontent.com/render/math?math={{mu_{new}}^2}"> and <img src="https://render.githubusercontent.com/render/math?math={{mu_{new}}^2}"> the average MWT for the new and old systems. <br>
* <img src="https://render.githubusercontent.com/render/math?math={{n_{new}}^2}"> and <img src="https://render.githubusercontent.com/render/math?math={{n_{new}}^2}"> the number of nights for the new and old systems. <br>

We deduct the pooled variance estimator as: <br>

<img src="https://render.githubusercontent.com/render/math?math={{S_p}^2 = \frac{(n_{new}-1)*{S_{new}}^2 %2b (n_{old}-1)*{S_{old}}^2}{n_{new} %2b n_{old}-2}}">

And the confidence interval as:

<img src="https://render.githubusercontent.com/render/math?math={CI = \mu_{new} - \mu_{old} \pm t_{0.975,n_{new} %2b n_{old} -2}S_p*\sqrt(1/n_{new} %2b 1/n_{old})^{1/2}}">

```{r}
mu_old <-5
mu_new <- 3
n_old <- 10
n_new <-  10
var_new <- 0.6
var_old<- 0.68
S_p <- sqrt(((n_new-1)*var_new +(n_old-1)*var_old)/(n_new + n_old-2))
CI <- (mu_new - mu_old + c(-1,1)*qt(0.975,n_new+n_old-2)*S_p*sqrt(1/n_new + 1/n_old))
S_p
CI
```

## Example 5

Suppose that you create a 95% T confidence interval. You then create a 90% confidence interval using the same data. What can be said about the 90% interval with repect to the 95% interval?

As <img src="https://render.githubusercontent.com/render/math?math={t_{df,975} > t_{df,95}}"> <br>

The 90% interval will be narrower than the 95% interval.

## Example 6

To further test the hospital triage system, administrators selected 200 nights and randomly assigned a new triage system to be used on 100 nights and a standard system on the remaining 100 nights. They calculated the nightly median waiting time (MWT) to see a physician. The average MWT for the new system was 4 hours with a standard deviation of 0.5 hours while the average MWT for the old system was 6 hours with a standard deviation of 2 hours. Consider the hypothesis of a decrease in the mean MWT associated with the new treatment. What does the 95% independent group confidence interval with unequal variances suggest vis a vis this hypothesis? (Because there’s so many observations per group, just use the Z quantile instead of the T.)

```{r}
q = 0.975 ## is 95% with 2.5% on both sides of the range

n_y <- 100 # no. nights new system
n_x <- 100 # no. nights old system
sigma_y <- 0.50 # sd new 
sigma_x <- 2 # sd old 
mu_y <- 4# average hours new system
mu_x <- 6# average hours old system

# calculate pooled standard deviation
p.sigma <- sqrt(((n_x - 1) * sigma_x^2 + (n_y - 1) * sigma_y^2)/(n_x + n_y - 2))

CI <-  mu_x - mu_y + c(-1, 1) * qnorm(q) * p.sigma * (1 / n_x + 1 / n_y)^.5
round(CI,3)
```
<b>When subtracting (old - new) the interval is entirely above zero. The new system appears to be effective.</b>

## Example 7

Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI over the four week period appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, calculate the relevant 90% t confidence interval. Subtract in the order of (Treated - Placebo) with the smaller (more negative) number first.

```{r}
q = 0.95 # is 90% with 5% on both sides of the range

n_y <- 9 # no. subjects treated
n_x <- 9 # no. subjects placebo
sigma_y <- 1.5 # kg/m2 sd treated 
sigma_x <- 1.8 # kg/m2 sd placebo 
mu_y <- -3 #  kg/m2 average difference treated
mu_x <-  1 #  kg/m2 average difference placebo

# calculate pooled standard deviation
p.sigma <- sqrt(((n_x - 1) * sigma_x^2 + (n_y - 1) * sigma_y^2)/(n_x + n_y - 2))
CI <-  mu_y - mu_x + c(-1, 1) * qt(q, df=n_y+n_x-2) * p.sigma * (1 / n_x + 1 / n_y)^.5
round(CI,3)
```
