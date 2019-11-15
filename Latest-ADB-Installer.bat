@echo off

:: Initial message
echo ====================================================
echo Latest ADB and Fastboot Driver Installer tool
echo By fawazahmed0 @ xda-developers
echo ====================================================
:: echo. is newline
echo.

:: Source: https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
:: batch code to request admin previleges
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

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
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://online.mediatek.com/Public Documents/MTK_Android_USB_Driver.zip', 'mtk_usb_driver.zip')"

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
PowerShell -Command "& {$shell_app=new-object -com shell.application; $filename = \"mtk_usb_driver.zip\"; $zip_file = $shell_app.namespace((Get-Location).Path + \"\$filename\"); $destination = $shell_app.namespace((Get-Location).Path); $destination.Copyhere($zip_file.items());}"

::Using Mediatek .inf file
copy MTK_Android_USB_Driver\*.inf usb_driver\*.inf /Y > nul 2>&1

:: Source: https://stackoverflow.com/questions/22496847/installing-a-driver-inf-file-from-command-line
:: Installing USB Drivers
cd usb_driver
pnputil -i -a *.inf > nul 2>&1

:: Source: https://stackoverflow.com/questions/51636175/using-batch-file-to-add-to-path-environment-variable-windows-10
:: Setting the path Environment Variable
echo Setting the Environment
setx path "C:\Program Files\platform-tools;%path%;" > nul 2>&1

:: Deleting the temporary directory
echo Deleting the temporary folder
popd
rmdir /Q /S temporarydir

:: Installation done
echo.
echo.
echo Installation complete, press any key to exit
pause > NUL
