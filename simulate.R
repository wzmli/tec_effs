library(shellpipes)

## Here we want to create a dummy model object, hack the coefficients and resimulate

intercept <- 1
main_age <- 1
main_sex <- 1
main_interaction <- 1

dummy <- rdsRead()


mod <- glm(y~ age*sex
	, family = "binomial"
	, data = dummy
)

## Hack mod coefs and simulate from model
print(summary(mod))


hackmod <- mod
hackmod$coefficients <- c(intercept,main_age,main_sex,main_interaction)

probs <- (predict(hackmod
	, newdata = dummy
#	, type = "response"
	, type = "response"
#	, terms = c(1,1,1,1)
	)
)

dummy$new_y <- sapply(probs, function(x){rbinom(n=1,size=1,prob=x)})

print(dummy)


