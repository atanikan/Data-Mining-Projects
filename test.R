install.packages("doParallel")
require(doParallel)

#gives warning and not in parallel
cl <- makeCluster(2)
registerDoParallel(cl)
foreach(i=1:3) %dopar% sqrt(i)

# runs in parallel
registerDoParallel(cores=4)
foreach(i=1:3) %dopar% sqrt(i)

# Parallel loop
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
ptime <- system.time({
   r <- foreach(icount(trials), .combine=cbind) %dopar% {
   ind <- sample(100, 100, replace=TRUE)
   result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
   coefficients(result1)
   }
  })[3]
ptime


stime <- system.time({
  r <- foreach(icount(trials), .combine=cbind) %do% {
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
   coefficients(result1)
  }
})[3]
stime

# Sequential loop