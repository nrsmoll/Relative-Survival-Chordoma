*Creation of Relative Survival datasets
$analysisfolder

forvalues x = 1/4 {
	use $tumor if $agecat==`x', clear
	$globalstset
	strs using expectedsurvival, breaks(0(1)20) mergeby(_year sex _age _race) savind(individ`x', replace) savgroup(grouped`x', replace) notables
	use grouped`x', clear
	renames start end n d d_star ns w n_prime y p se_p lo_p p_star r se_r lo_r hi_r cp se_cp lo_cp hi_cp cp_e2 cr_e2 lo_cr_e2 hi_cr_e2 nu, suffix(_`x')
	gen end=end_`x'
	save grouped`x', replace
}


use $tumor, clear
$globalstset
strs using expectedsurvival, breaks(0(1)20) mergeby(_year sex _age _race) savind(individ, replace) savgroup(grouped, replace) 
use grouped, clear

forvalues x = 1/4 {
	merge 1:1 end using grouped`x'
	drop _merge
	}

save CRS$tumor, replace

use CRS$tumor, clear
keep if end==1 | end==2 | end==5 | end==10 | end==15 | end==20

forvalues x = 1/4 {
drop n_`x' d_`x' d_star_`x' ns_`x' w_`x' n_prime_`x' y_`x' p_`x' se_p_`x' lo_p_`x' p_star_`x' r_`x' se_r_`x' lo_r_`x' hi_r_`x' cp_`x' se_cp_`x' lo_cp_`x' hi_cp_`x' cp_e2_`x'
}

drop cr_e2 lo_cr_e2 hi_cr_e2 y p se_p lo_p p_star r se_r lo_r hi_r cp se_cp lo_cp hi_cp cp_e2


$tablesfolder
outsheet using "table2.csv", comma replace
$analysisfolder


use $tumor, clear
$globalstset
strs using expectedsurvival, breaks(0 1 5 10 15 20) mergeby(_year sex _age _race) savind(individ, replace) savgroup(grouped, replace) 

*strs using expectedsurvival [iw=agecatwei], standstrata($agecat) breaks(0 1 5 10 15 20) mergeby(_year sex _age _race) savind(individ, replace) savgroup(grouped, replace) 



use CRS$tumor, clear
list end cr_e2_1 lo_cr_e2_1 hi_cr_e2_1 cr_e2_2 lo_cr_e2_2 hi_cr_e2_2 if end==1 | end==5 | end==10 | end==15 | end==20

use $tumor, clear
$globalstset
strs using expectedsurvival, breaks(0 1 5 10 15 20) mergeby(_year sex _age _race) by(sex) savind(individsex, replace) savgroup(groupedsex, replace) 
use grouped, clear




use $tumor, clear
*Main analysis
$globalstset
stsum
stsum, by($agecat)
stdescribe
sts list, at(.25 .5 1 2 2.5 2.75 5 10 15 20)
sts list, at(.25 .5 1 2 2.5 2.75 5 10 15 20) by($agecat)

$descriptivesfolder







