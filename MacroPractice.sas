proc freq data=pg1.np_species;
	tables abundance conservation_status;
	where species_id like "YOSE%" and Category="Mammal";
run;


proc print data=pg1.np_species;
    var Species_ID Category Scientific_Name Common_Names;
    where Species_ID like "YOSE%" and
          Category="Mammal";
run;

%let ParkCode=YOSE;
%let SpeciesCat=Mammal;

proc freq data=pg1.np_species;
    tables Abundance Conservation_Status;
    where Species_ID like "&ParkCode%" and
          Category="&SpeciesCat";
run;

proc print data=pg1.np_species;
    var Species_ID Category Scientific_Name Common_Names;
    where Species_ID like "&ParkCode%" and
          Category="&SpeciesCat";
run;