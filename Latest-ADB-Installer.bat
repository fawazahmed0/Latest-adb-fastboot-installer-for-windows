@echo off

:: Initial message
echo ====================================================
echo Latest ADB Fastboot and USB Driver Installer tool
echo By fawazahmed0 @ xda-developers
echo ====================================================
:: echo. is newline
echo.

:: Source: https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
:: Source: https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
:: batch code to request admin previleges, if no admin previleges
net session >nul 2>&1
if NOT %errorLevel% == 0 (
powershell start -verb runas '%0' am_admin & exit /b
)


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
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/android/repository/platform-tools-latest-windows.zip', 'adbinstallerpackage.zip')"

echo Downloading latest usb drivers
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/android/repository/latest_usb_driver_windows.zip', 'google_usb_driver.zip')"
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/fawazahmed0/Latest-adb-fastboot-installer-for-windows/master/files/google64inf', 'google64inf')"
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/fawazahmed0/Latest-adb-fastboot-installer-for-windows/master/files/google86inf', 'google86inf')"
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/fawazahmed0/Latest-adb-fastboot-installer-for-windows/master/files/Stringsvals', 'Stringsvals')"
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/fawazahmed0/Latest-adb-fastboot-installer-for-windows/master/files/kmdf', 'kmdf')"

::Fetching devcon.exe and powershell script
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/fawazahmed0/Latest-adb-fastboot-installer-for-windows/master/files/fetch_hwid.ps1', 'fetch_hwid.ps1')"
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/fawazahmed0/Latest-adb-fastboot-installer-for-windows/raw/master/files/devcon.exe', 'devcon.exe')"

:: Uninstalling/removing the platform tools older version, if they exists and  killing instances of adb if they are running
echo Uninstalling older version
adb kill-server > nul 2>&1
rmdir /Q /S "C:\Program Files\platform-tools" > nul 2>&1

:: Source: https://stackoverflow.com/questions/37814037/how-to-unzip-a-zip-file-with-powershell-version-2-0
:: Extracting the .zip file to installation location
echo Installing the files
PowerShell -Command "& {$shell_app=new-object -com shell.application; $filename = \"adbinstallerpackage.zip\"; $zip_file = $shell_app.namespace((Get-Location).Path + \"\$filename\"); $destination = $shell_app.namespace(\"C:\Program Files\"); $destination.Copyhere($zip_file.items());}"
echo Installing USB drivers
PowerShell -Command "& {$shell_app=new-object -com shell.application; $filename = \"google_usb_driver.zip\"; $zip_file = $shell_app.namespace((Get-Location).Path + \"\$filename\"); $destination = $shell_app.namespace((Get-Location).Path); $destination.Copyhere($zip_file.items());}"

:: Source: https://stackoverflow.com/questions/1804751/use-bat-to-start-powershell-script
:: Calling powershell script to fetch the unknown usb driver hwids and inserting that in inf file
powershell .\fetch_hwid.ps1

:: Source: https://github.com/koush/UniversalAdbDriver
:: Source: https://forum.xda-developers.com/google-nexus-5/development/adb-fb-apx-driver-universal-naked-t2513339
:: Source: https://stackoverflow.com/questions/60034/how-can-you-find-and-replace-text-in-a-file-using-the-windows-command-line-envir
:: Source: https://stackoverflow.com/questions/51060976/search-multiline-text-in-a-file-using-powershell
:: Source: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content?view=powershell-6
:: Combining multiple inf Files to support all the devices
powershell -Command "gc Stringsvals | Add-Content usb_driver\android_winusb.inf"
powershell -Command "(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Google.NTamd64\]', (gc google64inf | Out-String) | Out-File usb_driver\android_winusb.inf"
powershell -Command "(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Google.NTx86\]', (gc google86inf | Out-String) | Out-File usb_driver\android_winusb.inf"
powershell -Command "(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Strings\]', (gc kmdf | Out-String) | Out-File usb_driver\android_winusb.inf"

:: Fetching unsigned driver installer tool
echo Downloading unsigned driver installer tool
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/fawazahmed0/windows-unsigned-driver-installer/master/unsigned_driver_installer.bat', 'usb_driver\unsigned_driver_installer.bat')"

:: Source: https://stackoverflow.com/questions/1103994/how-to-run-multiple-bat-files-within-a-bat-file
:: https://stackoverflow.com/questions/3583565/how-to-skip-pause-in-batch-file
:: Running unsigned_driver_installer tool
pushd usb_driver
echo.
echo | call unsigned_driver_installer.bat
popd

:: Source: https://stackoverflow.com/questions/51636175/using-batch-file-to-add-to-path-environment-variable-windows-10
:: Source: https://stackoverflow.com/questions/141344/how-to-check-if-directory-exists-in-path/8046515
:: Source: https://stackoverflow.com/questions/9546324/adding-directory-to-path-environment-variable-in-windows
:: Setting the path Environment Variable
echo Setting the Environment
SET Key="HKCU\Environment"
FOR /F "usebackq tokens=2*" %%A IN (`REG QUERY %Key% /v PATH`) DO Set CurrPath=%%B
echo ;%CurrPath%; | find /C /I ";C:\Program Files\platform-tools;" > temp.txt
set /p VV=<temp.txt
if "%VV%" EQU "0" (
SETX PATH "C:\Program Files\platform-tools;%CurrPath%" > nul 2>&1
)

:: Deleting the temporary directory
echo Deleting the temporary folder
popd
rmdir /Q /S temporarydir

:: Installation done
echo.
echo.
echo Installation complete, press any key to exit
pause > NUL
