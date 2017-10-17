@echo off
rem Below is important and allows to set variables inside for loop, Windows ehh.
setlocal EnableDelayedExpansion
title Mapp Drives
color 1b

rem EDIT AS/IF REQUIRED
set domain=
rem Server Name
set server=
rem Share Names, with server part
set shares="<Name of Share1>";"<Name of Share2>";"<Name of Share3>"
rem Drive letters in order,
set letters="A:";"B:";"C:"

rem ############################################
rem PLEASE DO NOT EDIT BEYOND THIS POINT, THANKS
rem ############################################
:execute

rem Ask User if he knows who He/She is.
echo Please Type Your Biohealth Username:
set /p "user=Username: "
echo Please Type The Biohealth User password:
set /p "password=Password: "

rem convert lists to arrays, Answer to question why Windows always needs more resources.
set i=0
for %%a in (%shares%) do set /A i+=1 & set shares[!i!]=%%a
set i=0
for %%b in (%letters%) do set /A i+=1 & set letters[!i!]=%%b
set numshares=%i%

rem Start mapping process based on previously built details.
for /l %%a in (1,1,%numshares%) do (
	
        @set share=!shares[%%a]!

	rem remove quotes around share
	@set share=!share:"=!

	rem Remove share if it was previously mapped but not visible
	if exist !letters[%%a]! (
		net use !letters[%%a]! /DELETE
	)

	rem show some confusing info
	echo Mapping "\\!server!\!share!"
	rem Do the job
	net use !letters[%%a]! "\\!server!\!share!" %password% /USER:"%domain%\%user%" /PERSISTENT:YES
)

rem End use of EnableDelayedExpansion
endlocal

rem Ask user to do something 
set /p WAITING_PAUSE= Please press ENTER to continue...
