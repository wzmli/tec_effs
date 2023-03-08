library(tidyverse);theme_set(theme_bw())
library(shellpipes)

## Here we want to create a dummy model object, hack the coefficients and resimulate

intercept <- 1
main_age <- 1
main_sex <- -1
main_interaction <- -1

dummy <- rdsRead()

mod <- glm(y~ age*sex
	, family = "binomial"
	, data = dummy
)
print(summary(mod))

## Hack mod coefs and simulate from model

hackmod <- mod
hackmod$coefficients <- c(intercept,main_age,main_sex,main_interaction)

probs <- (predict(hackmod
	, newdata = dummy
	, type = "response"
#	, terms = c(1,1,1,1)
))

dummy$new_y <- sapply(probs, function(x){rbinom(n=1,size=1,prob=x)})

obsprop <- (dummy
	%>% group_by(age,sex)
	%>% summarise(prop = mean(new_y)
		, tot = n()
	)
)

(ggplot(obsprop, aes(x=age,y=prop,group=sex, color=sex))
	+ geom_point(aes(size=tot))
	+ geom_line()
	+ scale_size_area()
	+ scale_color_manual(values=c("black","red"))
)

rdsSave(left_join(dummy,obsprop))
