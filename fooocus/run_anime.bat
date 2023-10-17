
@echo off

set ENV_NAME=fooocus

rem Check if the environment already exists
conda env list | find /i "%ENV_NAME%" > nul
if errorlevel 1 (
    echo Creating Conda environment: %ENV_NAME%
    conda env create -f environment.yaml
) else (
    echo Conda environment %ENV_NAME% already exists. Skipping creation.
)

rem Activate the environment
call conda activate %ENV_NAME%

pip install pygit2==1.12.2
pip install -r requirements_versions.txt
python -s entry_with_update.py --preset anime
pause
