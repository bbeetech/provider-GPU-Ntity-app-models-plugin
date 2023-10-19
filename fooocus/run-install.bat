@echo off

rem Define the URLs and file paths
set "download_url=https://github.com/lllyasviel/Fooocus/releases/download/release/Fooocus_win64_2-1-60.7z"
set "downloaded_file=fooocus(sdxl).7z"
set "installDir=C:\Program Files\WinRAR"
set "extracted_folder=Fooocus(SDXL)"
set "run_script=.\run.bat"

rem Step 1: Download fooocus.7z with progress
if not exist "%downloaded_file%" (
    choco install curl -y
    echo Downloading %downloaded_file%...
    curl -# -L -o "%downloaded_file%" "%download_url%"
) else (
    echo %downloaded_file% already exists. Skipping download.
)

rem Check if WinRAR is installed
if not exist "%installDir%\WinRAR.exe" (
    echo WinRAR is not installed in %installDir%. Please install it first.
    pause
    exit /b
)

rem Extract the downloaded archive to the installation directory
if not exist "%extracted_folder%" (
    echo Extracting %downloaded_file% to %extracted_folder% ...
    "%installDir%\WinRAR.exe" x -ibck -idc -y %downloaded_file%
)

rem Step 3: Run the run.bat script in the fooocus folder if it exists
if exist "%extracted_folder%" (
    echo Running %run_script% in %extracted_folder% ...
    call %run_script%
) else (
    echo %extracted_folder% does not exist. Cannot run %run_script%.
)

endlocal
