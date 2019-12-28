*==============================================================================*
*1. Change variable name (name=string+number)
*Example: Transform variables constr2-constr16 to constr1-constr15, respectively
*==============================================================================*
local constr2-constr16
forv q=2/16{     //transform constr2 to constr1 --> q-1 
	foreach var of varlist constr`q'{
		local e=`q'-1
		rename constr`q' constra`e'
		tab constra`e'	
	}
} 

*==============================================================================*
*2. Keep/Drop character(s) within a variable name (string type): Use substr command. 
*Example1: Drop 1 character and rename q137b_01 to q137b_1 and apply for q137b_01-q137b_09. 
*==============================================================================*
use sme2005_distributionOK.dta, clear 
foreach var of varlist q137b_01-q137b_09{
	replace `var'=. if `var'>3
	local newvar = substr("`var'", 1, length("`var'")-2) + substr("`var'", -1, 1)
	rename `var' `newvar'
}

*==============================================================================*
*2. Keep/Drop character(s) within a variable name (string type): Use substr command. 
*Example2: Keep characters and rename industry variables
*==============================================================================*
use sme2005_distributionOK.dta, clear 
tostring isic, gen(str_isic) 
gen industry=substr(str_isic,1, length(str_isic)-2)
destring industry, replace 
display "sector based on industry" 
gen str1 sector = " "
replace sector = "A" if industry<=5 //A: Agriculture and Fishing
replace sector = "C" if industry>=10 & industry<=14 //C: Mining and quarrying
replace sector = "D" if industry>=15 & industry<=37 //D: Manufacturing
replace sector = "E" if industry>=40 & industry<=41 //E: Electricity
replace sector = "F" if industry==45  //F: Construction
replace sector = "G" if industry>=50 & industry<=52 //G: Wholesale, retail
replace sector = "H" if industry==55 //H: Hotel & restaurant
replace sector = "I" if industry>=60 & industry<=64 //I: Transport, communications 
replace sector = "J" if industry>=65 & industry<=67 //J: Financial intermediation  
replace sector = "K" if industry>=70 & industry<=74 //K: Real estates, business activities
replace sector = "L" if industry==75 //L: Admin, defense
replace sector = "M" if industry==80  //M: Education
replace sector = "N" if industry==85  //N: Health and social work
replace sector = "O" if industry>=90 & industry<=93 //O: social services
replace sector = "P" if industry>=95 & industry<=97 //P: Private household activities
replace sector = "Q" if industry==99 //Q: Extraterritorial organisations 

gen str20 sectormain = " "
replace sectormain="Agri" if sector =="A"
replace sectormain="Mining,construction" if sector=="C" |sector=="F"
replace sectormain="Manufacturing" if sector=="D"
replace sectormain="Electricity" if sector=="E"
replace sectormain="Wholesale" if sector=="G"
replace sectormain="Other services" if sector=="H" | sector=="L" | sector=="M" | sector=="N" | sector=="O" 
replace sectormain="Other" if sector=="P" | sector=="Q"
