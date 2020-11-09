## Example 1

A pharmaceutical company is interested in testing a potential blood pressure lowering medication. Their first examination considers only subjects that received the medication at baseline then two weeks later. The data are as follows (SBP in mmHg).

| Subject  | Baseline | Week 2 |
| --- | --- | --- |
| 1  | 140  | 132 |
| 2  | 138  | 135 |
| 3  | 150  | 151 |
| 4  | 148  | 146 |
| 5  | 135  | 130 |

Consider testing the hypothesis that there was a mean reduction in blood pressure? Give the P-value for the associated two sided T test.

(Hint, consider that the observations are paired.)

<img src="https://render.githubusercontent.com/render/math?math={H_{0}: \mu_{d}=0}"> <br>
versus <br>
<img src="https://render.githubusercontent.com/render/math?math={H_{0}: \mu_{d} \neq 0}"> <br>
where <br>
<img src="https://render.githubusercontent.com/render/math?math={\mu_{d}}">  is the mean difference between followup and baseline.

```{r}
baseline <- c(140, 138, 150, 148, 135)
future <- c(132, 135, 151, 146, 130)
t.test(future, baseline, alternative = "two.sided", paired = TRUE)
```
OR
```{r}
t.test(future - baseline, alternative = "two.sided")
```

## Example 2

A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is the complete set of values of <img src="https://render.githubusercontent.com/render/math?math= {\mu_{0}}"> that a test of <img src="https://render.githubusercontent.com/render/math?math= {H_{0}: \mu= \mu_{0}}"> would fail to reject the null hypothesis in a two sided 5% Students t-test?

We want to determine the 95% confidence interval for this Student’s t-test.
This is the 95% student's T confidence interval.

```{r}
n <- 9
mu <- 1100
sd <- 30
p <- .975 # 2.5% for each side test
mu + c(-1, 1) * qt(p, n-1) * sd/sqrt(n)
```

## Example 3

Researchers conducted a blind taste test of Coke versus Pepsi. Each of four people was asked which of two blinded drinks given in random order that they preferred. The data was such that 3 of the 4 people chose Coke. Assuming that this sample is representative, report a P-value for a test of the hypothesis that Coke is preferred to Pepsi using a one sided exact test.

Let <img src="https://render.githubusercontent.com/render/math?math=\p"> be the proportion of people who prefer Coke. Then, we want to test <br><br>
<img src="https://render.githubusercontent.com/render/math?math={H_{0}: \p=0.5}"> with <img src="https://render.githubusercontent.com/render/math?math={H_{a}: \p>0.5}">. <br><br>
Let <img src="https://render.githubusercontent.com/render/math?math=\X"> be the number out of 4 that preferCoke and assume <img src="https://render.githubusercontent.com/render/math?math={\X Binomial(\p ,.5)}">. <br><br>
Then <br><br>
<img src="https://render.githubusercontent.com/render/math?math=\P_{value}=\P(X>=3)=Choose(4,3)0.5^3 0.5^1 %2b Choose(4,4)0.5^4 0.5^0">

```{r}
pbinom(2, size = 4, prob = 0.5, lower.tail = FALSE)
### OR ###
choose(4, 3) * 0.5^4 + choose(4, 4) * 0.5^4
### OR ###
chisq.test(c(3,1),p=c(0.5,0.5))
### OR ###
binom.test(c(3,1),p=0.5, alternative="greater")$p.value
```

## Example 4

Infection rates at a hospital above 1 infection per 100 person days at risk are believed to be too high and are used as a benchmark. A hospital that had previously been above the benchmark recently had 10 infections over the last 1,787 person days at risk. About what is the one sided P-value for the relevant test of whether the hospital is *below* the standard?

We want to test the hypothesis

<img src="https://render.githubusercontent.com/render/math?math=\P_{value}={H_{0} : \lambda=0.01}"> <br><br>
versus <br><br>
<img src="https://render.githubusercontent.com/render/math?math=\P_{value}={H_{a} : \lambda<0.01}"> <br><br>
where <br><br>
<img src="https://render.githubusercontent.com/render/math?math={X=10}"> and <img src="https://render.githubusercontent.com/render/math?math=\P_{value}={t=1787}"> <br><br>
let assume <br><br>
<img src="https://render.githubusercontent.com/render/math?math={X_{H_0} \thicksim Poisson(\lambda.t)}">

```{r}
lambda <- 0.01
t <- 1787
ppois(10,lambda*t)
```

## Example 5

Suppose that 18 obese subjects were randomized, 9 each to a new diet pill and a placebo. Subjects’ body mass indice (BMIs) were measured at a baseline and after having received the treatment or placebo for four weeks. The average difference from followup to the baseline (followup - baseline) was −3kg/m2 for the treated group and 1kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5kg/m2 for the treatment group and 1.8kg/m2 for the placebo group. Does the change in BMI appear to differ between the treated and the placebo groups ? Assuming normality of the underlying data and a common population variance, give a p-value for a two-sided t-test.

