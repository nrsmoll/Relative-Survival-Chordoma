*descriptive tests 
$analysisfolder
use $tumor, clear
*bootstrap median=r(p50), reps(200): sum age `if', detail
*bootstrap LIQR=r(p25), reps(200): sum age `if', detail
*bootstrap UIQR=r(p75), reps(200): sum age `if', detail
*bootstrap diff=(r(p75)-r(p25)), reps(200): sum age `if', detail

sum age
tab $agecat

$globalstset
tab sex $agecat, col chi2
tab yrdx $agecat, col chi2
tab rad2 $agecat, col chi2
logistic rad2 ib2.$agecat, or
logistic tx ib4.$agecat, or
tab tx $agecat, col chi2


$tablesfolder
tabout sex yrdx rad2 tx $agecat using table1.csv if $if, replace c(freq col) lines(none) clab(No. % No. %) f(0 0p 0 0p 0 0p) style(csv) layout(No. % No. %) h3(nil)
$descriptivesfolder
