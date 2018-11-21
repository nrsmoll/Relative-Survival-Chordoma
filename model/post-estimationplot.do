
use $tumor, clear
$globalstset
sts graph if agecat==2, ///
	yline(0.07, lpattern(dash) lwidth(vvthin)) xtitle("Years") ytitle("Survivor Function") ///
	 title("") tmax(10) legend(order(1 "Young Adults" 2 "Adults" 3 "Elderly"))  ///
	 addplot(function y=exp(ln(.069)*(1-exp(-0.3959245*x^1.088311))), range(0 10))

twoway function y=exp(ln(.069)*(1-exp(-0.3959245*x^1.088311))), range(0 10) 
twoway function y=0.069^(1-exp((-1.948902)*x^0.4684)), range(0 10) 
