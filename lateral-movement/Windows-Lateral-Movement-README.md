
# Check-LateralMovement-Enhanced.ps1

## Overview
This PowerShell script is designed to check for lateral movement vulnerabilities on a Windows host. The script includes basic, advanced, and very advanced checks and is intended for use by security professionals. Only run this script on systems where you have authorized access.

## Features
The script performs a wide range of checks, each designed to identify potential lateral movement vulnerabilities.

### Basic Checks

#### Open Shares
- Checks for open shares on the system.
- Vulnerability Explanation: Open shares can be accessed by unauthorized users.

#### Logged In Users
- Checks for users currently logged into the system.
- Vulnerability Explanation: Information on logged-in users can be exploited.

#### Running Processes
- Checks for running processes on the system.
- Vulnerability Explanation: Running processes could be vulnerable to injection.

### Advanced Checks

#### Remote Desktop Configurations
- Checks for Remote Desktop settings.
- Vulnerability Explanation: Misconfigured settings can allow unauthorized access.

#### PowerShell Remoting Configurations
- Checks for PowerShell remoting settings.
- Vulnerability Explanation: Misconfigured settings can allow unauthorized access.

#### SMB Shares
- Checks for SMB shares on the system.
- Vulnerability Explanation: SMB shares can be exploited for lateral movement.

### Very Advanced Checks

#### LSA Secrets
- Checks for Local Security Authority secrets.
- Vulnerability Explanation: LSA Secrets can store sensitive information.

#### DCOM Applications
- Checks for DCOM application settings.
- Vulnerability Explanation: DCOM can be exploited for remote code execution.

#### Trust Relationships
- Checks for trust relationships between systems.
- Vulnerability Explanation: Trust relationships can be exploited.

#### SNMP Configurations
- Checks for SNMP settings on the system.
- Vulnerability Explanation: SNMP can be exploited for information gathering.

### Enhanced Checks

#### Cached Credentials
- Checks for cached credentials on the system.
- Vulnerability Explanation: Cached credentials can be exploited.

#### Active Network Connections
- Checks for active network connections.
- Vulnerability Explanation: Active connections can be exploited.

#### Scheduled Tasks
- Checks for scheduled tasks on the system.
- Vulnerability Explanation: Scheduled tasks can be exploited.

#### Unrestricted PowerShell Execution Policy
- Checks for PowerShell execution policy settings.
- Vulnerability Explanation: Unrestricted policies can be exploited.

#### Service Account Configurations
- Checks for service account configurations.
- Vulnerability Explanation: Misconfigured service accounts can be exploited.

#### Firewall Rules
- Checks for firewall rules on the system.
- Vulnerability Explanation: Misconfigured rules can be exploited.

#### WMI Queries
- Checks for WMI query results.
- Vulnerability Explanation: WMI can be exploited for information gathering.

#### Active Directory Group Memberships
- Checks for Active Directory group memberships.
- Vulnerability Explanation: Group memberships can be exploited.

## Usage
Run this script with administrative privileges:

```
.\Check-LateralMovement-Enhanced.ps1
```

## Disclaimer
This script is intended for educational and professional use only. Always consult with your organization's legal and compliance teams before running any security assessments.
