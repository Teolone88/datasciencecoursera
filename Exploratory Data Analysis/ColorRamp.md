## Example with color palette
```{r]
p1 <- colorRampPalette(c("red","blue"))
```
## Example with color names accessible using `colors()`
```{r]
p2 <- colorRamp(c("red","blue"))
```
## Nicely grouped sets of colors are also available with the `RColorBrewer Package`
![unchanged image](Assets/Brewer.jpg)


## Function to return image with color scaling (cv = color vector)
```{r]
showMe <- function(cv){
  myarg <- deparse(substitute(cv))
  z<- outer( 1:20,1:20, "+")
  obj<- list( x=1:20,y=1:20,z=z )
  image(obj, col=cv, main=myarg  )
}
```