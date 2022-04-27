@echo off

cd /d D:\PSTools
start psexec \\%1 -u administrator -p eland1234 -c -f D:\intellij_project\TDSController\StopTDSService.bat
