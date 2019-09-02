#Requires -RunAsAdministrator
Set-StrictMode -Version Latest

# github.com/OlJohnny | 2019


# Makro IPs:
$makro1 = "8.8.8.8"
$makro2 = "1.1.1.1"


Write-Host -ForegroundColor Cyan "Welcome to Powershell-DNS-Switcher."
Get-DnsClientServerAddress -AddressFamily IPv4

Write-Host ""
Write-Host -NoNewline -ForegroundColor Cyan "Please enter the 'Interface Index' of the Interface you wish to edit: "
$SelectedInterfaceIndex = Read-Host

Write-Host ""
Write-Host -ForegroundColor Cyan " [0] Reset"
Write-Host -ForegroundColor Cyan " [1] $makro1"
Write-Host -ForegroundColor Cyan " [2] $makro2"
Write-Host -NoNewline -ForegroundColor Cyan "Please enter the DNS Server IP or shortcut you wish to use: "
$SelectedDNSIP = Read-Host

$SelectedDNSIP_use = "0.0.0.0"
if ($SelectedDNSIP -eq 0) { $SelectedDNSIP_use = "Reset" }
elseif ($SelectedDNSIP -eq 1) { $SelectedDNSIP_use = $makro1 }
elseif ($SelectedDNSIP -eq 2) { $SelectedDNSIP_use = $makro2 }
else { $SelectedDNSIP_use = "$SelectedDNSIP" }

Write-Host ""
Write-Host -ForegroundColor Cyan "Setting DNS Server IP of Adapter $SelectedInterfaceIndex to $SelectedDNSIP_use ..."

if ($SelectedDNSIP_use -eq "Reset") {
    Set-DnsClientServerAddress -InterfaceIndex $SelectedInterfaceIndex -ResetServerAddresses
} else {
    Set-DnsClientServerAddress -InterfaceIndex $SelectedInterfaceIndex -ServerAddresses $SelectedDNSIP_use
}

Write-Host ""
Write-Host -ForegroundColor Cyan "Confirming..."
Get-DnsClientServerAddress -AddressFamily IPv4 -InterfaceIndex $SelectedInterfaceIndex

Write-Host ""
Write-Host -ForegroundColor Cyan "Exiting..."