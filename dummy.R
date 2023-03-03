library(dplyr)
library(shellpipes)


loadEnvironments()

## generate a dummy dataset

small <- 250
large <- 750

## randomly scramble the order

dummy <- data.frame(age = rep(c("young","old"),c(small,large))
	, sex = sample(x=rep(c("male","female"),c(small,large)), size=(small+large))
	, y = rbinom(n=(small+large),size=1,prob=0.5)
)

dummy <- as.data.frame(unclass(dummy),stringsAsFactors=TRUE)


rdsSave(dummy)
