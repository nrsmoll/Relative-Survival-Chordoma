*Polishing Dataset

order patientid agecat sex yrdx race tx rad rad2 radseq seervitalstatus lifestatus reasonnocancerdirectedsurgery
drop survivaltimerecodetotalofmonths radiationsequencewithsurgery ageatdiagnosis ///
	behaviorcodeicdo31973 sitespecificsurgery19831997 racerecodewhiteblackother maritalstatusatdiagnosis grade ///
	radiationsequencewithsurgery reasonnocancerdirectedsurgery diagnosticconfirmation rxsummsurgprimsite1998 ///
	survivaltimerecodetotalofmonths survivaltimerecodemonth vitalstatusrecodestudycutoffused radiationtobrainorcns19881997 cstumorsize2004-csextension2004 ///
	seercausespecificdeathclassification vitalstatusrecodestudycutoffused laterality1973 typeoffollowupexpected
drop eod10extent19882003 radiation cssitespecificfactor12004 cssitespecificfactor22004 firstmalignantprimaryindicator surg1 surg2 ///
	cssitespecificfactor32004 cssitespecificfactor42004 cssitespecificfactor52004 typeofreportingsource ///
	cssitespecificfactor62004 eod10extent19882003 eod10size19882003 eod4extent19831987 eod4size19831987
