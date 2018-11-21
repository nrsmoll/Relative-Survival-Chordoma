

$figuresfolder



weibullfit h_uncured if $agecat==2, cluster(patientid)
qweibull h_uncured if $agecat==2, title(Q-Q Plot) subtitle(Data vs Fitted Weibull Distribution) grid 
graph export "POSTqqplot.eps", replace as(eps)






$modelfolder
