*Predicting deviance and plotting deviance residuals

xi: glm d i.end ib2.$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform

predict dev, deviance
swilk dev
$figuresfolder
kdensity dev, normal
graph export "POSTESTdevianceplot.eps", as(eps) replace
$modelfolder
