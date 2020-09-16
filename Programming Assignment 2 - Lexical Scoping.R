library(matlib)

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
cacheSolve(x)
x$getinverse(m)

