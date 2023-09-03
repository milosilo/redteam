
# Check-Persistence-Final.ps1
# This script checks for both common and advanced persistence vulnerabilities on a Windows host.
# Each check is accompanied by a brief explanation of how the vulnerability could be abused by an attacker.
# Only run this script on systems you're authorized to access.

# Function to print header
Function Print-Header ($text, $explanation) {
    Write-Host ""
    Write-Host "=== $text ==="
    Write-Host "Vulnerability Explanation: $explanation"
}

# Basic Checks

# Scheduled Tasks
Print-Header "Checking Scheduled Tasks" "Attackers can use scheduled tasks to execute malicious code at specific intervals."
Get-ScheduledTask | Where-Object {$_.Actions -like "*powershell*"} | Select-Object TaskName, TaskPath, Actions

# Registry Run Keys
Print-Header "Checking Registry Run Keys" "Attackers can add keys to auto-start malware during boot."
Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run'

# Startup Programs
Print-Header "Checking Startup Programs" "Startup programs can be manipulated to launch malware."
Get-CimInstance Win32_StartupCommand | Select-Object Name, command

# WMI Event Subscriptions
Print-Header "Checking WMI Event Subscriptions" "WMI can be used for event-triggered backdoors."
Get-WmiObject -Namespace root\Subscription -Class __EventConsumer

# Advanced Checks

# COM Hijacking Opportunities
Print-Header "Checking for COM Hijacking Opportunities" "Attackers can replace COM objects to achieve persistence."
Get-ChildItem 'HKLM:\Software\Classes\CLSID' -Recurse | Get-ItemProperty -Name '(Default)'

# Named Pipes
Print-Header "Checking for Named Pipes" "Named pipes can be used for inter-process communication by malware."
Get-ChildItem '\\.\pipe\' | Select-Object Name

# Security Support Providers
Print-Header "Checking for Security Support Providers" "SSP DLLs can be added for credential stealing."
Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Security Packages' | Select-Object -ExpandProperty '(default)'

# AppCert DLLs
Print-Header "Checking for AppCert DLLs" "AppCert DLLs can be used to inject code into processes."
Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager' -Name 'AppCertDlls'

# AppInit DLLs
Print-Header "Checking for AppInit DLLs" "These DLLs are loaded into every user interface process, ideal for keylogging."
Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows' -Name 'AppInit_DLLs'

# EAF Exceptions
Print-Header "Checking for EAF Exceptions" "EAF exceptions can be used to bypass anti-exploitation features."
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options' | Select-Object -ExpandProperty 'MitigationOptions'

# Script completed
Write-Host ""
Write-Host "=== Script Completed. Review the results very carefully. ==="

# Additional Checks

# Check for BITS Jobs
Print-Header "Checking for BITS Jobs" "BITS can be abused to download or upload files quietly."
Get-BitsTransfer | Select-Object DisplayName, TransferType

# Check for Sticky Keys Exploit
Print-Header "Checking for Sticky Keys Exploit" "Attackers can replace sethc.exe to get a shell with SYSTEM privileges."
If (Test-Path 'C:\Windows\System32\sethc.exe') { Write-Host "sethc.exe exists" } else { Write-Host "sethc.exe replaced" }

# Check for Hidden Files
Print-Header "Checking for Hidden Files" "Hidden files can be used to store payloads or logs."
Get-ChildItem -Path 'C:\' -Hidden

# Check for Unsigned Drivers
Print-Header "Checking for Unsigned Drivers" "Unsigned drivers can be loaded to compromise system integrity."
Get-WindowsDriver -Online | Where-Object {$_.Inbox -eq $False} | Select-Object ProviderName, ClassName

# Check for Unusual Network Connections
Print-Header "Checking for Unusual Network Connections" "Unusual network connections could indicate command and control activity."
Get-NetTCPConnection | Where-Object {$_.State -eq "Established"} | Select-Object LocalAddress, RemoteAddress, State

# Check for Unusual Firewall Rules
Print-Header "Checking for Unusual Firewall Rules" "Manipulated firewall rules can allow or block specific traffic for an attacker."
Get-NetFirewallRule | Where-Object {$_.Enabled -eq $True} | Select-Object Name, Action

# Check for Shim Databases
Print-Header "Checking for Shim Databases" "Application Compatibility Shims can be used to redirect file and registry requests."
Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Custom' | Select-Object -Property PSChildName

# Script Completed with Additional Checks
Write-Host ""
Write-Host "=== Script Completed with Additional Checks. Review the results very carefully. ==="
