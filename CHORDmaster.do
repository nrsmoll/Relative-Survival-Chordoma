version 11clearcd "/users/nrsmoll/Dropbox/myresearch/CHORD/dofiles"
capture log close
log using "CHORDanalysis", replace
set more off

*_____Macros_____
*Spreadsheet filenames
global tumor CHORD
*Final agecat used
global agecat "agecat"
*Period used for delayed entry analysis. Period is the number of months the interval is when performing longitudinal relative survival analyses
*LCRS = Longitudinal relative survival. Time unit is the interval at which longitudinal relative survival is measured at. Insert two if you want it to measure longitudinal 2 year survival rates.
global early 155
global late 575
global period 60
global window 60
global LCRSearly 240
global LCRSlate 540
global LCRStimeunit 2.5
global startingyear 1981
global endingyear 2007
*Age categories
global children 1
global youngadults 2
global adults 3
global elderly 4
global agecat1 "Children" 
global agecat2 "Young Adults"
global agecat3 "Adults" 
global agecat4 "Elderly"
*Conditional Specifier Descriptive analysis of Period Data
global if _st==1
*Conditional Specifier of survival data - Only fully treated patients
global fulltx rad!=999 
*Dropped Age Categories For Final Analysis
global dropagecat $agecat!=
*Survival analysis command For entire analysis
global globalstset "stset survdatemo, origin(time modx) enter(time "$early") exit(time "$late") id(patientid) failure(lifestatus==2) scale(12)"

*Piecewise constant hazards breakpoints for STRS command
global initial 0
global span 5
global finish 20
*Change directory commands
global spreadsheetfolder cd "/users/nrsmoll/Dropbox/myresearch/$tumor/dofiles/spreadsheet"
global descriptivesfolder cd "/users/nrsmoll/Dropbox/myresearch/$tumor/dofiles/descriptives"
global modelfolder cd "/users/nrsmoll/Dropbox/myresearch/$tumor/dofiles/model"
global analysisfolder cd "/users/nrsmoll/Dropbox/myresearch/$tumor/analysis/"
global tablesfolder cd "/users/nrsmoll/Dropbox/myresearch/$tumor/tables"
global figuresfolder cd "/users/nrsmoll/Dropbox/myresearch/$tumor/figures"

$spreadsheetfolder
quietly {
do 001-dataload
do 002-logic
do 003-sexcategories
do 004-agecategories
do 005-racecategories
do 006-locationcategories
do 007-yydxcategories
do 008-treatmentcategories
do 009-survivalvariables
do 010-polishing
do 011-savingdataset
}

$descriptivesfolder
do 020-settingupdataset
do 021-descriptivetests-table1
do 022-survivaldescriptors
do 023-CRSdescriptors-table2
do 024-figure1
*quietly: do 025-longitudinalCRS
*do 026-LCRS-figure2
do 027-standardizedmortalityratio
do 028-survivalcurves-figure2
do 029-incidence-F

$modelfolder 
do 100-RSmodeldataset
do 101-piecewisemodel
do 102-piecewiseplotting-figure3
do 103-POSTpiecewise
*do 104-curefraction-figure4
*do 105-POSTcurefraction
*do 106-POSTproportionalhazards

*Instructions
*6 Folders are required for this program - 3 for do files, one for analysis, figures and tables.
*This is for the 2006 SEER dataset. The limiting factor is the dates of the expected mortality tables, therefore even though
*there is a 2008 dataset, because of the 2006 limit of the expected mortality tables your data must be right truncated at 2006
*Expected survival file should be named "expectedsurvival.dta", and must be placed in the analysis folder
*Checks:
*Ensure the following race definitions are appropriate and the same for expected mortality calculations and merging: 
*_race: 0 "White" 1 "Black" 2 "Other (American Indian/AK native, Asian/Pacific Islander)" 3 "Other Unspecified (1991+)" 4 "Unknown"


log close
exit


