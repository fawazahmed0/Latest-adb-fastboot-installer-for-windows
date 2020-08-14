@echo off
mkdir "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1

cd "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1
echo.
echo Please do consider to donate and share this tool
echo Donate Link: fawazahmed0.github.io/donate.html
PowerShell -Command "Start-Sleep -s 1" > nul 2>&1
echo.

echo Paste your files(twrp, gsi, etc) in Latest ADB Fastboot Tool Folder
echo and enter ADB and Fastboot commands in here
PowerShell -Command "Start-Sleep -s 3" > nul 2>&1
echo.


:: Launching folder in current directory
start .

:: https://stackoverflow.com/a/60907/2437224
:: Stops the command prompt from getting closed
cmd /k
