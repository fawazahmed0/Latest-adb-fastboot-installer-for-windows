@echo off
mkdir "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1

cd "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1

echo.
echo Paste your files(twrp,etc) in Latest ADB Fastboot Tool Folder
echo and enter ADB and Fastboot commands in here
echo.

PowerShell -Command "Start-Sleep -s 2" > nul 2>&1
:: Launching folder in current directory
start .

:: https://stackoverflow.com/a/60907/2437224
:: Stops the command prompt from getting closed
cmd /k
