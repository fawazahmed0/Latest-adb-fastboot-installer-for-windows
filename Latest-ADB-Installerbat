@echo off

:: Initial message
echo ====================================================
echo All Praises be to God , who have Created All Things,
echo While He Himself is Uncreated
echo ====================================================
echo Latest ADB Fastboot and USB Driver Installer tool
echo By fawazahmed0 @ xda-developers
echo ====================================================
:: echo. is newline
echo.

:: Source: https://support.microsoft.com/en-us/help/110930/redirecting-error-messages-from-command-prompt-stderr-stdout
:: Source: https://www.robvanderwoude.com/battech_debugging.php
:: For debugging this script, comment out @echo off at top line
:: Start cmd as admin, and run this script as nameofscript.bat > mylog.txt 2>myerror.txt


:: Source: https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
:: Source: https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
:: batch code to request admin previleges, if no admin previleges
net session >nul 2>&1
if NOT %errorLevel% == 0 (
powershell -executionpolicy bypass start -verb runas '%0' am_admin & exit /b
)

echo Please connect your phone in USB Debugging Mode with MTP or File Transfer
echo Option selected, for Proper USB drivers installation, you can do this now,
echo while the installation is running [Optional Step, Highly Recommended]

:: Adding timout
:: Source: http://blog.bitcollectors.com/adam/2015/06/waiting-in-a-batch-file/
:: Source: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/start-sleep?view=powershell-6
PowerShell -executionpolicy bypass -Command "Start-Sleep -s 10" > nul 2>&1

echo.
echo Starting Installation

:: Source: https://stackoverflow.com/questions/672693/windows-batch-file-starting-directory-when-run-as-admin
:: Going back to script directory
cd %~dp0

:: Source: https://serverfault.com/questions/132963/windows-redirect-stdout-and-stderror-to-nothing
:: Null stdout redirection
:: Creating temporary directory and using it
echo Creating temp folder
rmdir /Q /S temporarydir > nul 2>&1
mkdir temporarydir

:: Similar to cd command
:: Source : https://stackoverflow.com/questions/17753986/how-to-change-directory-using-windows-command-line
pushd temporarydir

:: Source: https://stackoverflow.com/questions/4619088/windows-batch-file-file-download-from-a-url
:: Downloading the latest platform tools from google
echo Downloading the latest adb and fastboot tools
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/android/repository/platform-tools-latest-windows.zip', 'adbinstallerpackage.zip')"

echo Downloading latest usb drivers
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/android/repository/latest_usb_driver_windows.zip', 'google_usb_driver.zip')"
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/Latest-adb-fastboot-installer-for-windows@master/files/google64inf', 'google64inf')"
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/Latest-adb-fastboot-installer-for-windows@master/files/google86inf', 'google86inf')"
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/Latest-adb-fastboot-installer-for-windows@master/files/Stringsvals', 'Stringsvals')"
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/Latest-adb-fastboot-installer-for-windows@master/files/kmdf', 'kmdf')"
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/Latest-adb-fastboot-installer-for-windows@master/files/Latest ADB Launcherbat', 'Latest ADB Launcher.bat')"

::Fetching devcon.exe and powershell script
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/Latest-adb-fastboot-installer-for-windows@master/files/fetch_hwidps1', 'fetch_hwid.ps1')"
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/Latest-adb-fastboot-installer-for-windows@master/files/devconexe', 'devcon.exe')"

:: Source: https://pureinfotech.com/list-environment-variables-windows-10/
:: Using Environment varaibles for programe files
:: Uninstalling/removing the platform tools older version, if they exists and  killing instances of adb if they are running
echo Uninstalling older version
adb kill-server > nul 2>&1
rmdir /Q /S "%PROGRAMFILES%\platform-tools" > nul 2>&1

