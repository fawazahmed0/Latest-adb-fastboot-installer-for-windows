@echo off
mkdir "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1

cd "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1
echo.
echo Paste your files(twrp,etc) in Latest ADB Fastboot Tool Folder
echo And enter ADB and Fastboot commands in here
echo.
PowerShell -Command "Start-Sleep -s 2" > nul 2>&1
start .
cmd /k





