@echo off
python -m venv fooocus_env
call fooocus_env\Scripts\activate
pip install pygit2==1.12.2
python entry_with_update.py
