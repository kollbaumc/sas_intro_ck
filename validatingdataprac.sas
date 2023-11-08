/*printing out a table of storm summary with just the first 10 row*/
proc print data=pg1.storm_summary (obs=10);
		var  Name Season MaxWindMPH MinPressure Basin StartDate EndDate; /*using only these variables in the table*/
run;

/*calculating summary statistics*/
proc means data=pg1.storm_summary;
		var MaxWindMPH MinPressure; 
run;

/*finding extreme values*/
proc univariate data=pg1.storm_summary;
		var MaxWindMPH MinPressure; 
run;

/*Find frequencies of certain variables*/
proc freq data=pg1.storm_summary;
		table basin type season; 
run;