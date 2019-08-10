@echo on
setlocal

::if u need some help fell free to contact me at facronact@gmail.com

:======================================================================================================================================================

:Start
title Encoder File
color 0a
echo We can set one parameter before we continue
echo Leave blank if you dont know
echo.
set/p "cmnd=Command => "
%cmnd%
cls

:GetFileName
cls
echo Masukan input file
set /p "file=Nama file: "
if exist "%file%" (
	goto OutputFile
) else (
	msg * File tidak ditemukan 
)
goto GetFileName

:Clear
cls
echo Input file=%file%
:OutputFile
echo Masukan output file
set /p "output=Output file: "

:Exist
if not exist "%output%" goto Method
cls
echo Ada file dengan nama yg sama
set /p "tanya=Overwrite? (Y/N) => "
if %tanya%==Y (
	goto Method
)
if %tanya%==y (
	goto Method
)
if %tanya%==N (
	goto Clear
)
if %tanya%==n (
	goto Clear
)
goto Exist


:Method
echo Masukan Metode
echo 0= base 64 with certified header
echo 1= base 64 without certified header
echo 2= pure binnary
echo 4= in column with spaces but without the characters and the addresses 
echo 5= without the addresses
echo 7= base 64 (x509) without header
echo 8= base 64 (x509) with header
echo 12= one line HEX value without spaces, column, and addresses
set /p "method=Metode: "

:GiveFormat
set temp=%output:.txt=%
if not %temp%==%output% (
	goto Prompt
) else (
	set output="%output%.txt"
)

:Prompt
call :DeQuote file
call :DeQuote output2
echo File input=%file% dan file output=%output%
set/p "W=Apakah ini benar (Y/N) => "
if %W%==Y (
	goto Process
) 
if %w%==y (
	goto Process
)
if %W%==N (
	goto GetFileName
) 
if %W%==n (
	goto GetFileName
)
goto Prompt

:======================================================================================================================================================

:Process

certutil /encodehex /f "%file%" "%output%" %method%

:======================================================================================================================================================

:exit
pause
endlocal
exit

:======================================================================================================================================================

:DeQuote
for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A