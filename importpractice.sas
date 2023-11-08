PROC IMPORT DATAFILE='/home/u63663995/US_violent_crime.csv'
	DBMS=CSV
	OUT=WORK.Crime;
	GETNAMES=YES;
RUN;
data work.crime;
infile '/home/u63663995/US_violent_crime.csv'
delimiter = ','
MISSOVER
DSD lrecl=32767
firstobs=2 ;
	informat State $20. ;
	informat Murder best32. ;
	informat Assault best32. ;
	informat UrbanPop best32. ;
	informat Rape best32. ;
	format State $20. ;
	format Murder best12. ;
	format Assault best12. ;
	format UrbanPop best12. ;
	format Rape best12. ;
	input
	State  $
		Murder
		Assault
		UrbanPop
		Rape
;
if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;

