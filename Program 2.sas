data practice1;
input x y;
datalines;
4 8
5 12
6 16
2 0
7 20
1 -4
19 23
;

proc print data = practice1;

proc sgscatter data = practice1;
plot x*y;

proc reg data = practice1;
model y = x/clb;

data practice2;
input x y;
datalines;
8.6 .
;
proc print data = practice2;

data practice1;
set practice1 practice2;
proc print data = practice1;
run;

proc reg data = practice1;
model y = x/cli;