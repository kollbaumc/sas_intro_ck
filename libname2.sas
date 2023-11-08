libname np xlsx "/home/u63663995/EPG1V2/data/np_info.xlsx";
options validvarname=v7;

proc contents data=np.parks;
run;

libname np clear;