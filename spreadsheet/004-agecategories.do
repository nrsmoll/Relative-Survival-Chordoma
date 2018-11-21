*Age Categories

gen age=ageatdiagnosis

*Official Categories of the Young Adult Oncology Progress Review Group's Age Criteria
gen agecat=.
replace agecat=1 if age<15
replace agecat=2 if age>=15 & age<=39
replace agecat=3 if age>=40 & age<=64
replace agecat=4 if age>=65
label define agecat 1 "Children" 2 "Young Adults" 3 "Adults" 4 "Elderly"
la val agecat agecat

gen age2cat=.
replace age2cat=1 if age<40
replace age2cat=2 if age>=40
label define age2cat 1 "Young" 2 "Old"
la val age2cat age2cat

gen age5cat=.
replace age5cat=1 if age<3
replace age5cat=2 if age<15 & age>=3
replace age5cat=3 if age>=15 & age<=49
replace age5cat=4 if age>=50 & age<=64
replace age5cat=5 if age>=65
label define age5cat 1 "Toddlers/Infants" 2 "Children" 3 "Young Adults" 4 "Adults" 5 "Elderly"
la val age5cat age5cat

gen age6cat=.
replace age6cat=1 if ageatdiagnosis<15
replace age6cat=2 if ageatdiagnosis>=15 & ageatdiagnosis<30
replace age6cat=3 if ageatdiagnosis>=30 & ageatdiagnosis<45
replace age6cat=4 if ageatdiagnosis>=45 & ageatdiagnosis<60
replace age6cat=5 if ageatdiagnosis>=60 & ageatdiagnosis<75
replace age6cat=6 if ageatdiagnosis>=75
label define age6cat 1 "<15yrs" 2 "15-29yrs" 3 "30-44yrs" 4 "45-59yrs" 5 "60-75yrs" 6 ">75yrs"
la val age6cat age6cat

gen age7cat=.
replace age7cat=1 if ageatdiagnosis<3
replace age7cat=2 if ageatdiagnosis>2 & ageatdiagnosis<15
replace age7cat=3 if ageatdiagnosis>=15 & ageatdiagnosis<30
replace age7cat=4 if ageatdiagnosis>=30 & ageatdiagnosis<45
replace age7cat=5 if ageatdiagnosis>=45 & ageatdiagnosis<60
replace age7cat=6 if ageatdiagnosis>=60 & ageatdiagnosis<75
replace age7cat=7 if ageatdiagnosis>=75
label define age7cat 1 "<3yrs" 2 "<15yrs" 3 "15-29yrs" 4 "30-44yrs" 5 "45-59yrs" 6 "60-75yrs" 7 ">75yrs"
la val age7cat age7cat

*Used for tumors with heavy pediatric loading
gen pedages=.
replace pedages=0 if age<2
replace pedages=1 if age>1 & age<10
replace pedages=2 if age>=10 & age<=19
replace pedages=3 if age>=20
label define pedages 0 "<2yr" 1 "2-9yrs" 2 "10-19yrs" 3 "Adults"
label val pedages pedages


*Age category wwieghting for age standardization of survival
tab $agecat
local rtot `r(N)'
tab $agecat if $agecat==1
local r1 = `r(N)'/`rtot'
tab $agecat if $agecat==2
local r2 = `r(N)'/`rtot'
recode $agecat 1=`r1' 2=`r2', gen(agecatwei)
