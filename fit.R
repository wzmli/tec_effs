library(shellpipes)

dat <- rdsRead()

modAns <- model.frame(new_y ~ age + sex 
	, data =dat
	, na.action = na.exclude
	, drop.unused.levels=TRUE
)

## We can't let R use the terms from this object instead of working it out from the model!
attr(modAns, "terms") <- NULL 


mod <- glm(new_y ~ age + sex
	, family = "binomial"
	, data=modAns
)

print(summary(mod))


mod_full <- glm(new_y ~ age*sex
	, family = "binomial"
	, data=modAns
)


print(summary(mod_full))





