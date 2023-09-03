
# Check-PrivEscalation.ps1
# This script checks for privilege escalation vulnerabilities on a Windows host.
# The script includes basic, advanced, and very advanced checks.
# Only run this script on systems you're authorized to access.

# Function to print header
Function Print-Header ($text, $explanation) {
    Write-Host ""
    Write-Host "=== $text ==="
    Write-Host "Vulnerability Explanation: $explanation"
}

# Basic Checks

# Check for Administrative Users
Print-Header "Checking for Administrative Users" "Being part of the Administrators group allows escalation."
net localgroup Administrators

# Check for UAC Settings
Print-Header "Checking for UAC Settings" "Low UAC settings can be exploited for escalation."
Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin'

# Check for Weak Folder Permissions
Print-Header "Checking for Weak Folder Permissions" "Weak permissions can allow modification of executable files."
icacls "C:\Program Files\*"

# Check for Stored Passwords
Print-Header "Checking for Stored Passwords" "Stored passwords can be exploited for privilege escalation."
cmdkey /list

# Advanced Checks

# Check for Unpatched Vulnerabilities
Print-Header "Checking for Unpatched Vulnerabilities" "Unpatched systems are susceptible to known exploits."
systeminfo

# Check for Token Privileges
Print-Header "Checking for Token Privileges" "Highly privileged tokens can be exploited."
whoami /priv

# Check for Clear-Text Passwords in Memory
Print-Header "Checking for Clear-Text Passwords in Memory" "Passwords stored in memory can be dumped."
Get-Process -Name lsass

# Check for Service Executables with Weak Permissions
Print-Header "Checking for Service Executables with Weak Permissions" "Weak permissions on service executables can allow tampering."
icacls "C:\Windows\System32\*.exe"

# Very Advanced Checks

# Check for Kernel Drivers
Print-Header "Checking for Kernel Drivers" "Unsigned or vulnerable drivers can be exploited."
driverquery

# Check for Debugging Permissions
Print-Header "Checking for Debugging Permissions" "Debugging permissions allow manipulating other processes."
Get-Process | Where-Object {$_.StartInfo.EnvironmentVariables["__COMPAT_LAYER"] -eq "RunAsInvoker"}

# Check for Insecurely Configured Services
Print-Header "Checking for Insecurely Configured Services" "Services running as SYSTEM but configured insecurely can be exploited."
Get-WmiObject win32_service | Where-Object {$_.StartName -eq "LocalSystem"}

# Check for Unusual Scheduled Tasks
Print-Header "Checking for Unusual Scheduled Tasks" "Scheduled tasks running as SYSTEM might be exploitable."
schtasks /query /fo LIST /v

# Script Completed with Multiple Checks
Write-Host ""
Write-Host "=== Script Completed with Multiple Checks. Review the results very carefully. ==="

# Enhanced Checks for Privilege Escalation

# Function to print header for enhanced checks
Function Print-EnhancedHeader ($text) {
    Write-Host ""
    Write-Host "=== Enhanced: $text ==="
}

# Check for AutoElevate Settings
Print-EnhancedHeader "Checking for AutoElevate Settings"
Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA'

# Check for AlwaysInstallElevated Registry Key
Print-EnhancedHeader "Checking for AlwaysInstallElevated Registry Key"
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer' -Name 'AlwaysInstallElevated'

# Check for Impersonation Tokens
Print-EnhancedHeader "Checking for Impersonation Tokens"
whoami /all

# Check for Modifiable Services
Print-EnhancedHeader "Checking for Modifiable Services"
Get-WmiObject win32_service | Where-Object {$_.StartName -eq "LocalService"}

# Check for DLL Hijacking Opportunities
Print-EnhancedHeader "Checking for DLL Hijacking Opportunities"
Get-ChildItem 'C:\Windows\System32' -Filter *.dll | Select-Object Name

# Check for SeDebugPrivilege
Print-EnhancedHeader "Checking for SeDebugPrivilege"
whoami /priv | Select-String 'SeDebugPrivilege'

# Check for Unquoted Service Paths
Print-EnhancedHeader "Checking for Unquoted Service Paths"
Get-WmiObject win32_service | Where-Object {$_.PathName -notlike '*"*'}

# Check for Group Policy Preferences Passwords
Print-EnhancedHeader "Checking for Group Policy Preferences Passwords"
Get-ChildItem 'C:\Windows\SYSVOL\sysvol' -Recurse -Filter Groups.xml

# Script completed with enhanced checks
Print-EnhancedHeader "Enhanced Checks Completed. Review the results very carefully."
