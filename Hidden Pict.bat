@echo off
setlocal

::if u need some help fell free to contact me at facronact@gmail.com

:======================================================================================================================================================

::winver
::Windows 7      	  = 7600
::Windows 7 SP1  	  = 7601
::Windows 8			  = 9200
::Windows 8.1		  = 9600
::Windows 10 (2015)*  = 10240
::Windows 10 (2016)   = 14393
::Windows 10 (2017)	  = 16299
::Windows 10 (2018)	  = 17763
::Windows 10 (2019)*  = 1903
::*=not latest build


:CheckWinVer
for /f "tokens=2 delims==" %%a in ('wmic path Win32_OperatingSystem get BuildNumber /value') do (
  set /a WinBuild=%%a
)
if %winbuild% LSS 10240 (
echo ==== ERROR ====
echo Unsupported OS version Detected.
echo Project is supported only for Windows 10 and their Server equivalent.
msg * Makane to dji, Windows i di upgrade
echo.
echo Press any key to exit...
pause>nul &goto Exit
)

:======================================================================================================================================================

:Start
title Archive to Picture
color 0a
echo We can set one parameter before we continue
echo Leave blank if you dont know
echo.
set/p "cmnd=Command => "
%cmnd%
cls

:Post
cls
echo Masukkan File Gambar
msg * Anda bisa menyeret file
set/p "post=Nama file: "

set temp=%post:.png=%
if not %temp%==%post% (
	goto Post2
) else (
	goto Post1 
)

:Post1
set dump=%post:.jpg=%
if not %dump%==%post% (
	goto Post2
) else (
	msg * Format gambar harus .jpg atau .png &goto Post
)

:Post2
if exist "%post%" (
	goto Get
) else (
	msg * File tidak ditemukan 
	echo. 
	goto Post
)

:======================================================================================================================================================

:Clear
cls
echo File gambar=%post%

:Get
echo Masukkan File Archive
msg * Anda bisa menyeret file
set/p "get=Nama file: "

set var=%get:.rar=%
if not %var%==%post% (
	goto CheckGet
) else (
	msg * Format archive harus .rar &goto Get
)

:CheckGet
if exist "%get%" (
	goto Prompt
) else (
	msg * File tidak ditemukan 
	echo. 
	goto Clear 
)


:Prompt
cls
call :DeQuote post
call :DeQuote get
echo File Archive="%get%" dan File Gambar="%post%"
set/p "W=Apakah ini benar (Y/N) => "
if %W%==Y (
	goto Process
) 
if %w%==y (
	goto Process
)
if %W%==N (
	goto Post
) 
if %W%==n (
	goto Post
)
goto Prompt

:======================================================================================================================================================

:GetPrivileges
set "params=Problem_with_elevating_UAC_for_Administrator_Privileges"&if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
fsutil dirty query %systemdrive%  >nul 2>&1 && goto :GotPrivileges
:: The following test is to avoid infinite looping if elevating UAC for Administrator Privileges failed
If "%1"=="%params%" (echo Elevating UAC for Administrator Privileges failed&echo Right click on the script and select 'Run as administrator'&echo Press any key to exit...&pause>nul 2>&1&exit)
cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "%~0", "%params%", "", "runas", 1 > "%temp%\getadmin.vbs"&cscript //nologo "%temp%\getadmin.vbs"&exit
:GotPrivileges

:======================================================================================================================================================

:Process
echo Loading
Echo Memproses...
echo Harap Tunggu...
echo.
copy /b "%post%"+"%get%" "%post%"
echo Selesai
pause
goto Exit

:======================================================================================================================================================

:Exit
endlocal
msg * Have a good day %Username%
exit

:======================================================================================================================================================

:DeQuote
for /f "delims=" %%A in ('echo 	%%%1%%') do set %1=%%~A
