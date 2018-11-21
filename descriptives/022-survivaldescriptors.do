*survival figures

$analysisfolder
*conditional survival figures for period data (delayed entry) - Note $globalstset sets time data so it is in years.

*Descriptors for interest
use $tumor, clear
$globalstset

*Main analysis
$globalstset
stsum
stsum, by($agecat)

stdescribe
sts list, at(.25 .5 1 2 2.5 2.75 5 10 15 20)
sts list, at(.25 .5 1 2 2.5 2.75 5 10 15 20) by($agecat)
sts test $agecat
$descriptivesfolder



