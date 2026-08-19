/* Adapted from "SAS Project/EXAM-SCENARII4B-BOA-THIEMELE.sas"
   Original scenario: sort Cert.Laguardia by Dest, print grouped by Dest,
   and pull specific observations (firstobs=12/obs=12, firstobs=33/obs=33).

   Substitution: the original script points LIBNAME cert at a local
   Windows path (C:\sas_exam\Cert) holding the SAS-certification-guide
   practice dataset LAGUARDIA (flight boardings by destination). That
   dataset isn't in the repo, so this bundle builds a same-shape mock
   Work.Laguardia in DATALINES (destination code + boarded count) and
   runs the author's own PROC SORT / PROC PRINT sequence against it
   unmodified. The 33-row size mirrors the original firstobs=33 pull. */

data Work.Laguardia;
	length Dest $3;
	input Dest $ Boarded;
	datalines;
ATL 142
ATL 158
BOS 97
BOS 88
BOS 103
CHI 176
CHI 164
CHI 190
DEN 121
DEN 133
DEN 118
DFW 205
DFW 198
DFW 211
LON 173
LON 165
LON 180
LON 190
MIA 144
MIA 137
MIA 150
ORD 162
ORD 155
PHL 99
PHL 105
PHL 111
SFO 187
SFO 179
SFO 195
SEA 132
SEA 128
SEA 140
LON 200
;
run;

proc sort data=Work.Laguardia
		  out=Work.Laguardia;
	by Dest;
run;

proc print data=Work.Laguardia;
	by Dest;
run;

/* Pull observation 12 (mirrors the original's firstobs=12 obs=12 check) */
proc print data=Work.Laguardia (firstobs=12 obs=12);
	by Dest;
	var Boarded;
run;

/* Pull observation 33 (mirrors the original's firstobs=33 obs=33 check) */
proc print data=Work.Laguardia (firstobs=33 obs=33);
	by Dest;
	var Dest;
run;
