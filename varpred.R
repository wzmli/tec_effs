library(ordinal)
library(tidyverse)
library(shellpipes)

loadEnvironments()

predname <- c("age", "sex")

Smat <- BSmat(mod)

lvardat <- lapply(predname,function(x){tidyvarpred(mod,x,modAns,Smat)})

agedat <- (modAns
	%>% group_by(age)
	%>% summarise(prop = mean(new_y)
		, tot = n()
		)
	%>% rename(lvl = age)
)

sexdat <- (modAns
	%>% group_by(sex)
	%>% summarise(prop = mean(new_y)
		, tot = n()
		)
	%>% rename(lvl = sex)
)

obsdat <- bind_rows(agedat, sexdat)

tidyvardat <- (bind_rows(lvardat)
	%>% left_join(.,obsdat)
)

rdsSave(tidyvardat)

