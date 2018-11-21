*Race Categories
encode racerecodewhiteblackother, gen(race)
label define racere 5 "White" 1 "Black" 2 "Other (American Indian/AK native, Asian/Pacific Islander)" 3 "Other Unspecified (1991+)" 4 "Unknown"
la val race racere

*Important for use in relative survival regression
gen _race=.
replace _race=0 if race==5
replace _race=1 if race==1
replace _race=2 if race==2
replace _race=3 if race==3
replace _race=4 if race==4
label define _race 0 "White" 1 "Black" 2 "Other (American Indian/AK native, Asian/Pacific Islander)" 3 "Other Unspecified (1991+)" 4 "Unknown"
label value _race _race
