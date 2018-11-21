*Survival Variables

encode seercausespecificdeathclassifica, gen(seervitalstatus)
encode vitalstatusrecodestudycutoffused, gen(lifestatus)

gen survmo=survivaltimerecodetotalofmonths
gen yydx=yearofdiagnosis
format yydx %ty
gen modx=mofd(dofy(yydx))
format modx %tm
gen survdatemo=modx+survmo
format survdatemo %tm

gen survyear=survivaltimerecodeyear
gen survdate=survyear+yydx
format survdate %ty
gen exityear=survyear+yydx
format exityear %ty


*dthaz variables - To be used if dthaz is part of analysis
gen v2=.
replace v2=0 if seervitalstatus==1
replace v2=1 if seervitalstatus==2
