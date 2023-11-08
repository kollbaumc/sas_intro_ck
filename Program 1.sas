data Softball_Stats;
input Name$ Average Strikeouts Singles DOB;
informat DOB ddmmyy10.;
format DOB ddMMYY10.;
datalines;
Hattie .592 7 18 24/1/2014
Avalynn .624 5 16 13/6/2014
Logan .451 9 12 18/7/2014
Lola .395 10 12 4/5/2014
Binzley .501 7 13 22/2/2014
;
Run;

proc print data = softball_stats;
Run;