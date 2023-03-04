library(shellpipes)
loadEnvironments()

dat <- rdsRead()

modAns <- model.frame(formula
	, data =dat
	, na.action = na.exclude
	, drop.unused.levels=TRUE
)

## We can't let R use the terms from this object instead of working it out from the model!
attr(modAns, "terms") <- NULL 


mod <- glm(formula
	, family = "binomial"
	, data=modAns
)

print(summary(mod))

saveVars(modAns, mod)




