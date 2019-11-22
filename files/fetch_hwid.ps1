# Using devcon to fetch unknown devices hwids to put in inf file
# Source: https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/devcon-examples#ddk_example_1_find_all_hardware_ids_tools
$result = ./devcon.exe drivernodes "@USB\VID*" "@USB\SAMSUNG*" | select-string -pattern 'No driver nodes found for this device' -Context 2,0 | findstr USB* | Out-String;
if($result.length -gt 0){
$result = $result.Substring(0,$result.LastIndexOf('\')).trim();
$result = "%CompositeAdbInterface%     = USB_Install, " + $result
$result64 = "[Google.NTamd64]`n" + $result;
$result86 = "[Google.NTx86]`n" + $result;

(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Google.NTamd64\]', $result64 | Out-File usb_driver\android_winusb.inf
(gc usb_driver\android_winusb.inf | Out-String) -replace '\[Google.NTx86\]', $result86 | Out-File usb_driver\android_winusb.inf


}
