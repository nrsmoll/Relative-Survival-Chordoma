* Treatement Categories

encode reasonnocancerdirectedsurgery, gen(surg)
destring rxsummsurgprimsite1998, gen(surg1) ignore("Blank(s)")
destring sitespecificsurgery19831997, gen(surg2) ignore("Blank(s)")
encode radiation, gen(radiation2)
encode radiationtobrainorcns19881997, gen(radreason)
encode radiationsequencewithsurgery, gen(radseq99)

gen radseq=.
replace radseq=1 if radseq99<4 | radseq99==7
replace radseq=2 if radseq99==6
replace radseq=3 if radseq99==5
replace radseq=4 if radseq99==4
label define radseq 1 "Other" 2 "Prior to Surgery" 3 "Before and After" 4 "Radiation After Surgery"
label value radseq radseq

gen rad=.
replace rad=1 if radiation2==3 | radiation2==7 | radiation2==0
replace rad=2 if radiation2==1 | radiation2==2 | radiation2==5 | radiation2==4 | radiation2==6
replace rad=3 if radiation2==8|radiation2==9
label define rad 1 "None" 2 "Radiation" 3 "Unknown" 
la val rad rad

gen rad2=.
replace rad2=0 if radiation2==3 | radiation2==7 | radiation2==0 | radiation2==8|radiation2==9
replace rad2=1 if radiation2==1 | radiation2==2 | radiation2==5 | radiation2==4 | radiation2==6
label define rad2 0 "None or Unknown" 1 "Radiation" 
la val rad2 rad2

gen tx=.
replace tx=0 if surg!=7
replace tx=1 if surg==7
replace tx=1 if surg1>19 & surg1<=90 
replace tx=1 if surg2>19 & surg2<=90
replace tx=0 if surg1<=19 & surg1>90 
replace tx=0 if surg2<=19 & surg2>90
label define tx 0 "No Surgery or Unknown" 1 "Surgery Performed"
la val tx tx