Let us call <img src="https://render.githubusercontent.com/render/math?math=\mu_{diff,treated}"> and <img src="https://render.githubusercontent.com/render/math?math=\mu_{diff,placebo}"> the mean values of the difference <img src="https://render.githubusercontent.com/render/math?math=followup - baseline"> for the treated group and the placebo group. The hypothesis <img src="https://render.githubusercontent.com/render/math?math=H_{0}"> is then :
```{r}
n1 <- 9
n2 <- 9
mu1 <- -3 ## mean difference treated
mu2 <- 1 ## mean difference placebo
sd1 <- 1.5 ## standard deviation difference treated
sd2 <- 1.8 ## standard deviation difference placebo
wsd <- sqrt(((n1 - 1) * s1^2 + (n2 - 1) * s2^2)/(n1 + n2 - 2)) ## weighted standard deviation
ts <- (mu1 - mu2)/(wsd * sqrt(1/n1 + 1/n2))
2 * pt(ts, n1 + n2 - 2) ## double quantile function of wsd for two sided test
```

## Example 6

Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of <img src="https://render.githubusercontent.com/render/math?math={H_{0}: \mu =1078}">? <br>

**No, you would fail to reject. The 95% interval would be wider than the 90% interval. Since 1,078 is in the narrower 90% interval, it would also be in the wider 95% interval. Thus, in either case it's in the interval and so you would fail to reject.**

## Example 7

Researchers would like to conduct a study of 100 healthy adults to detect a four year mean brain volume loss of <img src="https://render.githubusercontent.com/render/math?math=.01 mm^3">. Assume that the standard deviation of four year volume loss in this population is <img src="https://render.githubusercontent.com/render/math?math=.04 mm^3">. About what would be the power of the study for a 5% one sided test versus a null hypothesis of no volume loss?

The hypothesis is <img src="https://render.githubusercontent.com/render/math?math=H_{0}: \mu_{\delta}=0"> versus <img src="https://render.githubusercontent.com/render/math?math=H_{0}: \mu_{\delta}>0"> where <img src="https://render.githubusercontent.com/render/math?math=\mu_{\delta}"> is  volume loss (change defined as Baseline - Four Weeks). The test statistics is <img src="https://render.githubusercontent.com/render/math?math={t = \frac{\bar{X}{\sigma \div \sqrt{n}}">. The hypothesis is rejected if <img src="https://render.githubusercontent.com/render/math?math={t > Z_{0.95} = 1.645}"> <br><br>
We want to calculate <br><br>
<img src="https://render.githubusercontent.com/render/math?math={P \lgroup t > 1.645 \bracevert \mu_{diff}=0.01 \rgroup} = {P \lgroup \frac{\bar{X}-0.01}{\sigma \div \sqrt{n}} > 1.645-\frac{0.01}{\sigma \div \sqrt{n}} \bracevert \mu_{diff}=0.01 \rgroup} = {P \lgroup Z > -0.855\rgroup} = 0.80"> <br><br>

```{r}
n <- 100
p <- 1.645
sd <- 0.04
mua <- 0.01
mu0 <- 0 ## no brain volume loss
power.t.test(n=n, delta=mua-mu0, sd=sd, type="one.sample", alternative="one.sided", sig.level=alpha)$power
### OR ###
pnorm(1.645 * sd/sqrt(n), mean = 0.01, sd = sd/sqrt(n), lower.tail = FALSE)
```

## Example 8

Researchers would like to conduct a study of nn healthy adults to detect a four year mean brain volume loss of <img src="https://render.githubusercontent.com/render/math?math=.01 mm^3">. Assume that the standard deviation of four year volume loss in this population is <img src="https://render.githubusercontent.com/render/math?math=.04 mm^3">. About what would be the value of nn needed for 90% power of type one error rate of 5% one sided test versus a null hypothesis of no volume loss?

We want to test the null hypothesis <img src="https://render.githubusercontent.com/render/math?math={H_{0}: \mu_{diff}=0}"> against <img src="https://render.githubusercontent.com/render/math?math={H_{a}: \mu_{diff} \neq 0}"> where <img src="https://render.githubusercontent.com/render/math?math={\mu_{diff}}"> is the brain volume loss. Having the previous question, now we want to have: <br><br>
<img src="https://render.githubusercontent.com/render/math?math={P \lgroup \frac{\bar{X}-0.01}{\sigma \div \sqrt{n}} > 1.645-\frac{0.01}{\sigma \div \sqrt{n}} \bracevert \mu_{diff}=0.01 \rgroup} = {P \lgroup Z > 1.645 - \frac{\sqrt{n}}{4} \rgroup = 0.90}">
<img src="https://render.githubusercontent.com/render/math?math={1.645- \frac{\sqrt{n}}{4} > Z_{0.1} = -1.282}"> <br><br>
So <img src="https://render.githubusercontent.com/render/math?math={n = (4(1.645 + 1.282))^2 = 137.07}">

```{r}
mua <- 0.01
sd <- 0.04
power <- 0.9
alpha <- 0.05
mu0 <- 0
(4 * (qnorm(0.95) - qnorm(0.1)))^2
### OR ###
power.t.test(power=power, delta=mua-mu0, sd=sd, type="one.sample", alt="one.sided", sig.level=alpha)$n
```
## Example 9

As you increase the type one error rate, α, what happens to power?

**When α increases, you get less evidence to reject, so the power increases.**


