$analysisfolder

use $tumor, clear
$globalstset

sts, by(sex) plot1opts(lpattern(-)) plot2opts(lpattern(solid)) legend(order(1 "Male" 2 "Female")  row(1)) title("Sex", ring(0)) xtitle(Years) ytitle(Survivor Function) risktable
sts if race!=3 & race!=4, by(race) plot1opts(lpattern(-)) plot2opts(lpattern(.-.)) plot3opts(lpattern(solid)) legend(order(1 "Black" 2 "Other" 3 "White")  row(1)) title("Race", ring(0)) xtitle(Years) ytitle(Survivor Function) risktable
sts, by(tx) risktable
sts if rad!=3, by(rad) plot1opts(lpattern(-)) plot2opts(lpattern(solid)) legend(order(1 "No Radiation" 2 "Radiation")  row(1)) title("Radiation Treatment", ring(0)) xtitle(Years) ytitle(Survivor Function) risktable

$descriptivesfolder


