*Dataset creation
$analysisfolder
use $tumor, clear
drop if $agecat==1
stset survdatemo, origin(time modx) enter(time $early) exit(time $late) id(patientid) failure(lifestatus==2) scale(12)
	strs using expectedsurvival, breaks(0(2)10) by($agecat) mergeby(_year sex _age _race) savind(individ$agecat, replace) savgroup(grouped$agecat, replace) notables
$modelfolder


