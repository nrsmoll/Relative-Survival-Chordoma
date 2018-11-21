$analysisfolder
*Cleaning

quietly {insheet using "chordageincidence.txt", tab clear

encode agerecodewith1yearolds, gen(age19cat) 
rename sex SEX
encode SEX, gen(sex)
destring ageadjustedrate, gen(Rate) ignore("~")
destring lowerconfidenceinterval, gen(LoCI) ignore("~")
destring upperconfidenceinterval, gen(UpCI) ignore("~")
destring standarderror, gen(SE) ignore("~")
gen loCI=LoCI*10
gen upCI=UpCI*10
gen rate=Rate*10

drop agerecodewith1yearolds ageadjustedrate lowerconfidenceinterval standarderror upperconfidenceinterval
drop if age19cat==20
}
*Analysis
tsset sex age19cat
tssmooth ma Fsrate=rate if sex==1, window(4 1 4)
format Fsrate %12.0f 
tssmooth ma FsloCI=loCI if sex==1, window(4 1 4)
tssmooth ma FsupCI=upCI if sex==1, window(4 1 4)
tssmooth ma Msrate=rate if sex==2, window(4 1 4)
format Msrate %12.0f 
tssmooth ma MsloCI=loCI if sex==2, window(4 1 4)
tssmooth ma MsupCI=upCI if sex==2, window(4 1 4)

twoway (line Fsrate age19cat if sex==1, sort color(gs12) legend(order(2 "Females Smoothed Rate" 4 "Males Smoothed Rate") size(small)) xtitle("") ytitle("Age-adjusted Rate per 10 million Population", size(small)) xlabel(1(5)20, valuelabel) saving(ageincidence, replace))  /// 
	(scatter Fsrate age19cat  if sex==1, msymbol(o) msize(small) color(gs2) mlabel(Fsrate)  mlabposition(5)  mlabsize(small) sort) ///
	(line Msrate age19cat if sex==2, sort color(gs12) ) ///
	(scatter Msrate age19cat if sex==2, msymbol(X) msize(small) color(gs2) mlabel(Msrate)  mlabposition(11) mlabsize(small) sort) 

$figuresfolder
graph export "figure1incidence.eps", replace as(eps)
$analysisfolder
save chordAGE, replace



$incidencefolder

