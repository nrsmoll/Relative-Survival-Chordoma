*figure1 - Chordoma

$analysisfolder
use $tumor, clear
*quietly {
$globalstset
*sts graph, by($agecat) title("A", ring(0)) ytitle(Overall Survival) xtitle(Years) ///
*	risktable(,group(1) rowtitle("$agecat1    ") size(small) color(black)) ///
*	risktable(,group(2) rowtitle("$agecat2    ") size(small) color(maroon)) ///
*	tmax(20) xlabel(0 2.5 5(5)20) saving(figure1parta, replace) legend(off) plot1opts(lcolor(black)) plot2opts(lcolor(maroon)) ///

*use CRS$tumor if end<=20, clear
*graph twoway  (line cr_e2_$young end, lcolor(gold) connect(stairstep) title("B", ring(0)) ) ///
*	(line cr_e2_$old end, xlabel(0(5)20) ytitle("Cumulative Relative Survival") xtitle(Years) connect(stairstep) /// 
*	ylabel(0 "0" .25 "0.25" .5 "0.5" .75 "0.75" 1 "1" ) ///
*	yline(0.0, lcolor(gs14)) ///
*	yline(.25, lcolor(gs14)) ///
*	yline(.50, lcolor(gs14)) ///
*	yline(.75, lcolor(gs14)) ///
*	yline(1.00, lcolor(gs14)) ///
*	legend(order(1 "$agecat1" 2 "$agecat2")  col(2) pos(6) bmargin(t=4)) lcolor(maroon) saving(figure1partb, replace)) ///
*	(line cr_e2_$young end, lcolor(black) connect(stairstep)) ///
*	(line cr_e2_$old end, lcolor(maroon) connect(stairstep)) 
*graph combine "figure1parta" "figure1partb"


*figure1BW

$analysisfolder
use $tumor, clear

$globalstset
sts graph, by($agecat) title("A", ring(0)) ytitle(Overall Survival) xtitle(Years) ///
	risktable(,group(1) rowtitle("$agecat1    ") size(small) ) ///
	risktable(,group(2) rowtitle("$agecat2    ") size(small) ) ///
	risktable(,group(3) rowtitle("$agecat3    ") size(small) ) ///
	risktable(,group(4) rowtitle("$agecat4    ") size(small) ) ///
	tmax(20) xlabel(0 2.5 5(5)20) saving(figure1parta, replace) legend(off) plot1opts(lpattern(-) lcolor(black)) plot2opts(lpattern(solid) lcolor(black)) plot3opts(lpattern(dot) lcolor(black)) plot4opts(lpattern(_.) lcolor(black)) ///


use CRS$tumor if end<=20, clear
graph twoway  (line cr_e2_$children end, lcolor(black) lpattern(-) connect(stairstep) title("B", ring(0)) ) ///
	(line cr_e2_$youngadults end, lpattern(solid) xlabel(0(5)20) ytitle("Relative Survival") xtitle(Years) connect(stairstep) /// 
	ylabel(0 "0" .25 "0.25" .5 "0.5" .75 "0.75" 1 "1" ) ///
	yline(0.0, lcolor(gs14)) ///
	yline(.25, lcolor(gs14)) ///
	yline(.50, lcolor(gs14)) ///
	yline(.75, lcolor(gs14)) ///
	yline(1.00, lcolor(gs14)) ///
	legend(order(1 "$agecat1" 2 "$agecat2" 3 "$agecat3" 4 "$agecat4")  col(2) pos(6) bmargin(t=4)) lcolor(black)  saving(figure1partb, replace)) ///
	(line cr_e2_$adults end, lcolor(black) lpattern(dot) connect(stairstep)) ///
	(line cr_e2_$elderly end, lcolor(black) lpattern(_.) connect(stairstep))
	
graph combine "figure1parta" "figure1partb"

$figuresfolder
graph export "figure2.eps", as(eps) replace
$descriptivesfolder


