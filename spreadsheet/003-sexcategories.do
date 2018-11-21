*Sex Categories

encode sex, gen(sx)
drop sex
gen sex=.
replace sex=1 if sx==2
replace sex=2 if sx==1
label define sex 1 "Male" 2 "Female"
label value sex sex
drop sx
