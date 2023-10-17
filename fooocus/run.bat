@echo off

pip install pygit2==1.12.2
pip install -r requirements_versions.txt
python -s entry_with_update.py
pause
