
# Check-LateralMovement.ps1
# This script checks for lateral movement vulnerabilities on a Windows host.
# The script includes basic, advanced, and very advanced checks.
# Only run this script on systems you're authorized to access.

# Function to print header
Function Print-Header ($text, $explanation) {
    Write-Host ""
    Write-Host "=== $text ==="
    Write-Host "Vulnerability Explanation: $explanation"
}

# Basic Checks

# Check for Open Shares
Print-Header "Checking for Open Shares" "Open shares can be accessed by unauthorized users."
net share

# Check for Logged In Users
Print-Header "Checking for Logged In Users" "Information on logged-in users can be exploited."
query user

# Check for Running Processes
Print-Header "Checking for Running Processes" "Running processes could be vulnerable to injection."
Get-Process

# Advanced Checks

# Check for Remote Desktop Configurations
Print-Header "Checking for Remote Desktop Configurations" "Misconfigured RDP settings can allow unauthorized access."
Get-WmiObject -Class Win32_TerminalServiceSetting -Namespace root\CIMv2\TerminalServices

# Check for PowerShell Remoting Configurations
Print-Header "Checking for PowerShell Remoting Configurations" "Misconfigured PowerShell remoting can allow unauthorized access."
Get-PSSessionConfiguration

# Check for SMB Shares
Print-Header "Checking for SMB Shares" "SMB shares can be exploited for lateral movement."
Get-SmbShare

# Very Advanced Checks

# Check for LSA Secrets
Print-Header "Checking for LSA Secrets" "LSA Secrets can store sensitive information."
reg query "HKLM\SECURITY\Policy\Secrets"

# Check for DCOM Applications
Print-Header "Checking for DCOM Applications" "DCOM can be exploited for remote code execution."
Get-WmiObject -Query "SELECT * FROM Win32_DCOMApplicationSetting"

# Check for Trust Relationships
Print-Header "Checking for Trust Relationships" "Trust relationships between systems can be exploited."
Get-ADTrust -Filter *

# Check for SNMP Configurations
Print-Header "Checking for SNMP Configurations" "SNMP can be exploited for information gathering."
Get-WindowsFeature -Name SNMP*

# Script Completed with Multiple Checks
Write-Host ""
Write-Host "=== Script Completed with Multiple Checks. Review the results very carefully. ==="

# Enhanced Checks for Lateral Movement

# Function to print header for enhanced checks
Function Print-EnhancedHeader ($text) {
    Write-Host ""
    Write-Host "=== Enhanced: $text ==="
}

# Check for Cached Credentials
Print-EnhancedHeader "Checking for Cached Credentials"
Get-WmiObject -Class Win32_CacheMemory

# Check for Active Network Connections
Print-EnhancedHeader "Checking for Active Network Connections"
netstat -ano

# Check for Scheduled Tasks
Print-EnhancedHeader "Checking for Scheduled Tasks"
schtasks /query

# Check for Unrestricted PowerShell Execution Policy
Print-EnhancedHeader "Checking for Unrestricted PowerShell Execution Policy"
Get-ExecutionPolicy

# Check for Service Account Configurations
Print-EnhancedHeader "Checking for Service Account Configurations"
Get-WmiObject -Class Win32_Service | Select-Object DisplayName, StartName

# Check for Firewall Rules
Print-EnhancedHeader "Checking for Firewall Rules"
Get-NetFirewallRule

# Check for WMI Queries
Print-EnhancedHeader "Checking for WMI Queries"
Get-WmiObject -Query "SELECT * FROM Win32_Process" | Select-Object Name

# Check for Active Directory Group Memberships
Print-EnhancedHeader "Checking for Active Directory Group Memberships"
Get-ADGroupMember -Identity "Domain Admins"

# Script completed with enhanced checks
Print-EnhancedHeader "Enhanced Checks Completed. Review the results very carefully."
