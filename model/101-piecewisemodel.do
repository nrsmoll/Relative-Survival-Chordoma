*Piecewise constant hazards model
$analysisfolder

use grouped$agecat, clear

*Radiation and Surgery as confounders
*xi: glm d i.end i.rad i.tx i.$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform
*est sto x

*xi: glm d i.end i.rad i.$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform
*est sto y
*lrtest x

*xi: glm d i.end i.$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform
*lrtest y

*___________Final Model___________

xi: glm d end#$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform
est sto a

xi: glm d i.end i.$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform
est sto b
lrtest a

$tablesfolder
estout b using "table3finalmodel.txt", cells("b ci_l ci_u") eform replace
$modelfolder




