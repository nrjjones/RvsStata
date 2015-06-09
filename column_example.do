
**** Place before loop; 

* Initialize excel sheet; 


local results = "$JNLGWS/table_test1.xls";
putexcel set "`results'", replace;

putexcel 
	A1=("Country")
	B1=("bp")
	C1=("pa")
	D1=("dead")
	E1=("div")
	F1=("pmig")
	G1=("pimg")
	H1=("pdmg")
	I1=("mmg")
	J1=("fmg")
	K1=("TT1")
	L1=("TT2")
	M1=("TT3")
	N1=("TT4")
	O1=("TT5")
	P1=("TT6")
	Q1=("TT7")
	R1=("TT8")
	S1=("TT9")
	T1=("TT10")
	using "`results'", sheet("Page1") modify;

	
	
*** Put inside loop;	
	
* Writing rows to table; 	

	* Set local counter to cou+1; 
	local cell= 1`c'+1;  
	

	* Original table call to set matrix, 5 cols;
		table samp [pweight=w], c(mean bp mean pa mean dead mean div mean pmig) format(%5.3f);
	* Putexcel add country name in first column, table rows in B-F;
		putexcel A`cell' = "Country `c'" B`cell'=matrix(rows) C`cell'=matrix(cell) using "`results'", sheet("Page1") modify;

	* Original table call to set matrix, 4 cols;
		table samp [pweight=w], c(mean pimg mean pdmg mean mmg mean fmg) format (%5.3f);
	* Putexcel add country name in first column, table rows in G-J;
		putexcel G`cell'=matrix(rows) H`cell'=matrix(cell) using "`results'", sheet("Page1") modify;

* Writing t-test results; 
	* TT1;		
		ttest bp=pa;
		putexcel K`cell'=(r(t)) using "`results'", sheet("Page1") modify;	
	* TT2;
		ttest bp=dead;
		putexcel L`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT3;
		ttest bp=div;
		putexcel M`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT4; 
		ttest bp=pmig;
		putexcel N`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT5; 
		ttest dead=div;
		putexcel O`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT6; 
		ttest dead=pmig;
		putexcel P`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT7;
		ttest dead=div;
		putexcel Q`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT8;
		ttest div=pmig;		
		putexcel R`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT9;
		ttest pimg=pdmg;
		putexcel S`cell'=(r(t)) using "`results'", sheet("Page1") modify;
	* TT10;
		ttest mmg=fmg;
		putexcel T`cell'=(r(t)) using "`results'", sheet("Page1") modify;
		
		