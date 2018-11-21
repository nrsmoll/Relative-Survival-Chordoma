$analysisfolder

use $tumor, clear
foreach enter of numlist $LCRSearly($period)$LCRSlate {
	local individ individ`enter'
	local grouped grouped`enter'
	local exit = `enter'+$window
	stset survdatemo, origin(time modx) enter(time `enter') exit(time `exit')  id(patientid) failure(lifestatus==2) scale(12) noshow
	strs using expectedsurvival, breaks($initial($span)$finish) mergeby(_year sex _age _race) savind(`individ', replace) savgroup(`grouped', replace) notables                           
}

clear
foreach file of numlist $LCRSearly($period)$LCRSlate {
	local filename grouped`file'
	append using grouped`file', generate(a`file')
	
}

gen t=.
forvalues datemo = $LCRSearly($period)$LCRSlate {
	local filename grouped`file'
	local yr = ((`datemo'-$LCRSearly)/$period)+$startingyear
	replace t=`yr' if a`datemo'==1
}

foreach file of numlist $LCRSearly($period)$LCRSlate {
	local filename grouped`file'
	erase "grouped`file'.dta"
	erase "individ`file'.dta"
}

save `$tumor'overallsurvtrend, replace



*_______________By Agegroup_____________________________________

use $tumor, clear

foreach enter of numlist $LCRSearly($period)$LCRSlate {
	local individ individagecat`enter'
	local grouped groupedagecat`enter'
	local exit = `enter'+$window
	stset survdatemo, origin(time modx) exit(time `exit') enter(time `enter') id(patientid) failure(lifestatus==2) scale(12) noshow
	strs using expectedsurvival, breaks(0(.25)10) mergeby(_year sex _age _race) by($agecat) savind(`individ', replace) savgroup(`grouped', replace)  notables                           
}
clear
foreach file of numlist $LCRSearly($period)$LCRSlate {
	local filename groupedCRSagecat`file'
	append using groupedagecat`file', generate(a`file')
}

gen t=.
forvalues datemo = $LCRSearly($period)$LCRSlate {
	local filename groupedCRSagecat`file'
	local yr = ((`datemo'-$LCRSearly)/$period)+$startingyear
	replace t=`yr' if a`datemo'==1
}

foreach file of numlist $LCRSearly($period)$LCRSlate {
	local grouped`file'
	erase "groupedagecat`file'.dta"
	erase "individagecat`file'.dta"
}

save `$tumor'agecatsurvivaltrend, replace
$descriptivesfolder

