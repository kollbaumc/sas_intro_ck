libname ck1 'O:\Marketing\Data Teams\Reporting Analytics\Reporting\ckollbaum\SAS';

data ck1.age1;
	format age 3.;
	set ck1.ieeeres_ck;
	age = int(COVR_ST_EFF_DT - DOB)*.0001;
	tap = int(dep_prem + mem_prem);

run;

data ck1.age2;
	length age_band $25.;
	set ck1.age1;
	if age<25 then age_band = "Under 25";
	else if 25<=age<30 then age_band = "25-29";
	else if 30<=age<35 then age_band = "30-34";
	else if 35<=age<40 then age_band = "35-39";
	else if 40<=age<45 then age_band = "40-44";
	else if 45<=age<50 then age_band = "45-49";
	else if 50<=age<55 then age_band = "50-54";
	else if 55<=age<60 then age_band = "55-59";
	else if 60<=age<65 then age_band = "60-64";
	else if 65<=age<70 then age_band = "65-69";
	else if 70<=age<75 then age_band = "70-74";
run;

proc freq data=ck1.age2;
	tables age_band*age/list missing;
run;

proc tabulate data=ck1.age2 out=ck1.age3;
	class age_band;
	var grscnt netcnt tap;
	tables age_band*grscnt age_band*netcnt age_band*tap ;
run;

data ck1.mailing;
input age_band $ mlgquantity;
datalines;
25-29 11058
30-34 10284
35-39 9708
40-44 10142
45-49 9674
50-54 11522
55-59 16352
60-64 19002
65-69 9150
;
run;

proc sql;
create table ck1.age_a as
select AGE3.age_band, mlgquantity, grscnt_Sum, grscnt_sum/mlgquantity*100 as grs_percent,
netcnt_Sum, netcnt_sum/mlgquantity*100 as net_percent, tap_Sum,
mlgquantity*.397 as Cost
from ck1.AGE3 inner join ck1.MAILING
on age3.age_band = mailing.age_band;
quit;

data ck1.age_a1;
set ck1.age_a;
c_tap = cost/tap_sum;
run;

proc sql;
create table ck1.totals as
select sum(mlgquantity) as mlgsum,
sum(grscnt_sum) as grssum,
sum(netcnt_sum) as netsum,
sum(tap_sum) as tapsum, sum(cost) as costsum
from ck1.age_a1
;
quit;

proc sql;
create table ck1.totals2 as
select grssum/mlgsum*100 as gross_percent, 
netsum/mlgsum*100 as net_percent,
costsum/tapsum as ctap from ck1.totals;
quit;
