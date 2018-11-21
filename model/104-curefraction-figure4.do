*curefraction and figure 3
$analysisfolder

*Modelling
use `$tumor'individmodel if $agecat==2, clear

xi:strsnmix i.$agecat,  distribution(weibull) bhazard(d_star) link(loglog) nolog

xi:strsnmix i.$agecat,  distribution(weibull) bhazard(d_star) link(identity) nolog

predict s, surv 
predict h, haz
predict s_uncured, survival uncured
predict h_uncured, hazard uncured
predict cure, cure 
predict median, centile

predict curetime, centile centval(.01)
bysort $agecat: gen first = _n == 1
tabdisp $agecat if first, c(cure median curetime) f(%5.3fc)

predict curetime2, centile centval(.001)
bysort $agecat: gen first2 = _n == 1
tabdisp $agecat if first2, c(cure median curetime2) f(%5.3fc)

sts graph if $agecat==2, tmax(10) title("") plotopts(lpattern(-)) ///
	text(.10 2 "Cure Fraction = 12%", size(vsmall)) yline(0.12, lpattern(dash) lwidth(vvthin)) ///
	ytitle("Survivor Function") legend(off) xtitle("") xlabel("", grid gmax)  ///
	addplot((line s _t if $agecat==2 & _t<=10, sort ylabel(0 .25 .50 .75 1.00)))  title("A", ring(0))
graph save "figure2CUREa", replace
*risktable risktable(, failevents size(small) color(maroon) rowtitle("Young Adults", color(maroon)) title("At Risk (Failed)", size(small)))

sts graph if $agecat!=1, by($agecat) tmax(10) hazard ylabel(0 .25 .50 .75 1.00) addplot((line h _t if $agecat==2 & _t<10, by($agecat) sort xscale(range(0(1)10)) legend(off))) ytitle("Hazard Rate") xtitle("Time") ///
	plot1opt(lpattern(-)) yscale(range(0(.25)1.5)) ylabel(0 .5 1.00)  fysize(25)  title("B", ring(0))
graph save "figure2CUREb", replace
graph combine "figure2CUREa" "figure2CUREb", col(1) imargin(0 0 0 0) graphregion(margin(l=22 r=22))
$figuresfolder
graph export "figure2CURE.eps", replace as(eps)
$modelfolder



