$analysisfolder
use `$tumor'individmodel, clear
sts graph if $agecat!=1, hazard by($agecat) tmax(5) ytitle("Hazard Function") xtitle("Time")
graph export "POSTproportionalhazards.eps", replace as(eps)
