## Variables
x <- c("a","b","c","d")
y <- matrix(1:6,2,3)
count <- 0
z <- 5

## Loops
for (i in seq_along(x)) {
  print(i)
}
for(i in seq_along(nrow(y))) {
  for(j in seq_along(ncol(y))) {
    print(y)
  }
}
while(count <10) {
  print(count)
  count <- count +1
}
while(z >=3 && z < 10) {
  coin <- rbinom(1,1,0.5)
  if(coin == 1) {
    z <- z + 1
  } else {
    z <- z - 1
  }
  print(z)  
}

## Functions
add2 <- function(x,y) {
  x+y
}
above10 <- function(x,n) {
  use <- x > n
  x[use]
}
columnmean <- function(y) {
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc) {
    means[i] <- mean(y[,i], na.rm = TRUE)
  }
  means
}