/* Adapted from "SAS Project/EXAM-SCENARII7B-BOA-THIEMELE.sas"
   Original scenario: read Cert.Temp18, format Day as DATE9., derive a
   Month variable, run a one-way PROC FREQ on HighTemp, and PROC MEANS
   (mean/stddev) for AvgHighTemp/AvgLowTemp grouped by Month.

   Substitution: the original LIBNAME cert points at a local Windows
   path (C:\sas_exam\Cert) holding the SAS-certification-guide practice
   dataset TEMP18 (daily weather readings). That dataset isn't in the
   repo (its sibling extract, SAS Project/D.TXT, was removed from the
   repo before this bundle was built), so this bundle builds a
   same-shape mock Work.Scenario7 in DATALINES (Day/HighTemp/
   AvgHighTemp/AvgLowTemp spanning two months) and runs the author's
   own format/derive/PROC FREQ/PROC MEANS sequence against it
   unmodified. */

data Work.Scenario7;
	length DayChar $9;
	input DayChar $ HighTemp AvgHighTemp AvgLowTemp;
	datalines;
02JAN2018 41 38 22
05JAN2018 53 40 24
11JAN2018 62 39 23
14JAN2018 53 37 21
19JAN2018 45 36 20
22JAN2018 53 38 22
27JAN2018 39 35 19
03FEB2018 48 44 28
06FEB2018 53 45 29
09FEB2018 57 46 30
12FEB2018 53 43 27
17FEB2018 61 47 31
21FEB2018 53 45 29
25FEB2018 44 42 26
;
run;

/* Format the Day variable so that the date appears as 01JAN2023-style. */
data Work.Scenario7;
	format Day Date9.;
	set Work.Scenario7;
	Day = input(DayChar, date9.);
	drop DayChar;
run;

proc print data=Work.Scenario7;
run;

/* Derive Month from Day (1=January, 2=February, ...) */
data Work.Scenario7;
	set Work.Scenario7;
	Month = Month(Day);
run;

proc print data=Work.Scenario7;
run;

/* One-way frequency table for HighTemp */
proc freq data=Work.Scenario7;
	tables HighTemp;
run;

/* Mean and standard deviation for AvgHighTemp/AvgLowTemp, by Month */
proc means data=Work.Scenario7 mean stddev;
	var AvgHighTemp AvgLowTemp;
	class Month;
run;

/* Frequency for a specific HighTemp value (mirrors the original's
   HighTemp=53 question) */
proc freq data=Work.Scenario7;
	tables HighTemp / nocum nopercent;
	where HighTemp=53;
run;

/* Mean/stddev for AvgLowTemp restricted to Month=2 (mirrors the
   original's Month=2 questions) */
proc means data=Work.Scenario7 mean stddev maxdec=2;
	var AvgLowTemp;
	class Month;
	where Month=2;
run;
