
# Check-Persistence-Final-Combined.ps1

## Overview
This PowerShell script is designed to check for both common and advanced persistence vulnerabilities on a Windows host. It is intended for use by security professionals to secure systems and should only be run on systems where you have authorized access.

## Features
The script performs a wide range of checks, each accompanied by a brief explanation of how the vulnerability could be abused by an attacker.

### Basic Checks

#### Scheduled Tasks
- Checks for suspicious scheduled tasks.
- Vulnerability Explanation: Attackers can use scheduled tasks to execute malicious code at specific intervals.

#### Registry Run Keys
- Checks for suspicious registry run keys.
- Vulnerability Explanation: Attackers can add keys to auto-start malware during boot.

#### Startup Programs
- Checks for suspicious startup programs.
- Vulnerability Explanation: Startup programs can be manipulated to launch malware.

#### WMI Event Subscriptions
- Checks for WMI Event Subscriptions.
- Vulnerability Explanation: WMI can be used for event-triggered backdoors.

### Advanced Checks

#### COM Hijacking Opportunities
- Checks for COM Hijacking Opportunities.
- Vulnerability Explanation: Attackers can replace COM objects to achieve persistence.

#### Named Pipes
- Checks for Named Pipes.
- Vulnerability Explanation: Named pipes can be used for inter-process communication by malware.

#### Security Support Providers
- Checks for Security Support Providers.
- Vulnerability Explanation: SSP DLLs can be added for credential stealing.

#### AppCert DLLs
- Checks for AppCert DLLs.
- Vulnerability Explanation: AppCert DLLs can be used to inject code into processes.

#### AppInit DLLs
- Checks for AppInit DLLs.
- Vulnerability Explanation: These DLLs are loaded into every user interface process, ideal for keylogging.

#### EAF Exceptions
- Checks for EAF Exceptions.
- Vulnerability Explanation: EAF exceptions can be used to bypass anti-exploitation features.

### Additional Checks

#### BITS Jobs
- Checks for BITS Jobs.
- Vulnerability Explanation: BITS can be abused to download or upload files quietly.

#### Sticky Keys Exploit
- Checks for Sticky Keys Exploit.
- Vulnerability Explanation: Attackers can replace sethc.exe to get a shell with SYSTEM privileges.

#### Hidden Files
- Checks for Hidden Files.
- Vulnerability Explanation: Hidden files can be used to store payloads or logs.

#### Unsigned Drivers
- Checks for Unsigned Drivers.
- Vulnerability Explanation: Unsigned drivers can be loaded to compromise system integrity.

#### Unusual Network Connections
- Checks for Unusual Network Connections.
- Vulnerability Explanation: Unusual network connections could indicate command and control activity.

#### Unusual Firewall Rules
- Checks for Unusual Firewall Rules.
- Vulnerability Explanation: Manipulated firewall rules can allow or block specific traffic for an attacker.

#### Shim Databases
- Checks for Shim Databases.
- Vulnerability Explanation: Application Compatibility Shims can be used to redirect file and registry requests.

## Usage
Run this script with administrative privileges:

```
.\Check-Persistence-Final-Combined.ps1
```

## Disclaimer
This script is intended for educational and professional use only. Always consult with your organization's legal and compliance teams before running any security assessments.
