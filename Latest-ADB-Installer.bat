@echo off

:: Source: https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
:: batch code to request admin previleges
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: Source: https://stackoverflow.com/questions/4619088/windows-batch-file-file-download-from-a-url
:: Downloading the latest platform tools from google
echo Downloading the latest adb and fastboot tools
PowerShell -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/android/repository/platform-tools-latest-windows.zip', 'adbinstallerpackage.zip')"

:: Uninstalling/removing the platform tools older version, if they exists
echo Uninstalling older version
rmdir /Q /S "C:\Program Files\platform-tools"

:: Source: https://stackoverflow.com/questions/37814037/how-to-unzip-a-zip-file-with-powershell-version-2-0
:: Extrating the .zip file to installation location
echo Installing the files
PowerShell -Command "& {$shell_app=new-object -com shell.application; $filename = \"adbinstallerpackage.zip\"; $zip_file = $shell_app.namespace((Get-Location).Path + \"\$filename\"); $destination = $shell_app.namespace(\"C:\Program Files\"); $destination.Copyhere($zip_file.items());}"

:: Source: https://stackoverflow.com/questions/51636175/using-batch-file-to-add-to-path-environment-variable-windows-10
:: Setting the path Environment Variable
echo Setting the Environment
setx path "C:\Program Files\platform-tools;%path%;"

:: Deleting the downloaded adbinstallerpackage.zip
echo Deleting the temporary files
del /f adbinstallerpackage.zip

:: Installation done
echo ====================================================
echo Latest ADB and Fastboot Driver Installer tool
echo By fawazahmed0 @ xda-developers
echo Installation complete, press any key to exit
pause > NUL
