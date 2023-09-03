
# Check-PrivEscalation-Enhanced.ps1

## Overview
This PowerShell script is designed to check for privilege escalation vulnerabilities on a Windows host. It includes basic, advanced, and very advanced checks and is intended for use by security professionals. Only run this script on systems where you have authorized access.

## Features
The script performs a wide range of checks, each designed to identify potential privilege escalation vulnerabilities.

### Basic Checks

#### Administrative Users
- Checks for members of the Administrators group.
- Vulnerability Explanation: Being part of this group allows escalation.

#### UAC Settings
- Checks for User Account Control settings.
- Vulnerability Explanation: Low settings can be exploited for escalation.

#### Weak Folder Permissions
- Checks for folder permissions in "C:\Program Files\".
- Vulnerability Explanation: Weak permissions can allow unauthorized modifications.

#### Stored Passwords
- Checks for stored passwords in the system.
- Vulnerability Explanation: Stored passwords can be exploited.

### Advanced Checks

#### Unpatched Vulnerabilities
- Checks for unpatched system vulnerabilities.
- Vulnerability Explanation: Unpatched systems are susceptible to known exploits.

#### Token Privileges
- Checks for token privileges of the current user.
- Vulnerability Explanation: Highly privileged tokens can be exploited.

#### Clear-Text Passwords in Memory
- Checks for clear-text passwords stored in lsass.exe process memory.
- Vulnerability Explanation: These passwords can be dumped and exploited.

#### Service Executables with Weak Permissions
- Checks for weak permissions on service executables.
- Vulnerability Explanation: Weak permissions can allow unauthorized modifications.

### Very Advanced Checks

#### Kernel Drivers
- Checks for installed kernel drivers.
- Vulnerability Explanation: Unsigned or vulnerable drivers can be exploited.

#### Debugging Permissions
- Checks for processes with debugging permissions.
- Vulnerability Explanation: Allows for manipulation of other processes.

#### Insecurely Configured Services
- Checks for services running as "LocalSystem".
- Vulnerability Explanation: Insecure configurations can be exploited.

#### Unusual Scheduled Tasks
- Checks for unusual scheduled tasks running as SYSTEM.
- Vulnerability Explanation: These tasks might be exploitable.

### Enhanced Checks

#### AutoElevate Settings
- Checks for AutoElevate settings in the registry.
- Vulnerability Explanation: Can be exploited to elevate permissions.

#### AlwaysInstallElevated Registry Key
- Checks for this registry key setting.
- Vulnerability Explanation: Allows for elevated installation of programs.

#### Impersonation Tokens
- Checks for impersonation tokens.
- Vulnerability Explanation: Can be exploited to impersonate other users.

#### Modifiable Services
- Checks for services running as "LocalService".
- Vulnerability Explanation: These services may have insecure configurations.

#### DLL Hijacking Opportunities
- Checks for potential DLL hijacking in System32.
- Vulnerability Explanation: Allows for unauthorized code execution.

#### SeDebugPrivilege
- Checks for this specific privilege.
- Vulnerability Explanation: Allows for debugging and potential manipulation of other processes.

#### Unquoted Service Paths
- Checks for services with unquoted paths.
- Vulnerability Explanation: Can be exploited to run arbitrary code.

#### Group Policy Preferences Passwords
- Checks for passwords in Group Policy Preferences.
- Vulnerability Explanation: Stored passwords can be exploited.

## Usage
Run this script with administrative privileges:

```
.\Check-PrivEscalation-Enhanced.ps1
```

## Disclaimer
This script is intended for educational and professional use only. Always consult with your organization's legal and compliance teams before running any security assessments.
