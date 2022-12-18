@echo off
setlocal
cls

rem Change the title...
TITLE Parsec Anywhere - https://github.com/walkxcode/parsec-anywhere

echo Starting Parsec installation...
echo.

rem Create a directory for Parsec in the temp folder
if not exist "%temp%\Parsec" mkdir "%temp%\Parsec"

echo Downloading Parsec package...
echo.

rem Download the Parsec package to the Parsec temp directory with a progress bar
curl --progress-bar -f https://builds.parsecgaming.com/package/parsec-flat-windows32.zip -o "%temp%\Parsec\parsec.zip"

echo Extracting Parsec package...
echo.

rem Extract the downloaded zip file to the Parsec temp directory
Call :UnZipFile "%temp%\Parsec" "%temp%\Parsec\parsec.zip"

echo Deleting downloaded zip file...
echo.

rem Delete the downloaded zip file
del /f "%temp%\Parsec\parsec.zip"

echo Downloading config file...
echo.

rem Download the config file to the Parsec temp directory with a progress bar
curl --progress-bar -f https://raw.githubusercontent.com/chrismin13/parsec-download-script/main/config.txt -o "%temp%\Parsec\config.txt"

echo Starting Parsec daemon...
echo.

rem Start the Parsec daemon in the Parsec temp directory
start /d "%temp%\Parsec" parsecd.exe

rem Send success message
msg "%username%" /TIME:10 Parsec installation has been completed. Enjoy!

exit /B

rem Function to extract a zip file
:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"

rem Delete the vbs file if it already exists
if exist %vbs% del /f /q %vbs%

rem Create the vbs file with the necessary code to extract the zip file
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing

rem Run the vbs file to extract the zip file
cscript //nologo %vbs%

rem Delete the vbs file
if exist %vbs% del /f /q %vbs%
