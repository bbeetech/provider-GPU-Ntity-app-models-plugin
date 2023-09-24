@echo off
setlocal enabledelayedexpansion

:: Get the directory where the script is located
for %%i in ("%~dp0.") do set "scriptDir=%%~fi"

:: Define the URL of the file to download
set "fileURL=https://github.com/lllyasviel/Fooocus/releases/download/release/Fooocus_win64_2-0-50.7z"

:: Define the destination folder and file name
set "downloadFolder=%scriptDir%"
set "downloadedFile=%downloadFolder%\Fooocus_win64_2-0-50.7z"

:: Define the extraction folder
set "extractionFolder=%downloadFolder%\Fooocus"

:: Check if the file has already been downloaded
if not exist "%downloadedFile%" (
    echo Downloading %fileURL%...
    :: Use PowerShell to download the file
    powershell -command "(New-Object Net.WebClient).DownloadFile('%fileURL%', '%downloadedFile%')"
    echo File downloaded to %downloadedFile%
)

:: Check if the extraction folder exists, and if not, create it
if not exist "%extractionFolder%" (
    echo Creating extraction folder %extractionFolder%...
    mkdir "%extractionFolder%"
)

:: Extract the downloaded file (assuming it's a 7z archive)
7z x "%downloadedFile%" -o"%extractionFolder%" -y

:: Check if the run.bat file exists in the extraction folder
if exist "%extractionFolder%\run.bat" (
    echo Running run.bat in %extractionFolder%...
    cd "%extractionFolder%"
    call run.bat
) else (
    echo run.bat file not found in %extractionFolder%.
)

endlocal
