*Plotting Observed vs Estimated Values for the piecewise model
$analysisfolder
use grouped$agecat, clear
drop if $agecat==1

xi: glm d i.end i.$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform

predict xb, xb nooffset 
gen r_hat = exp(-exp(xb)*2)
bysort $agecat (end) : g rs_hat = exp(sum(log(r_hat)))

set obs 18
replace end = 0 in 16
replace agecat = 2 in 16
replace rs_hat = 1 in 16
replace end = 0 in 17
replace agecat = 3 in 17
replace rs_hat = 1 in 17
replace end = 0 in 18
replace agecat = 4 in 18
replace rs_hat = 1 in 18
sort end

local y2 $agecat==2
local y3 $agecat==3
local y4 $agecat==4

$figuresfolder
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y2', title(Young Adults, ring(0)) lcolor(black) lwidth(vthin) lpattern(solid)) (scatter cr_e2 end if `y2', msize(mediuml) mcolor(black) msymbol(T)) (line rs_hat end if `y2', lcolor(black) lpattern(solid) legend(off) yti("") xtitle("") xla(none) yscale(range(0 1)) yla(.5 1, format(%12.1fc)) graphregion(margin(0 0 0 0)) saving(parta, replace)) 
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y3', title(Adults, ring(0)) lcolor(black) lwidth(vthin) lpattern(dot))   (scatter cr_e2 end if `y3', msize(medium) mcolor(black) msymbol(X))  (line rs_hat end if `y3', lcolor(black) lpattern(dot) legend(off) yti("") xtitle("") xla(none) yscale(range(0 1)) yla( .5 1, format(%12.1fc)) graphregion(margin(0 0 0 0)) saving(partb, replace))
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y4', title(Elderly, ring(0)) lcolor(black) lwidth(vthin) lpattern(dash))  (scatter cr_e2 end if `y4', msize(medium) mcolor(black) msymbol(O))  (line rs_hat end if `y4', lcolor(black) lpattern(dash) legend(off) yti("") xti("") xla(1(2)10) yscale(range(0 1)) yla(0(.5)1, format(%12.1fc)) graphregion(margin(0 0 0 0)) saving(partc, replace)) 

graph combine "parta" "partb" "partc", col(1) imargin(zero) b1title(Years) l1title(Relative Survival) title(Relative Survival Model)
graph export "figure3.eps", replace as(eps)
$modelfolder
