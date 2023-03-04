library(ggplot2);theme_set(theme_bw())
library(shellpipes)

loadEnvironments()

dat <- rdsRead()

gg <- (ggplot(dat, aes(x=lvl, y=fit))
	+ geom_point()
	+ geom_pointrange(aes(ymin=lwr,ymax=upr))
	+ geom_point(aes(y=prop,size=tot),color="red")
	+ scale_size_area()
	+ facet_wrap(~var, scale="free")
	+ ggtitle(formula)
	+ ylab("Probability")
)

print(gg)
