## https://github.com/wzmli/tec_effs.git
current: target
-include target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt README.md"

######################################################################

Sources += $(wildcard *.R) README.md 

######################################################################

## Functions for ordinal variables
ordfuns.Rout: ordfuns.R
	$(pipeR)

dummy.Rout: dummy.R
	$(pipeR)

simulate.Rout: simulate.R dummy.rds
	$(pipeR)

main.Rout: main.R
	$(pipeR)

full.Rout: full.R
	$(pipeR)

## main.fit.Rout: fit.R
## full.fit.Rout: fit.R
pipeRimplicit += fit
%.fit.Rout: fit.R simulate.rds %.rda
	$(pipeR)

pipeRimplicit += lin.R
## full.lin.fit.Rout: 
%.lin.fit.Rout: lin.R simulate.rds %.rda
	$(pipeR)

## main.varpred.Rout: varpred.R
## full.lin.varpred.Rout: 
pipeRimplicit += varpred
%.varpred.Rout: varpred.R ordfuns.rda %.fit.rda 
	$(pipeR)

## full.lin.effplot.Rout: effplot.R
## main.lin.effplot.Rout: effplot.R
## main.effplot.Rout: effplot.R
## full.effplot.Rout: effplot.R
pipeRimplicit += effplot
%.effplot.Rout: effplot.R %.varpred.rds
	$(pipeR)

######################################################################

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls makestuff/Makefile

-include makestuff/os.mk

-include makestuff/pandoc.mk
-include makestuff/pipeR.mk
-include makestuff/chains.mk

-include makestuff/git.mk
-include makestuff/visual.mk
