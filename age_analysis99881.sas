libname ck1 'O:\Marketing\Data Teams\Reporting Analytics\Reporting\ckollbaum\SAS';

data ck1.i3ed;
	format age 3.;
	set ck1.ieeeres_ck;
	age = int(COVR_ST_EFF_DT - DOB)*.0001;
	tap = int(dep_prem + mem_prem);

run;

data ck1.i3ed2;
	length age_band $25.;
	set ck1.age1;
	if age<40 then age_band = "Under 40";
	else if 40<=age<45 then age_band = "40-44";
	else if 45<=age<50 then age_band = "45-49";
	else if 50<=age<55 then age_band = "50-54";
	else if 55<=age<60 then age_band = "55-59";
	else if 60<=age<65 then age_band = "60-64";
	else if 65<=age<70 then age_band = "65-69";
	else if 70<=age<75 then age_band = "70-74";
	else if 75<=age<80 then age_band = "75-79";
	else if 80<=age<85 then age_band = "80-84";
	else if 85<=age<90 then age_band = "85-89";
run;

proc freq data=ck1.i3ed2;
	tables age_band*age/list missing;
run;

proc tabulate data=ck1.i3ed2 out=ck1.i3ed3;
	class age_band;
	var grscnt netcnt tap;
	tables age_band*grscnt age_band*netcnt age_band*tap ;
run;

data ck1.mailingi3ed;
input age_band $ mlgquantity;
datalines;
40-44 5300
45-49 5153
50-54 6651
55-59 9424
60-64 10599
65-69 15022
70-74 12615
75-79 10108
80-84 6816
85-89 3340
;
run;

proc sql;
create table ck1.i3ed_a as
select i3ed3.age_band, mlgquantity, grscnt_Sum, grscnt_sum/mlgquantity*100 as grs_percent,
netcnt_Sum, netcnt_sum/mlgquantity*100 as net_percent, tap_Sum,
mlgquantity*.692 as Cost
from ck1.i3ed3 inner join ck1.MAILINGi3ed
on i3ed3.age_band = mailingi3ed.age_band;
quit;

data ck1.i3ed_a1;
set ck1.i3ed_a;
c_tap = cost/tap_sum;
run;

proc sql;
create table ck1.totalsi3ed as
select sum(mlgquantity) as mlgsum,
sum(grscnt_sum) as grssum,
sum(netcnt_sum) as netsum,
sum(tap_sum) as tapsum, sum(cost) as costsum from ck1.i3ed_a1
;
quit;

proc sql;
create table ck1.totals2i3ed as
select grssum/mlgsum*100 as gross_percent, 
netsum/mlgsum*100 as net_percent,
costsum/tapsum as ctap from ck1.totalsi3ed;
quit;

