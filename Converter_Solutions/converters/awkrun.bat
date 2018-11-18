echo off
cls
Rem This is processing file for GCBasic
REM
REM	Evan R. Venn Feb 2015
REM
REM	Uses awk to process the provide text file into a GCB Table.
REM
REM	The script processing file can be adapted to process any TEXT file to a GCB table.
REM
echo Processing %~n1.gcb
cd  %~d1%~p1
awk -f InfraredConvert.awk %1
del  %~d1%~p1%~n1.gcb
ren  %~d1%~p1awk.out %~n1.gcb