:: Source: https://stackoverflow.com/questions/37814037/how-to-unzip-a-zip-file-with-powershell-version-2-0
:: Source: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-6
:: Extracting the .zip file to installation location
echo Installing the files
PowerShell -executionpolicy bypass -Command "& {$shell_app=new-object -com shell.application; $filename = \"adbinstallerpackage.zip\"; $zip_file = $shell_app.namespace((Get-Location).Path + \"\$filename\"); $destination = $shell_app.namespace($Env:ProgramFiles); $destination.Copyhere($zip_file.items());}"
echo Installing USB drivers
PowerShell -executionpolicy bypass -Command "& {$shell_app=new-object -com shell.application; $filename = \"google_usb_driver.zip\"; $zip_file = $shell_app.namespace((Get-Location).Path + \"\$filename\"); $destination = $shell_app.namespace((Get-Location).Path); $destination.Copyhere($zip_file.items());}"

:: Source: https://stackoverflow.com/questions/1804751/use-bat-to-start-powershell-script
:: Calling powershell script to fetch the unknown usb driver hwids and inserting that in inf file
:: Source: https://stackoverflow.com/questions/19335004/how-to-run-a-powershell-script-from-a-batch-file
:: Source: https://stackoverflow.com/questions/50370658/bypass-vs-unrestricted-execution-policies
powershell -executionpolicy bypass .\fetch_hwid.ps1

:: Source: https://github.com/koush/UniversalAdbDriver
:: Source: https://forum.xda-developers.com/google-nexus-5/development/adb-fb-apx-driver-universal-naked-t2513339
:: Source: https://stackoverflow.com/questions/60034/how-can-you-find-and-replace-text-in-a-file-using-the-windows-command-line-envir
:: Source: https://stackoverflow.com/questions/51060976/search-multiline-text-in-a-file-using-powershell
:: Source: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content?view=powershell-6
:: Combining multiple inf Files to support all the devices
powershell -executionpolicy bypass -Command "gc Stringsvals | Add-Content usb_driver\android_winusb.inf"
powershell -executionpolicy bypass -Command "(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Google.NTamd64\]', (gc google64inf | Out-String) | Out-File usb_driver\android_winusb.inf"
powershell -executionpolicy bypass -Command "(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Google.NTx86\]', (gc google86inf | Out-String) | Out-File usb_driver\android_winusb.inf"
powershell -executionpolicy bypass -Command "(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Strings\]', (gc kmdf | Out-String) | Out-File usb_driver\android_winusb.inf"

:: Fetching unsigned driver installer tool
echo Downloading unsigned driver installer tool
PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.jsdelivr.net/gh/fawazahmed0/windows-unsigned-driver-installer@master/unsigned_driver_installerbat', 'usb_driver\unsigned_driver_installer.bat')"

:: Source: https://stackoverflow.com/questions/1103994/how-to-run-multiple-bat-files-within-a-bat-file
:: https://stackoverflow.com/questions/3583565/how-to-skip-pause-in-batch-file
:: Running unsigned_driver_installer tool
pushd usb_driver
echo.
echo | call unsigned_driver_installer.bat
popd

:: Doing fastboot drivers installation
:: Source: https://support.microsoft.com/en-us/help/110930/redirecting-error-messages-from-command-prompt-stderr-stdout
:: Source: https://stackoverflow.com/questions/7005951/batch-file-find-if-substring-is-in-string-not-in-a-file
:: Checking if usb debugging authorization is required
"%PROGRAMFILES%\platform-tools\adb.exe" reboot bootloader > nul 2> temp.txt
set rbtval=%errorLevel%
:: Source: https://stackoverflow.com/questions/3068929/how-to-read-file-contents-into-a-variable-in-a-batch-file
:: Source: http://batcheero.blogspot.com/2007/06/how-to-enabledelayedexpansion.html
:: Source: https://stackoverflow.com/questions/4367930/errorlevel-inside-if
:: Batch works different that any other programming language
type temp.txt | findstr /i /C:"unauthorized" 1> NUL

if %errorLevel% == 0 (
echo.
echo Beginning Fastboot drivers Installation
echo.
echo Please Press OK on confirmation dialog shown in your phone,
echo to allow USB debugging authorization
echo And then press Enter key to continue
PowerShell -executionpolicy bypass -Command "Start-Sleep -s 3" > nul 2>&1
pause > NUL
"%PROGRAMFILES%\platform-tools\adb.exe" reboot bootloader > nul 2>&1

)
:: Dont give space after %errorLevel%, value will be then assigned with space to rbtval
if NOT "%rbtval%" == "0" set rbtval=%errorLevel%


