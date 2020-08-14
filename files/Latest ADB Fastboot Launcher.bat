@echo off
mkdir "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1

cd "%HOMEPATH%\Latest ADB Fastboot Tool"  > nul 2>&1

echo.
echo Paste your files(twrp,etc) in Latest ADB Fastboot Tool Folder
echo and enter ADB and Fastboot commands in here
echo.

PowerShell -Command "Start-Sleep -s 2" > nul 2>&1
echo Please do consider to donate and share this tool
PowerShell -Command "Start-Sleep -s 1" > nul 2>&1
echo Donate Link: fawazahmed0.github.io/donate.html
echo.
:: Launching folder in current directory
start .

:: https://stackoverflow.com/a/60907/2437224
:: Stops the command prompt from getting closed
cmd /k
