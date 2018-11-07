@ECHO OFF

SET BULDTOOLSDIR=d:\assdk\build-tools
SET APKFILE=test.apk


SETLOCAL ENABLEDELAYEDEXPANSION


REM SET AAPTEXE=d:\assdk\build-tools\27.0.3\aapt.exe
REM call %AAPTEXE% list -a %APKFILE% | findstr /L "minSdkVersion targetSdkVersion"
REM echo. -------------------------------------------------------------------------
REM set var=text:with:colons:
REM set var=%var::=$%
REM echo %var%

FOR /F "delims=" %%A in ('CALL dir /s /b %BULDTOOLSDIR%\*aapt.exe ^| findstr /L "aapt.exe"') do (SET AAPTEXE=%%A)
SET /A index=1 & (FOR /F "delims=" %%A in ('%AAPTEXE% list -a %APKFILE% ^| findstr /L "minSdkVersion targetSdkVersion"') do (SET VARIABLE!index!=%%A & SET /A index=!index!+1) )
SET minsdk=%VARIABLE1: =% & SET targetsdk=%VARIABLE2: =%

REM echo. -------------------------------------------------------------------------
REM echo. %minsdk% & echo. %targetsdk%

SET "FINDSTR=*(type0x10)" & (CALL SET /A minsdk=%%minsdk:!FINDSTR!=%%) & (CALL SET /A targetsdk=%%targetsdk:!FINDSTR!=%%)
echo. -------------------------------------------------------------------------
echo. aapt: %AAPTEXE%
echo. apk : %APKFILE%
echo. minsdk   : %minsdk%
echo. targetsdk: %targetsdk%

