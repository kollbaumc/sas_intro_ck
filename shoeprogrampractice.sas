/*Accesses the table class in the sashelp library*/
DATA myclass;
	set sashelp.class;
run;

/*Prints out the data table*/
proc print data=myclass;
run;

/*Accessing the shoes table in the work library*/
data work.shoes;
    set sashelp.shoes;
    NetSales=Sales-Returns;
run;

/*coming up with some stats from the table (maxdec rounds to two decimal places) mean netsales and 
sum net sales by region*/
proc means data=work.shoes mean sum maxdec=2;
 	var NetSales;
    class region;
run;