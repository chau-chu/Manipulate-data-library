*==============================================================================*
*1. Drop 1 character in a variable name (string type): Use substr command. 
*E.g. Rename q137b_01 to q137b_1 and apply for q137b_01-q137b_09. 
*==============================================================================*

*cd M:\vietnam\2016   // If you download files to your folders, make sure you change this directory path.
use sme2005_distributionOK.dta, clear 
foreach var of varlist q137b_01-q137b_09{
	replace `var'=. if `var'>3
	local newvar = substr("`var'", 1, length("`var'")-2) + substr("`var'", -1, 1)
	rename `var' `newvar'
}

*==============================================================================*
*2. Change variable name (name=string+number)
*E.g. Transform variables constr2-constr16 to constr1-constr15, respectively
*==============================================================================*
local constr2-constr16
forv q=2/16{     //transform constr2 to constr1 --> q-1 
	foreach var of varlist constr`q'{
		local e=`q'-1
		rename constr`q' constra`e'
		recode constra`e'(1=3)(2=2)(3=1),gen(constr`e')
		tab constr`e'	
	}
} 

