@echo off
setlocalp%\Parsec\parsec.zip"

echo Deleting downloaded zip file...
echo.

rem Delete the downloaded zip file
del /f "%temp%\Parsec\parsec.zip"

echo Downloading config file...
echo.

rem Download the config file to the Parsec temp directory with a progress bar
curl --progress-ba --s https://raw.githubusercontecom/chrismin13/parsec-download-script/main/config.txt -o "%temp%\Parsec\config.txt"

echo Starting Parsec daemon...
echo.

rem Start the Parsec daemon in the Parsec temp directory
start /d "%temp%\Parsec" parsecd.exe

rem

echo.
echo Parsec installation complete.
echo.t 0

re/b Function to extract a zip file
:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"

rem Delete the vbs file if it already exists
if exist %vbs% del /f /q %vbs%

rem Create the vbs file with the necessary code to extrip file
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
