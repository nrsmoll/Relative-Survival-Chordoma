
$analysisfolder
use `$tumor'overallsurvtrend, clear
local fup $LCRStimeunit
twoway (line cr_e2 t if end==`fup', ylabel(0(.2)1, format(%9.1f)) xlabel($startingyear(5)$endingyear, nolabels noticks) legend(order(1 "Cumulative Relative Survival" 2 "95% CI") ring(0) pos(2) col(1) size(vsmall)) saving("grapha", replace) title("{bf:Overall}", size(huge)) ytitle("") xtitle("")) (rcap lo_cr_e2 hi_cr_e2 t if end==`fup', lcolor(navy)) (scatter cr_e2 t if end==`fup', msize(vsmall) mcolor(maroon) msymbol(O) )

keep if end==2.5
list t n d cr_e2 lo_cr_e2 hi_cr_e2 

use `$tumor'agecatsurvivaltrend, clear
twoway (line cr_e2 t if $agecat==2 & end==`fup', lcolor(maroon) ylabel(0(.2)1, nolabels noticks) xlabel(1981(5)2006, nolabels noticks) legend(off) saving("graphb", replace) title("{bf:$agecat2}", size(huge) color(maroon)) xtitle("") ytitle("")) (rcap lo_cr_e2 hi_cr_e2 t if $agecat==2 & end==`fup', lcolor(maroon)) (scatter cr_e2 t if $agecat==2 & end==`fup', msize(vsmall) mcolor(maroon) msymbol(O))
twoway (line cr_e2 t if $agecat==3 & end==`fup', ylabel(0(.2)1, format(%9.1f)) xlabel(1981(5)2006, valuelabel) legend(off) saving("graphc", replace) ytitle("") title("{bf:$agecat3}", size(huge) color(gray)) xtitle("")) (rcap lo_cr_e2 hi_cr_e2 t if $agecat==3 & end==`fup', lcolor(gray)) (scatter cr_e2 t if $agecat==3 & end==`fup', msize(vsmall) mcolor(gray) msymbol(O) )
twoway (line cr_e2 t if $agecat==4 & end==`fup', ylabel(0(.2)1, nolabels noticks) xlabel(1981(5)2006, valuelabel) legend(off) saving("graphd", replace) ytitle("")  title("{bf:$agecat4}", size(huge) color(black)) xtitle("")) (rcap lo_cr_e2 hi_cr_e2 t if $agecat==4 & end==`fup', lcolor(black)) (scatter cr_e2 t if $agecat==4 & end==`fup', msize(vsmall) mcolor(black) msymbol(O) )

keep if end==2.5
foreach x of num 2 3 4  {
display "Agecat="`x'
list t n d cr_e2 lo_cr_e2 hi_cr_e2 if agecat==`x'
}

graph combine "grapha" "graphb" "graphc" "graphd", title("")

$figuresfolder
graph export "figure2.eps", as(eps) replace
$descriptivesfolder
exit
