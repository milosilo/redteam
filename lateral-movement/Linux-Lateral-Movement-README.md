
# Check-LateralMovement-Enhanced.sh

## Overview
This Bash script is designed to check for lateral movement vulnerabilities on a Linux host. The script includes basic and enhanced checks and is intended for use by security professionals. Only run this script on systems where you have authorized access.

## Features
The script performs a wide range of checks, each designed to identify potential lateral movement vulnerabilities.

### Basic Checks

#### SSH Configurations
- Checks for SSH server configurations.
- Vulnerability Explanation: SSH configurations can be exploited for lateral movement.

#### Open Ports
- Checks for open ports on the system.
- Vulnerability Explanation: Open ports can be exploited for lateral movement.

#### Active Connections
- Checks for active network connections.
- Vulnerability Explanation: Active connections can be exploited.

#### IPTables Rules
- Checks for IPTables rules.
- Vulnerability Explanation: IPTables rules can be manipulated.

#### Running Services
- Checks for running services on the system.
- Vulnerability Explanation: Running services can be exploited.

### Enhanced Checks

#### NFS Shares
- Checks for NFS shares on the system.
- Vulnerability Explanation: NFS shares can be exploited for lateral movement.

#### Samba Shares
- Checks for Samba shares on the system.
- Vulnerability Explanation: Samba shares can be exploited.

#### ARP Cache
- Checks for ARP cache entries.
- Vulnerability Explanation: ARP cache can reveal network structure.

#### SNMP Configurations
- Checks for SNMP configurations.
- Vulnerability Explanation: SNMP can be exploited for information gathering.

#### Kerberos Tickets
- Checks for Kerberos tickets on the system.
- Vulnerability Explanation: Kerberos tickets can be exploited.

## Usage
Run this script with administrative privileges:

```
sudo ./Check-LateralMovement-Enhanced.sh
```

## Disclaimer
This script is intended for educational and professional use only. Always consult with your organization's legal and compliance teams before running any security assessments.
