# Example of dices probabilities

## Fair dice
dice_fair <- c(1/6,1/6,1/6,1/6,1/6,1/6)
## Loaded dice high no.
dice_high <- c(1/21,2/21,3/21,4/21,5/21,6/21)
## Loaded dice low no.
dice_low <- c(6/21,5/21,4/21,3/21,2/21,1/21)

## Calculate the probability mass function out of all the singular probabilities
expect_dice <- function(pmf){ mu <- 0; for (i in 1:lenght(x) mu <- mu + i*pmf[i]; mu}
