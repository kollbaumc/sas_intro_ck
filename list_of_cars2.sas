/*Creates the new variable to identify if a car is American made or not*/
data where_made;
	length Made_in $20.;
	set sashelp.cars;
	if Origin = 'USA' then Made_in = 'American Made';
	else Made_in = 'Not American Made';
run;

/*Provides of list of cars that are American made and cost less than $27,000*/
title "List of American Made Cars Under $27,000";
proc sql; 
	select Make, Model, Invoice from work.Where_Made
	where Made_in = 'American Made' and Invoice <= 27000;
quit;