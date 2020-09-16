library(matlib)

## Assigning a a matrix to a list of functions:
## set <- set the value of the matrix
## get <- get the value of the matrix
## setinverse <- set the value of the inv(matrix)
## getinverse <- get the value of the inv(matrix)

makeCacheMatrix <- function(x = matrix(1:4, 2,2)) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(inv) m <<- inv(x)
    getinverse <- function(inv) m
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

## Assign a function that calculates the inverse of the special "matrix" created with makeCacheMatrix() function.
## It first checks to see if the inverse has already been calculated. 
## If so, it gets the inverse from the cache and skips the computation. 
## Otherwise, it calculates the inverse of the data and sets the value of the inverse in the cache via the setinversion function.

cacheSolve <- function(x, ...) {
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- inv(data, ...)
    x$setinverse(m)
    m
}

x <- makeCacheMatrix(matrix(c(1,2,3,4),2,2))

## cacheSolve(x) == x$getinverse(m)

cacheSolve(x)
x$getinverse(m)