if "%rbtval%" == "0" (
echo.
echo Installing fastboot drivers, Now the device will reboot to fastboot mode

:: Adding timout , waiting for fastboot mode to boot
:: Source: http://blog.bitcollectors.com/adam/2015/06/waiting-in-a-batch-file/
:: Source: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/start-sleep?view=powershell-6
echo Waiting for fastboot mode to load
PowerShell -executionpolicy bypass -Command "Start-Sleep -s 7" > nul 2>&1

:: Source: https://stackoverflow.com/questions/50370658/bypass-vs-unrestricted-execution-policies
:: Executing ps1 to fetch the hwid of fastboot device
powershell -executionpolicy bypass .\fetch_hwid.ps1

:: Call driver installer
pushd usb_driver
echo.
echo | call unsigned_driver_installer.bat
popd

:: Source: https://stackoverflow.com/questions/52060842/check-for-empty-string-in-batch-file
:: Checking for fastboot device before doing a fastboot reboot
"%PROGRAMFILES%\platform-tools\fastboot.exe" devices > temp.txt
set /p fbdev=<temp.txt
if defined fbdev ( "%PROGRAMFILES%\platform-tools\fastboot.exe" reboot > nul 2>&1  )
)
:: killing adb server
"%PROGRAMFILES%\platform-tools\adb.exe" kill-server > nul 2>&1


:: Source: https://stackoverflow.com/questions/51636175/using-batch-file-to-add-to-path-environment-variable-windows-10
:: Source: https://stackoverflow.com/questions/141344/how-to-check-if-directory-exists-in-path/8046515
:: Source: https://stackoverflow.com/questions/9546324/adding-directory-to-path-environment-variable-in-windows
:: Setting the path Environment Variable
echo.
echo Setting the Environment Path
SET Key="HKCU\Environment"
FOR /F "usebackq tokens=2*" %%A IN (`REG QUERY %Key% /v PATH`) DO Set CurrPath=%%B
echo ;%CurrPath%; | find /C /I ";%PROGRAMFILES%\platform-tools;" > temp.txt
set /p VV=<temp.txt
if "%VV%" EQU "0" (
SETX PATH "%PROGRAMFILES%\platform-tools;%CurrPath%" > nul 2>&1
)

:: https://stackoverflow.com/a/32596713/2437224
:: https://superuser.com/a/1278250/1200777
:: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/copy
:: Creating 'Latest ADB Launcher' at Desktop
echo Creating 'Latest ADB Launcher' at Desktop
For /F "delims=" %%G In ('PowerShell -executionpolicy bypass -Command "[environment]::GetFolderPath('Desktop')"') Do Set "DESKTOP=%%G"
copy /y "Latest ADB Launcher.bat" %DESKTOP% > nul 2>&1

:: Deleting the temporary directory
echo Deleting the temporary folder
popd
rmdir /Q /S temporarydir > nul 2>&1

:: Source:https://stackoverflow.com/questions/7308586/using-batch-echo-with-special-characters
:: Escape special chars in echo
:: Installation done
echo.
echo.
echo Hurray!! Installation Complete, Now you can run ADB and Fastboot commands
echo using Command Prompt, Beginners can use 'Latest ADB Launcher' located
echo at Desktop, to flash TWRP, GSI etc
PowerShell -executionpolicy bypass -Command "Start-Sleep -s 10" > nul 2>&1
echo.
echo Note: In Case fastboot mode is not getting detected, just connect your phone
echo in fastboot mode and run the installer tool again.
PowerShell -executionpolicy bypass -Command "Start-Sleep -s 4" > nul 2>&1
echo.
echo This tool is Sponsored by SendLetters, the Easiest way to Send Letters
echo and Documents Physically Anywhere in the World
PowerShell -executionpolicy bypass -Command "Start-Sleep -s 4" > nul 2>&1
echo.
echo press any key to exit
pause > NUL
