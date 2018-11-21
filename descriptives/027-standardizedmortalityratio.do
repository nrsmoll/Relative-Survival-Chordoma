$analysisfolder

*SMR of overall patients:
use grouped, clear
collapse (sum) obs=d exp=d_star 
gen LL=( 0.5*invchi2(2*obs, 0.025)) /exp
gen UL=( 0.5*invchi2(2*(obs+1), 0.975)) /exp
gen smr=obs/exp
list obs exp smr LL UL

use grouped`$agecat', clear
*SMR of individual age groups
forvalues x = 1/4 {
use grouped`x', clear
	collapse (sum) obs=d_`x' exp=d_star 
	gen LL=( 0.5*invchi2(2*obs, 0.025)) /exp
	gen UL=( 0.5*invchi2(2*(obs+1), 0.975)) /exp
	gen smr=obs/exp
	list obs exp smr LL UL
}

$descriptivesfolder


